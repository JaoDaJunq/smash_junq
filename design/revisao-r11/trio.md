# Revisão r11: Marianinha, Dona Canga e Seu Capivas nas 4 arenas

Cópia usada: `scratch/rev_trio` (worktree, sem commit). **Não mexi no código do jogo.** Só criei testes em `game/tests/`.

## Como foi feito
- `tests/trio_diag.tscn` (headless): roda cada especial dos 3 nas 4 arenas, perto da beirada, em cima de cada plataforma (as vitórias-régias também), de frente para a laje da Caatinga, no ar e fora do palco, além de algumas interações (agarrão x cama elástica, Toca do Peba x cama, roda de baiana x quem está pendurado na quina) e um teste de recuperação. Ele mede posições e grava `evidence/revisao-r11/trio_diag.json` (o log fica em `trio_diag.log`). As linhas `[ALERTA]` são os casos suspeitos.
  `"$G" --headless --path game res://tests/trio_diag.tscn [-- <arena 0-3>]` (umas 4 arenas levam ~12 min)
- `tests/trio_shots.tscn` (com janela): tira prints com a câmera parada no ponto do problema e grava em `evidence/revisao-r11/<arena>_<caso>.png`.
  `"$G" --path game --resolution 1920x1080 res://tests/trio_shots.tscn -- [arena] [cama|estandarte|tchibum|roda|arco|fita|extra]`
- Sondas pequenas: `tests/trio_plumas_probe.tscn` (pulso de plumas: posição e z) e `tests/trio_flag_probe.tscn`.
- Tiras dos especiais: `golpes_shots` com 4, 3 e 1, montadas em `evidence/revisao-r11/folha_<id>_<golpe>.png`.

Gravidade: **ALTA** = quebra o golpe, trava alguém ou deixa defeito visual bem à vista (o João vai notar na hora). **MÉDIA** = estranho ou desequilibrado, mas o jogo segue. **BAIXA** = acabamento.

---

## Seu Capivas

### C1. Tchibum do pisão no ar vira uma torre de espirros no ar · ALTA · todas as arenas
- **Como reproduzir:** pule alto e use o especial para baixo no ar (o mergulho).
- **O que acontece:** nasce um `fx_tchibum` **a cada quadro** da queda: 13 espirros caindo de y=-450, e 6 caindo de y=-250, todos no ar (`y_dos_tchibuns` -415, -386, -357...). O print mostra uma coluna de água em cima dele. No pouso, onde deveria ter o tchibum, não nasce um próprio.
- **Evidência:** `evidence/revisao-r11/arena_tchibum_mergulho_b.png` (e `cerrado_`, `caatinga_`, `pantanal_`); `trio_diag.json` "pisão no ar".
- **Causa:** `pesado._down_step` prende `attack_frame = attack.startup` durante o mergulho, e a regra `"impact"` do `move_fx.gd` dispara sempre que `f == a.startup`.
- **Correção:**
```gdscript
# move_fx.gd: "impact" dispara uma vez por golpe e pode valer só no chão
var _fired := {}
...
"impact":
    if id == r["move"] and f == a.startup and not _fired.has(r) \
            and not (r.get("ground_only", false) and fighter._attack_in_air):
        _fired[r] = true
        _spawn(r)
...
if id != _last_attack:
    _hold_t = 0
    _fired.clear()
# RULES seu_capivas: {"on": "impact", ..., "ground_only": true}
# Mais uma função pública para disparar de fora:
func spawn_named(fx: String, at := "feet", time := 0.5) -> void:
    if _tex.has(fx): _spawn({"fx": fx, "at": at, "time": time})
```
```gdscript
# pesado.gd, _on_attack_end, ramo "special_down":
if impact and moveset != null:
    _pound_hit(moveset.special_down)
    if move_fx != null:
        move_fx.spawn_named("fx_tchibum", "feet", 0.55)   # o tchibum de verdade, no pouso
```

### C2. A Bufada (★) quase não aparece: 1 só, no 1º quadro · ALTA · todas
- **Como reproduzir:** segure o especial neutro até a carga encher.
- **O que acontece:** só nasce 1 bufada (no quadro 1). Durante a carga inteira (até 60 quadros) não aparece mais nenhuma, e ela não cresce com a carga como pede o `efeitos-especiais.md` ("maior quanto mais carga").
- **Evidência:** `trio_diag.json` "pancada carregada: bufadas" = 1 em todas as arenas; `caatinga_carregada_meio.png`.
- **Causa:** a regra `"charging"` só conta quadro par (`f % 2 == 0`), e a carga prende `attack_frame = startup - 1 = 13`, que é ímpar.
- **Correção:**
```gdscript
"charging":
    if id == r["move"] and fighter.charge_ratio() >= 0.0:
        _hold_t += 1
        if _hold_t % int(r["every"]) == 1:
            var fx := _spawn(r)
            fx.scale *= 1.0 + 0.6 * fighter.charge_ratio()   # cresce com a carga
```

### C3. Pisão no ar logo depois da beirada = suicídio, sem chance de agarrar a quina · MÉDIA · pior no Cerrado e no Pantanal
- **Como reproduzir:** pule para fora do palco e use o especial para baixo perto da quina.
- **O que acontece:** ele despenca até o KO (estado RESPAWN no teste) e não pega a quina, mesmo passando a 60 px dela. O Cerrado (vão de 256 px entre as ilhas) e o Pantanal (lagoa dos dois lados) punem muito.
- **Evidência:** `trio_diag.json` "pisão no ar logo depois da beirada" (4 arenas).
- **Correção (escolher uma):** (a) durante o mergulho, se `velocity.y >= 0`, chamar `_try_grab_ledge()` em `_down_step`; (b) se um raio para baixo (máscara 3) não achar chão em 600 px, o mergulho acaba e ele cai normal (helpless).

### C4. Ficha diz "Volta ao palco 2", mas é a melhor recuperação do trio · BAIXA
- O pulo do especial para cima sobe ~302 px (UP_RISE 1300, gravidade 2800). O voo da Canga sobe 203 px. No teste de recuperação ele voltou em 22 de 24 tentativas, e a Canga também na maioria. As "falhas" que restaram eram o robô do teste passando da plataforma depois de voltar, então não são problema do personagem.
- **Correção:** ajustar a barrinha da ficha (`game_state.gd`) ou baixar UP_RISE para ~1150. O playtest-01 já dizia que ele "aguenta demais".

### C5. Pisão (chão), agarrão, boia: OK
- O pisão no chão solta 1 tchibum bem no chão. O agarrão lateral na beirada não sai do palco (para 67 px antes da quina). A boia com o copinho na plataforma de volta fica encostada na barra (`pantanal_boia_volta.png`).

---

## Marianinha

### M1. A cama elástica atravessa as plataformas e cai no chão de baixo (ou na água) · ALTA · todas
- **Como reproduzir:** em cima de qualquer plataforma fina, use o especial para cima.
- **O que acontece:** a cama nasce nos pés dela e despenca até o palco de baixo. Ruínas e Cerrado: cai de y=-210/-410 para y=0. Caatinga: a da tábua alta cai em cima da laje. **Pantanal:** a da vitória-régia cai na lagoa e some (y=347/388). Ela quica mas a cama "sumiu", o que não é o que o design promete ("muda o palco").
- **Evidência:** `*_cama_plataforma_caindo.png`, `*_cama_plataforma_depois.png`; `trio_diag.json` "cama em cima de plataforma".
- **Causa:** `_place_trampoline` e `CamaElastica._physics_process` usam só `LAYER_STAGE` no raio. As plataformas estão na camada 2.
- **Correção:**
```gdscript
# marianinha.gd
var q := PhysicsRayQueryParameters2D.create(global_position, global_position + Vector2(0, 260), LAYER_STAGE | LAYER_PLATFORM)
# cama_elastica.gd: máscara 3 e grudar na plataforma (a vitória-régia se mexe)
var _floor: Node2D
var _floor_off := Vector2.ZERO
...
var q := PhysicsRayQueryParameters2D.create(..., Fighter.LAYER_STAGE | Fighter.LAYER_PLATFORM)
...
else:
    global_position.y = hit.position.y
    _grounded = true
    _floor = hit.collider as Node2D
    _floor_off = global_position - _floor.global_position
...
if _grounded and _floor != null and is_instance_valid(_floor):
    global_position = _floor.global_position + _floor_off
```

### M2. A cama elástica na beirada fica com metade no vazio · MÉDIA · todas
- **Como reproduzir:** de pé encostada na quina, use o especial para cima.
- **O que acontece:** a cama fica centrada nela. Na Ruínas fica em x=548 com a quina em 560, então ~40 px da lona (e uma perna) ficam para fora, flutuando.
- **Evidência:** `zoom_cama_beirada.png`, `arena_cama_beirada.png`, `cerrado_cama_beirada.png`; `trio_diag.json` "cama na beirada" (pé de um lado sem chão nas 4 arenas).
- **Correção:** depois de achar o chão, testar raios curtos em `x ± (WIDTH/2 - 4)`. Se um lado não tiver chão, empurrar a cama para dentro de 4 em 4 px até os dois pés apoiarem (no máximo 60 px; se não der, deixa como está).

### M3. Agarrão no ar em cima da cama elástica = adversário preso para sempre · ALTA · todas
- **Como reproduzir:** a Marianinha deixa a cama no chão. O Seu Capivas agarra ela no ar (especial lado) bem em cima da cama e cai nela.
- **O que acontece:** a cama joga o Capivas para o ar e muda o estado dele para AIR **sem terminar o golpe**. Ele pousa em IDLE ainda com `holding` e com `attack_id = "special_side"`, e a Marianinha fica HELD grudada nele **por 600 quadros (10 s, o teste parou ali)**. Os botões dela não soltam, porque `shorten_grab` só funciona no estado HOLDING.
- **Evidência:** `trio_diag.json` "cama x agarrão do Capivas no ar" (4 arenas, `quadros_presa: 600`).
- **Causa:** `CamaElastica` escreve `who.state = AIR` em qualquer estado (HELD, HOLDING, HITSTUN/hipnose, ATTACK, RESPAWN) e não chama `_end_attack`/`_on_attack_end`. O mesmo acontece com agarrões da Sucuri e do Maracajá e com o "quique" que tira alguém do HITSTUN e da hipnose.
- **Correção:** criar no Fighter um lançamento "oficial" e usar na cama:
```gdscript
# fighter.gd
func bounce_up(speed: float) -> bool:
    if state in [State.HELD, State.HOLDING, State.GRAB, State.LEDGE, State.RESPAWN, State.HITSTUN] or holding != null:
        return false
    if attack != null:
        _end_attack()          # chama _on_attack_end (Capivas solta a carga, Peba fica visível...)
    fast_falling = false
    helpless = false
    jumps_left = air_jumps
    velocity.y = -speed
    state = State.AIR
    jumped.emit(true)
    return true
# cama_elastica.gd: if who.bounce_up(BOUNCE): who.global_position.y = ...; _cool[who] = 0.3; _squash = 1.0
```

### M4. A fita desenhada é quase o dobro do alcance de verdade · ALTA ("cara de golpe")
- **Como reproduzir:** Juba parado a 450 px, Marianinha segura o especial neutro.
- **O que acontece:** a fita encosta no Juba no desenho e não tira nada (0%). A 350 px também tira 0%. Só acerta até ~290 px (ponta em 230 px + raio 60). A folha `fita` vai até a coluna 307 de 320, então a fita desenhada passa de 500 px no jogo.
- **Evidência:** `evidence/revisao-r11/arena_fita_alvo_a_450.png` (a fita no Juba, 0%), `arena_fita_alvo_a_350.png`, `arena_fita_alvo_a_250.png` (15%).
- **Confirmação pedida:** a fita **não corta mais no meio**. `largos.json` = 2 quadros de 320 px, o desenho é contínuo (colunas 18 a 307, sem buraco) e a tira `folha_marianinha_special_neutral.png` mostra a fita inteira em todos os quadros.
- **Correção (escolher uma):** (a) acerto ao longo da fita toda: pontos em `k = 0.2…1.0` até ~480 px (`hitbox_offset.x = 480`, raio 40, dano 1.5 por toque para não ficar forte); o corte de projéteis usa os mesmos pontos; (b) encurtar o desenho com `"visivel": 190` em `largos.json` (a fita fica ~300 px, do tamanho do acerto). Recomendo (a): a fita longa é a cara do golpe.

### M5. Nota 10 com a fita: o bônus é gasto no 2º toque, sem bônus · MÉDIA
- **Como reproduzir:** com a nota em 9, use a fita (vários toques).
- **O que acontece:** o 1º toque leva a nota a 10. O 2º toque da mesma fita gasta o "10" e solta confete, mas o dano continua 2,5 (ninguém ganha os +50%), e a nota volta a 7.
- **Evidência:** `trio_diag.json` "nota 9 + fita" (dano quando gastou: 5,0 = 2 × 2,5).
- **Correção:** o bônus só vale para o **próximo** golpe (outro `attack_id`): guardar `_perfect_from := attack_id` quando chega a 10 e, em `_on_hit_landed`, não gastar enquanto `move_id == _perfect_from`. Também dá para contar a fita inteira como 1 golpe para a nota (só o 1º toque conta).

### M6. Nota 10 com o arco: +50% para sempre · MÉDIA (balanço)
- **Como reproduzir:** chegue à nota 10 e jogue o arco várias vezes.
- **O que acontece:** cada arco tira 9% (6 × 1,5) e a nota 10 **não acaba nunca**, porque o acerto do projétil não chama `_on_hit_landed`. Dá para ficar jogando arco com +50% até usar outro golpe.
- **Evidência:** `trio_diag.json` "nota 10 + arco repetido" (`[9, 9, 9]`, `ainda_pronto: true`).
- **Correção:** gastar o `_perfect_ready` no **início** do golpe que recebeu o bônus (onde hoje faz `attack = scaled`), não no acerto. O confete pode continuar no acerto. Bom também fazer o projétil avisar o dono: `if owner_fighter.has_method("_on_projectile_hit"): ...`, para o arco entrar na nota.

### M7. O arco atravessa a laje da Caatinga e voa reto para fora do palco · BAIXA/MÉDIA
- O arco é desenhado por cima da pedra da laje (`caatinga_arco_na_laje.png`). No chão, ele "rola" 286 px para fora da quina em linha reta no ar (`*_arco_fora_do_palco.png`). Ele também flutua ~25 px acima do chão, deitado (elipse), sem rolar de verdade.
- **Correção:** em `projectile.gd`, um raio `LAYER_STAGE` entre a posição antiga e a nova: bateu na parede, volta (arco) ou some (outros). No arco de chão, dá para colar no chão com um raio para baixo, e se o chão acabar ele já volta (`_flight = return_after`).

### M8. Magnésio, quique, recuperação: OK
- O magnésio perto da quina não derruba ninguém (o golpe de 2% sobrescreve o empurrão, desliza 14 px). Ela volta ao palco nas 4 arenas. A fita segurada inteira tira 22,5%, razoável.
- **Interação com o Peba:** a Toca passando pela cama não deixou o Peba invisível (testado de 3 distâncias). Com a correção M3 isso fica garantido.

---

## Dona Canga

### D1. Estandarte flutua no vazio quando fincado perto da beirada · ALTA · todas
- **Como reproduzir:** a até ~100 px da quina, virada para fora, use o especial lado.
- **O que acontece:** a bandeira é fincada 110 px à frente. Se ali não tem chão, ela fica parada no ar na altura do palco (ex.: Ruínas x=603 com a quina em 560; Cerrado x=427 com a quina em 384). Ela também continua dando "ritmo" para a Canga.
- **Evidência:** `arena_estandarte_beirada.png`, `cerrado_`, `pantanal_`, `caatinga_estandarte_beirada.png`; `trio_diag.json` "estandarte a 20/90 px da beirada" (apoiada: false nas 4 arenas).
- **Correção:**
```gdscript
func _plant_flag() -> void:
    ...
    var space := get_world_2d().direct_space_state
    var feet := global_position + Vector2(0, HEIGHT * 0.5 - 4)
    var at := Vector2.INF
    var d := 110.0
    while d >= 0.0:
        var p := feet + Vector2(facing * d, 0)
        # parede entre ela e o ponto? (laje da Caatinga)
        var wall := space.intersect_ray(PhysicsRayQueryParameters2D.create(feet, p, LAYER_STAGE))
        if wall.is_empty():
            var hit := space.intersect_ray(PhysicsRayQueryParameters2D.create(p, p + Vector2(0, 40), LAYER_STAGE | LAYER_PLATFORM))
            if not hit.is_empty():
                at = hit.position
                break
        d -= 10.0
    if at == Vector2.INF:
        at = feet + Vector2(0, 4)     # sem lugar: finca aos pés dela
    _estandarte = Estandarte.plant(self, at)
```
(O raio de hoje começa 60 px **acima** do ponto: perto da laje ele já começa dentro da pedra. Esta versão começa nos pés.)

### D2. Estandarte enfiado dentro da laje da Caatinga · ALTA · Caatinga
- **Como reproduzir:** no chão baixo, a 60 a 120 px da laje e virada para ela, use o especial lado.
- **O que acontece:** a bandeira fica dentro da rocha (x=-329/-269, laje até x=-256), desenhada **por cima** da pedra.
- **Evidência:** `evidence/revisao-r11/caatinga_estandarte_laje.png`; `trio_diag.json` "estandarte de frente para a laje".
- **Correção:** a mesma da D1 (raio horizontal contra parede).

### D3. Estandarte em plataforma fina vai parar no chão de baixo e a Canga perde o ritmo · MÉDIA · Ruínas, Caatinga, Cerrado, Pantanal (centro)
- O raio só vê `LAYER_STAGE`, então de cima de uma plataforma a bandeira cai no palco de baixo (`*_estandarte_plataforma.png`). Ela fica a ~240 px da Canga, fora do raio de 230, e o golpe não dá ritmo nenhum (`canga_coberta: false`). No galho alto do Cerrado (y=-410) ela fica no galho só porque o raio não alcança o chão.
- **Correção:** máscara `LAYER_STAGE | LAYER_PLATFORM` (já incluída na D1).

### D4. Estandarte na vitória-régia fica parado no ar quando a folha se mexe · ALTA · Pantanal
- **Como reproduzir:** em cima de uma vitória-régia, use o especial lado e espere 2 s.
- **O que acontece:** a folha desce e a bandeira fica no ar, bem acima dela.
- **Evidência:** `evidence/revisao-r11/pantanal_estandarte_vitoria_regia_2s.png`.
- **Correção:** guardar o `collider` do raio e seguir a posição dele, igual à cama (M1).

### D5. Roda de baiana puxa quem está pendurado na quina para dentro da pedra · MÉDIA · todas
- **Como reproduzir:** adversário pendurado na quina, Canga gira a ~90 px dela.
- **O que acontece:** a puxada mexe direto em `global_position.x`, mesmo no estado LEDGE. O pendurado anda 63 px para dentro do bloco do palco (21 quadros dentro da rocha) e continua "pendurado" ali.
- **Evidência:** `arena_roda_x_pendurado_puxando.png`, `arena_roda_x_pendurado.png`; `trio_diag.json` "roda de baiana x adversário pendurado" (4 arenas).
- **Correção:**
```gdscript
if foe.state in [State.LEDGE, State.HELD, State.RESPAWN]:
    continue
foe.move_and_collide(Vector2(signf(d.x) * SPIN_PULL * 0.3 * dt, 0))   # respeita paredes
```

### D6. "Tonta" depois de girar demais usa a pose de dor · MÉDIA ("cara de golpe")
- `hypnotize()` coloca em HITSTUN e o `pixel_sprite` mostra `dor`. A folha `tonto.png` existe, mas só é usada na quebra de escudo. Quem joga vê "levou um golpe" em vez de "ficou tonta".
- **Evidência:** `arena_roda_tonta.png`.
- **Correção:** um `func is_dizzy() -> bool` na Canga (tempo restante da tontura). No `_pick()`, no ramo `S.HITSTUN`: `if fighter.has_method("is_dizzy") and fighter.is_dizzy() and has_anim("tonto"): return _loop("tonto", 6.0)`. Vale também para quem a Sucuri hipnotiza.

### D7. Barrinha da nota do desfile em cima do "P1" · MÉDIA (visual)
- A barra fica em y = -99, bem no meio do texto "P1/CPU".
- **Evidência:** `cerrado_nota_x_tag_p1.png` (zoom 2,5×).
- **Correção:** `var y := -HEIGHT * 0.5 - 112.0` (acima do texto, como a plaquinha da Marianinha) ou colocar entre a setinha e a coroa.

### D8. Pulso de plumas da batida flutua ~20 px e fica escondido atrás da saia · MÉDIA (visual)
- O efeito nasce em `pés - 56` com escala **1,4**. O 56 vale para escala 2 (a base da folha fica na linha ~57). Com 1,4, a base fica ~21 px acima do chão. Ele tem `z = -1` e quase 90 px de largura, então a saia (a mais larga do elenco) cobre quase tudo: nos prints com ela parada o pulso quase não aparece. O efeito ★ "o jogador VÊ o ritmo" não funciona.
- **Evidência:** `trio_plumas_probe` (y_fx = pés-56, escala 1,4, z -1 nas 4 arenas); `pantanal_plumas_batida.png`, `montagem_plumas_batida.png`.
- **Correção:** `_fx("fx_plumas", global_position + Vector2(0, HEIGHT*0.5 - (57 - 32) * 2.0), 0.3, true, 2.0)` (escala 2, base no chão) e, se ainda ficar escondido, `z_index = 5` com o efeito abrindo para os lados (folha mais larga que a saia) ou um brilho na coroa, como diz a ficha ("a coroa pisca no ritmo").

### D9. Estandarte + Apoteose ficam fáceis demais · MÉDIA (balanço)
- Perto da bandeira, **todo** golpe conta como na batida: 4 golpes quaisquer = Apoteose (6 s, +35% sobre os +20%). Uma roda de baiana na batida já dá +50 de nota (2 toques dentro dos 0,3 s) e 24% de dano.
- **Evidência:** `trio_diag.json` "estandarte: golpes até a Apoteose" = 4; "roda de baiana segurada" nota 50, dano 24.
- **Correção:** perto do estandarte, a nota sobe metade (12,5) e a roda conta para a nota só 1 vez por giro (`_spin_scored`).

### D10. Pequenos · BAIXA
- O confete da paradinha tem ~96 px (escala 1,5) e a área do golpe tem 260 px de largura. Visualmente parece fraco para um golpe que lança longe; usar escala 3 ou um anel de confete.
- O voo de alegoria não solta penas (efeito sem ★ no design).
- A roda rebatendo o arco da Marianinha: o arco vira da Canga e, por ter `return_after`, volta para a mão **dela** e some. A rebatida não faz nada. Ao rebater, zerar `p.return_after = -1.0`. (Visto lendo o código, não testei.)
- `pandeiro.png` está importado e nenhum código usa (o pandeiro saiu na rodada 8).
- `_fx` da Marianinha e da Canga não espelha o efeito com `facing` (o `MoveFx` espelha).

### D11. Voo, paradinha, recuperação: OK
- Ela volta ao palco nas 4 arenas. A paradinha só para a música no chão (correto).

---

## Por arena (resumo)

| Arena | O que quebra aqui |
|---|---|
| **Ruínas da Mata** | M1 (cama cai das 2 plataformas), M2, D1 (bandeira no ar nas 2 quinas), D3, C1, C3, D5, M3 |
| **Pantanal** | **D4** (bandeira no ar quando a vitória-régia mexe), **M1** (cama da vitória-régia cai na lagoa e some), D1, D3 (plataforma do meio), C3 (lagoa dos 2 lados), C1, D5, M3 |
| **Caatinga** | **D2** (bandeira dentro da laje), M7 (arco atravessa a laje), M1 (cama da tábua alta cai na laje), D1 (quina direita e ponta da laje), D3, C1, D5, M3 |
| **Cerrado** | D1 (vão grande: a bandeira some no vazio), M1 (3 galhos), M2, C3 (vãos de 256 px entre as ilhas), C1, D5, M3 |

---

## Lista priorizada
1. **M3 (ALTA):** cama elástica + agarrão no ar deixa o adversário preso para sempre. Criar `Fighter.bounce_up()` e usar na cama.
2. **C1 (ALTA):** torre de tchibuns no pisão aéreo. A regra "impact" dispara 1 vez e o tchibum nasce no pouso.
3. **D1 + D2 + D3 + D4 (ALTA):** estandarte no ar, dentro da laje, fora da plataforma e parado no ar na vitória-régia. Uma só reescrita do `_plant_flag` (raio dos pés, máscara 3, recuo até ter chão, seguir a plataforma).
4. **M1 (ALTA):** cama atravessa as plataformas (máscara 3 e seguir a vitória-régia).
5. **M4 (ALTA):** a fita desenhada acerta só até a metade (acerto ao longo da fita até ~480 px).
6. **C2 (ALTA):** a bufada não aparece durante a carga.
7. **D5 (MÉDIA):** a roda puxa o pendurado para dentro da pedra.
8. **M5 + M6 (MÉDIA):** a nota 10 é gasta pela fita sem bônus, e com o arco fica infinita.
9. **D7 + D8 + D6 (MÉDIA, visual):** barra em cima do P1, plumas flutuando/escondidas, tontura com cara de dor.
10. **D9 (MÉDIA):** Apoteose fácil com o estandarte.
11. **M2 (MÉDIA):** cama com metade no vazio na quina.
12. **C3 (MÉDIA):** pisão aéreo sem salvação perto da quina.
13. **M7, C4, D10 (BAIXA).**

Testes novos que ficam na cópia: `game/tests/trio_diag.*`, `trio_shots.*`, `trio_plumas_probe.*`, `trio_flag_probe.*`. Prints e dados: `evidence/revisao-r11/`.
