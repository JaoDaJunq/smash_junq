# Revisão de design · 6 personagens da rodada 10 (22/10/2026)

> Só análise (nada de código foi mexido). Base: fichas `design/personagens/*.md`, `proposta-rodada10.md`,
> `efeitos-especiais.md`, livros `art/prompts/pedidos/<id>/todos.md`, concepts escolhidos, código atual
> (`tucao.gd`, `dona_onca.gd`, `ficha_marca.gd`, `cutia.gd`, `castanha_enterrada.gd`, `calango.gd`,
> `rabo_solto.gd`, `move_fx.gd`, `projectile.gd`, `fighter.gd`) e as folhas `fx_*` que já chegaram.
> Continua e **substitui onde discordar** o levantamento `design/revisao-r11/novos.md` (que só cobria 4).
> Pedidos de efeito prontos: `art/prompts/pedidos/<id>/fx.md` (um por personagem).

## 0. Situação de hoje (conferida no código)

| | Código | Efeitos que já existem | Falta |
|---|---|---|---|
| Tucão | jogável | `fx_pipoca_estouro`, `fx_grama_peixinho`, `fx_bico_entalado` (só em `art/pixel`, **não importados**) | `pipoca.png` (veio grande, refazer), regras no `MoveFx` |
| Dona Onça | jogável | `fx_algema` (não importado) | `fx_carimbo`, `fx_rugido` (pedidos 05/07 da rodada 11 ainda abertos) |
| Cutia | código novo (`cutia.gd`) | `fx_cova`, `fx_estouro_castanha`, `castanha_enterrada.png` (objeto, **o código ainda desenha retângulos**) | regras no `MoveFx` |
| Calango | código novo (`calango.gd`) | `fx_sol`, `rabo.png` | `areia.png`, `fx_areia_olho` (pedidos 12/13 abertos) |
| Berrante / Preguiçoso | sem código, sem sprites | — | **dá para mudar golpe agora de graça** (os livros `todos.md` ainda não foram gerados) |

**Bugs abertos (todos ainda presentes hoje):**
1. `tucao.gd` `BICO` usa `"jab_c"`; o id é `"jab3"` → a bicada final não é blindada.
2. `dona_onca.gd` `PATADAS` usa `"jab_b"`; os ids são `jab2/jab3` → só o 1º jab anota ficha. Tirar `nair` (é giro, não patada).
3. `tucao.tscn` sem `air_jumps = 2` (regra das aves).
4. Fichas da Onça não zeram quando o alvo leva KO; a voz de prisão turbina o golpe contra **qualquer** um que ele acerte.
5. Blindagem do Tucão sem limite (bicada lateral atravessa smash de 20%).
6. **Acerto de projétil não chama nada no dono**: `Projectile` faz `target.receive_hit(...)` e pronto. Consequência: pipoca, saquinho e areia nunca disparam efeito de acerto, e a **areia do Calango só cega pelo hitbox corpo a corpo** (o projétil acerta de novo, 2 acertos de 3%, e não cega).
7. `calango.gd` rabo solto: não encerra o golpe que ele estava fazendo (vira super-armadura), não usa `sem_rabo.png` (já importado) e volta sozinho em 15 s (a ficha diz 1 vez por vida).
8. Importador: `OBJETOS` não tem `rabo`, `castanha_enterrada`, `pipoca`, `areia`, `faixa_interditado` → essas folhas são alinhadas pelos "pés" como se fossem pose.
9. `MoveFx.RULES` não tem entrada para nenhum dos 4 novos: todos os especiais estão "secos".

## 1. Visão geral: o que se repete no elenco

Contando os 11 jogáveis/planejados, **lado = investida reta em 7** (Juba, Peba rolamento, Onça patada, Tucão bicada, Cutia carrinhada, Calango corrida, Berrante megafone) e **cima = salto reto em 5** (Onça, Tucão, Cutia, Calango, Peba fole). Também há três "deita no chão" no baixo (Maracajá cochilo, Calango sol, Preguiçoso cochilo) e três "onda curta em volta" (Capivas pisão, Canga paradinha, Onça distintivo, + Berrante teste do som).
Regra proposta: **cada investida precisa de 1 regra que só ela tem** e **cada recuperação precisa de 1 truque**. Abaixo, a troca de cada um.

| Golpe | Parece com | Fica assim |
|---|---|---|
| Tucão lado | Juba investida, Peba rolamento | **Gol de peixinho**: blindado, reto no ar, bate na trave (parede/faixa) e fica tonto |
| Tucão cima | salto genérico | **Cabeceio**: rebate projéteis para a frente |
| Onça neutro | Berrante berro, Canga paradinha | **"Parado aí!"**: não é onda; vira o adversário de costas e apaga projéteis |
| Onça lado | Capivas/Maracajá (carregáveis) | **Abordagem**: sem carga; se o alvo estiver de costas, dano x1.3 e +2 fichas |
| Onça baixo | Capivas pisão, Canga paradinha | **Interditado!**: fita zebrada que **bloqueia** a passagem (única barreira do jogo) |
| Cutia neutro | castanha do Juba | saquinho em arco que quica e, se errar, **rasga e planta uma castanha** |
| Cutia lado | investidas | **Carrinhada colhedora**: passa por cima das castanhas dela, recolhe e despeja em leque |
| Cutia cima | salto genérico | **Pulo de susto**: sai no 3º quadro, intangível, derruba uma castanha para baixo |
| Calango neutro | magnésio da Marianinha (pó) | areia reta e curta que **cega** (erra o próximo golpe), nada de nuvem parada |
| Calango lado | Maracajá na parede | corre parede acima **sem grudar**, acelera enquanto segura |
| Calango baixo | cochilo da Maracajá | sol = carrega velocidade (3 níveis), visual de sol, não de sono |
| Berrante lado | investidas | **Fio do microfone**: chicote de alcance médio que vira laço de borda (único "tether" do jogo) |
| Berrante cima | fole do Peba (jato para baixo) | berro para baixo cuja **altura depende do volume**; rouco = só uma tossida |
| Berrante baixo | ondas curtas (Capivas/Canga/Onça) | **Teste do som**: sem dano, faz todo mundo perto **pular de susto** (tira do escudo, acorda, solta hipnose) |
| Preguiçoso lado | agarrões (Capivas, Sucuri, Maracajá bote) | **Carona**: gruda nas costas do adversário e deixa ele lento e pesado |
| Preguiçoso baixo | cochilo da Maracajá (`fx_sono`) | **Hora do cafezinho**: senta e toma café da garrafa térmica (cura); o cochilo vira só o "parado" |

---

## 2. Tucão · tucano pipoqueiro do estádio (Forte) — jogável

### (a) Golpe a golpe
| Golpe | Hoje | Único? | Troca |
|---|---|---|---|
| Neutro "Punhado de pipoca" | 3 projéteis retos, 0.45 s | leque curto parece a areia do Calango | **pipocas em arco que sobem e caem** e quicam 1x (artilharia leve; a areia fica reta e rasante) |
| Lado "Bicada investida" | desliza 900 px/s, blindado | investida nº 7 | **Gol de peixinho**: no ar vai reto; parede/faixa à frente = **trave**: para, fica tonto 0.45 s |
| Cima "Voo de bico" | sobe reto | genérico | **Cabeceio**: nos ativos, projétil a ≤ 70 px da cabeça volta para a frente, vira dele, dano x1.5 |
| Baixo "Bicada pilão" | mergulho/cravada | parecido com o aéreo baixo da Canga | **bico entala** se errar (+18 quadros de castigo) e o chão solta 4 pipocas para cima |
| Mecânica "Bico blindado" | sem limite e invisível | única | limite 12% por golpe + **efeito visível** quando aguenta o tranco |
| KO "GOOOL" | não existe | — | chuva de pipoca (reaproveita `fx_pipoca_estouro`) |

### (b) Efeitos (máx. 4)
| # | Folha | Quadros | Quando | Onde (`at`) | Situação |
|---|---|---|---|---|---|
| 1 | `fx_pipoca_estouro` | 4 | **hit** de cada pipoca (gancho de projétil) e chuva do Gol | on_target (`target`, px 1.5) | ✅ existe |
| 2 | `fx_grama_peixinho` | 4 | **active** do lado, a cada 4 quadros, só no chão | below/atrás (`feet`) | ✅ existe |
| 3 | `fx_bico_entalado` | 4 | **impact** do baixo no chão (e de novo ao entalar) | front, no pé (`front` com y do pé) | ✅ existe |
| 4 | `fx_trave_tranco` | 4 | **armor** (aguentou pancada, px 1.5, no peito) e **trave** (px 2, na cabeça) | on_self (`center`/`head`) | **pedir** |
| + | `pipoca.png` (projétil) | 2 | neutro | — | **refazer** (veio grande) |

### (c) Interações que dá para programar
- **Roda de baiana (Canga) ↔ Cabeceio**: os dois rebatem; a pipoca vira pingue-pongue (cada rebate troca o dono). Não quebra.
- **Fita (Marianinha)** apaga pipoca; **"Parado aí!" (Onça)** apaga pipoca. Ok.
- **Cama elástica**: pilão no ar caindo na cama → a cama lança o Tucão (combo engraçado, nada a fazer).
- **Estandarte**: pilão conta como 2 golpes (`_hp -= 2` se `attack_id == "special_down"`). Piada boa, 1 linha.
- **Faixa "Interditado" (Onça)** conta como **trave** para o peixinho (grupo `traves`).
- **Hipnose / agarrões** ignoram a blindagem (não passam por `receive_hit`/são agarrão). Correto, manter.
- **Rabo solto (Calango)**: bicada blindada que lançaria longe arranca o rabo; ok.
- **Arenas**: trave só existe onde tem parede alta (Caatinga, ilhas do Cerrado) ou faixa da Onça.

### (d) Mudanças de código (tucao.gd + 2 linhas fora)
```gdscript
const BICO := ["jab3", "ftilt", "utilt", "fair", "uair", "dair", "special_side", "special_down"]
const ARMOR_MAX := 12.0          # dano aguentado por golpe; passou disso apanha normal
const PIPOCA_SPEED := 620.0
const PIPOCA_ANGLES := [-0.35, -0.12, 0.10]   # sobem em arco
const PIPOCA_GRAVITY := 1400.0
const PIPOCA_LIFE := 0.9
const PIPOCA_W := 20.0           # largura na tela (px): ~10 px de arte x2
const HEADER_RANGE := 70.0
const STUCK_EXTRA := 18          # quadros de castigo do bico entalado
var _armor_taken := 0.0
var _stuck_done := false
```
- `receive_hit`: `if is_beak_armored() and _armor_taken + data.damage <= ARMOR_MAX:` (soma em `_armor_taken`, zera no `frame == 1` de cada golpe) e chama `move_fx.play("fx_trave_tranco", "center", null, 1.5)` + `modulate` laranja 1 quadro.
- Neutro: `Projectile.spawn(..., v, PIPOCA_LIFE)`, `p.gravity = PIPOCA_GRAVITY`, `p.bounces = 1`, `p.set_sprite_fit(load(PIPOCA_PATH), PIPOCA_W)` (novo, ver §8) e `p.hit_fx = "fx_pipoca_estouro"`.
- Lado: nos ativos no ar `velocity.y = 0`; se `is_on_wall()` com `get_wall_normal().x == -facing` e parede alta (2 raycasts `LAYER_STAGE` a −10 e −50 px) **ou** faixa da Onça a < 40 px: `_end_attack()`, `velocity = Vector2(-300*facing, -350)`, `hypnotize(0.45)`, `move_fx.play("fx_trave_tranco","head")`. `.tres`: `active 14→12`, `recovery 20→24`.
- Cima: nos ativos, para cada `Projectile` do grupo `projectiles` a ≤ `HEADER_RANGE` de `global_position + (0,-60)`: `p.velocity = Vector2(1100*facing, -80)`, `p.owner_fighter = self`, `p.data = p.data.duplicate(); p.data.damage *= 1.5`. `FLY_SPEED 1180→1120`. Sai da lista `BICO`.
- Baixo no chão: no quadro `startup+active`, se `_hit_targets.is_empty() and not _stuck_done`: `attack_frame -= STUCK_EXTRA`, `_stuck_done = true`, `move_fx.play("fx_bico_entalado","front_feet")`. No impacto solta 4 pipocas para cima (`Vector2(±120|±40, -700)`, dano 2, gravidade). `.tres`: `damage 12→13`, `base_knockback 330→300`.
- Gol: `match_manager.gd`, junto do `ko_scored.emit`, achar o lutador que marcou e `if f.has_method("on_ko_scored"): f.on_ko_scored()`. No Tucão: 6× `move_fx.play("fx_pipoca_estouro")` em posições aleatórias 80–160 px acima dele, ao longo de 0.8 s.
- `tucao.tscn`: `air_jumps = 2`.
- `MoveFx.RULES["tucano"]`:
```gdscript
{"on": "active", "move": "special_side", "fx": "fx_grama_peixinho", "at": "feet", "every": 4, "time": 0.4, "ground": true},
{"on": "impact", "move": "special_down", "fx": "fx_bico_entalado", "at": "front_feet", "time": 0.45},
{"on": "proj_hit", "fx": "fx_pipoca_estouro", "at": "target", "time": 0.3, "px": 1.5},
```

---

## 3. Dona Onça · delegada do bairro (Pesada) — jogável

### (a) Golpe a golpe
| Golpe | Hoje | Único? | Troca |
|---|---|---|---|
| Neutro "Rugido" | empurra 900 quem está à frente + hitbox 46 | igual berro do Berrante; nem funciona em quem está em hitstun | **"Parado aí!"**: sem hitbox; cone 260 px: empurra pouco (420), **vira o alvo de costas** e trava a virada 0.4 s, **apaga projéteis**; recarga 1.5 s |
| Lado "Patada carregada" | avança 760, não carrega | igual Capivas/Maracajá | **Abordagem**: sem carga; se o alvo estiver **de costas para ela** → dano x1.3 e **+2 fichas** (combo com o "Parado aí!") |
| Cima "Salto da onça" | reto | genérico | **bote diagonal** (`480*facing, -1080`), pega borda de mais longe nos ativos |
| Baixo "Batida do distintivo" | onda 90 px dos dois lados | a mais repetida do jogo | **Interditado!**: bate o distintivo (hitbox 50, 6%) e finca 2 cones com fita: barreira que **adversário não atravessa andando** (tem que pular) e que **para projéteis**; 2 golpes rasgam; 6 s; uma por vez |
| Mecânica "Ficha corrida" | estrelas desenhadas em código | única (a marca fica no outro) | carimbo animado a cada ficha; algema na prisão; zera no KO do alvo |

### (b) Efeitos (máx. 4)
| # | Folha | Quadros | Quando | Onde | Situação |
|---|---|---|---|---|---|
| 1 | `fx_carimbo` | 3 | cada ficha anotada (evento `ficha`) | on_target (`target_head`, segue o alvo) | **pedir** (= rodada11/05) |
| 2 | `fx_algema` | 4 | **hit** da voz de prisão | on_target (`target`) | ✅ existe |
| 3 | `fx_rugido` | 4 | **impact** do neutro | front (boca) | **pedir** (= rodada11/07) |
| 4 | `faixa_interditado` (objeto) | 4 | baixo: 3 quadros balançando + 1 rasgando | no chão | **pedir** |

### (c) Interações
- **Peba (casco)**: "Parado aí!" vira o Peba de costas → o casco fica virado para ela e a Abordagem bate **meia força** (o `seu_peba.receive_hit` já faz isso). Contra-jogo engraçado e de graça.
- **Juba/Maracajá contra-ataque**: "Parado aí!" não tem hitbox → não ativa contra. É a resposta da Onça a quem fica esperando.
- **Hipnose (Sucuri)**: alvo hipnotizado não recebe `turn_lock` (não empilhar controles).
- **Faixa × objetos**: não fincar a < 120 px de estandarte, cama elástica ou castanha (sprites se cobrem). Peixinho do Tucão bate nela (trave). Corrida do Calango **não** sobe (baixa demais). Saquinho/pipoca/areia param nela (`Projectile` checa grupo `faixas`).
- **Cama elástica**: quem quica por cima da faixa passa (só bloqueia no chão).
- **Rabo solto**: voz de prisão (x1.6) é o gatilho mais comum: "fugiu da prisão", e a ficha zera mesmo assim.
- **Arenas**: faixa só em chão `LAYER_STAGE` (não em vitória-régia/galho móvel).

### (d) Mudanças de código (dona_onca.gd, ficha_marca.gd, 1 gancho no Fighter)
```gdscript
const PATADAS := ["jab", "jab2", "jab3", "ftilt", "dtilt", "fair", "special_side"]
const ROAR_RADIUS := 260.0
const ROAR_PUSH := 420.0
const ROAR_TURN_LOCK := 0.4
const ROAR_COOLDOWN := 1.5
const BACK_BONUS := 1.3          # abordagem por trás
const LEAP := Vector2(480.0, -1080.0)
var _roar_cd := 0.0
```
- **Prisão só no alvo certo**: gancho novo no `Fighter`: `func _attack_for(target: Fighter) -> AttackData: return attack` e `_check_hits` passa a usar `target.receive_hit(self, _attack_for(target), facing)`. A Onça sobrescreve: se `ficha_de(target) >= 3` devolve o `attack.duplicate()` turbinado (x1.5 dano, x1.6 lançamento), toca `fx_algema` e zera a ficha. Tirar a troca de `attack` no `frame == 1`.
- **Zerar no KO**: no `_physics_process`, `for f in fichas: if f.state == Fighter.State.RESPAWN: set_ficha(f, 0)`.
- **"Parado aí!"**: `.tres` `startup 14→12`, `damage 0`, `hitbox_radius 0`. No impacto, para cada adversário no cone (`|d| < 260`, `signf(d.x) == facing`, `|d.y| < 100`): se HITSTUN somar em `_launch.x`, senão `velocity.x = ROAR_PUSH*facing`; `f.facing = int(signf(d.x))` e `f.turn_lock = ROAR_TURN_LOCK` (campo novo no `Fighter`, respeitado onde ele vira; zera no `respawn()`). Projéteis de outros no cone: `queue_free()`. Se `_roar_cd > 0`, sai só a animação.
- **Abordagem**: tirar "carregada"; `.tres` `startup 16→14`, `damage 14→12`. Em `_attack_for`: se `move == "special_side"` e `target.facing == facing` (está de costas para ela) → `damage *= BACK_BONUS` e, no acerto, `+2` fichas.
- **Bote**: `velocity = Vector2(LEAP.x*facing, LEAP.y)`; `.tres` `hitbox_offset (10,-70)→(40,-50)`, `angle 85→60`.
- **Interditado**: objeto novo `FaixaInterditada` (molde do `Estandarte`): `LIFETIME 6`, `WIDTH 150`, `HITS 2`, grupos `match_cleanup`, `faixas`, `traves`. No `_physics_process`: adversário no chão com pés a ±30 px da base e `|x - centro| < 75` que vem andando contra a fita → `f.velocity.x = 0` e empurra para fora 4 px. Golpes ativos do adversário na caixa `Rect2(-75,-50,150,50)` tiram 1 de `_hp`. Sprite `faixa_interditado.png` (4 quadros: 0–2 loop, 3 ao rasgar).
- **FichaMarca**: manter as estrelas (são a informação permanente), mas cada ficha nova chama `move_fx.play("fx_carimbo","target_head", alvo)` com `follow`.
- `MoveFx.RULES["onca"]`:
```gdscript
{"on": "impact", "move": "special_neutral", "fx": "fx_rugido", "at": "front", "time": 0.4},
{"on": "ficha", "fx": "fx_carimbo", "at": "target_head", "time": 0.35, "follow": true},
{"on": "prisao", "fx": "fx_algema", "at": "target", "time": 0.5},
```

---

## 4. Cutia Ligeira · feirante de castanha (Rápida) — código novo

### (a) Golpe a golpe (código atual de `cutia.gd`)
| Golpe | Hoje | Único? | Troca |
|---|---|---|---|
| Neutro "Saquinho" | arco, quica 2x | vizinho da castanha do Juba e da pipoca | manter o saquinho (arte pronta, combina com a ficha; **cancelar o ouriço** da rodada11/08). Novo: se o saquinho **errar e parar no chão**, rasga e **planta uma castanha** ali (conta no limite de 3) |
| Lado "Carrinhada" | investida 980 | investida | **colhedora**: as castanhas dela no caminho são recolhidas (até 3); no acerto ou no fim, o carrinho **despeja** em leque (1 projétil de 4% por castanha). Para na borda |
| Cima "Pulo de cutia" | salto 1250 | genérico | **Pulo de susto**: sobe no quadro 3, **intangível 3–6**, derruba 1 castanha para baixo (projétil 3%, ângulo −60: afunda quem guarda a borda) |
| Baixo "Enterra/desenterra" | cava ou arremessa castanha turbinada | **única do elenco** | manter; usar a arte `castanha_enterrada.png`; distância mínima 90 px entre castanhas; nunca em plataforma fina/móvel |
| Agarrão | normal | — | opcional: arremesso para trás "rouba" e dá +1 castanha extra por 8 s |

### (b) Efeitos (máx. 4)
| # | Folha | Quadros | Quando | Onde | Situação |
|---|---|---|---|---|---|
| 1 | `fx_cova` | 6 | **frame** 6 do baixo (cavando) | below (`feet`, à frente 36 px) | ✅ existe |
| 2 | `fx_estouro_castanha` | 6 | castanha armada estoura (evento `trap`) | na castanha | ✅ existe |
| 3 | `fx_poeira_carrinho` | 4 | **active** do lado, a cada 4 quadros | below/atrás (`feet_behind`) | **pedir** |
| 4 | `fx_saquinho_rasga` | 4 | saquinho **hit** (`proj_hit`) ou parou sem acertar | on_target / no chão | **pedir** |
| obj | `castanha_enterrada.png` | 2 | sempre | chão | ✅ existe, falta importar e usar |

### (c) Interações
- **Peba toca**: passando por baixo da terra por cima de uma castanha, ela estoura **sem dano** ("cavou e achou"): `castanha.defuse()` no `_burrow_move`.
- **Hipnose em cima da castanha**: alvo parado de pé numa castanha armada a dispara (já acontece: pés no chão). Combo bonito, nada a fazer.
- **Agarrado / preso** (Sucuri, Carona do Preguiçoso): `state == HELD` não dispara.
- **Faixa da Onça / estandarte / cama**: distância mínima 120 px na hora de enterrar; se não couber, a castanha nasce do outro lado.
- **Carrinhada × Tucão blindado**: o carrinho não derruba durante a bicada (blindagem) — correto.
- **CPU**: não enxerga armadilha → a castanha armada pisca 1 quadro por segundo (justo para humano).
- **Bolha de moleza**: castanha dentro da bolha arma 2x mais devagar (usa `slow_factor` da área).

### (d) Especificação de código (delta sobre `cutia.gd` / `castanha_enterrada.gd`)
```gdscript
# cutia.gd
const BAG_PLANT := true            # saquinho que para no chão sem acertar planta castanha
const CART_COLLECT_RANGE := 40.0   # px dos pés até a castanha para recolher
const CART_MAX := 3
const CART_SPREAD := [-0.30, -0.10, 0.10]   # ângulos do despejo
const CART_SHOT_SPEED := 760.0
const SCARE_HOP := 1300.0          # pulo de susto
const SCARE_INTANGIBLE := Vector2i(3, 6)
var _cart_load := 0
# castanha_enterrada.gd
const MIN_GAP := 90.0
const SPRITE_PATH := "res://assets/characters/cutia/pixel/castanha_enterrada.png"
func defuse() -> void   # estoura sem dano (Peba)
```
- **Saquinho**: `Projectile` ganha `signal expired(p)` e `signal landed_still(p)` (quando acaba os quiques no chão). A Cutia escuta: `landed_still` → `CastanhaEnterrada.bury(self, p.global_position, trap)` se o chão abaixo for `LAYER_STAGE` + `move_fx.play("fx_saquinho_rasga", p.global_position)`.
- **Carrinhada**: em cada quadro ativo, castanhas dela a ≤ 40 px dos pés → `queue_free` + `_cart_load += 1` (máx. 3). No acerto (`_on_hit_landed`) ou no último quadro ativo: dispara `_cart_load` projéteis com `CART_SPREAD`, gravidade 1500, dano 4, e zera. Para na borda: raycast à frente como o `_burrow_move` do Peba; sem chão → `velocity.x = 0`. No ar: só um passo curto (500), sem colher.
- **Pulo de susto**: `.tres` `special_up startup 4→3`; `velocity.y = -SCARE_HOP`; `_is_intangible()` sobrescrito: verdadeiro em `attack_id == "special_up"` e quadro 3–6. No quadro 4: castanha `Vector2(0, 600)`, dano 3, `angle -60`.
- **Enterrar**: antes de `bury`, se houver castanha/objeto (grupos `castanhas_enterradas`, `estandartes`, `camas_elasticas`, `faixas`) a < `MIN_GAP`, desloca 90 px para o lado livre; se não houver chão `LAYER_STAGE`, não enterra (só a animação).
- **CastanhaEnterrada**: trocar `_draw` por sprite (quadro 0 quieto, 1 armado alternando a 2 Hz + 1 quadro apagado a cada 1 s); ao estourar chamar `owner_fighter.move_fx.play("fx_estouro_castanha", global_position + (0,-24))`.
- Importador: `OBJETOS += ["castanha_enterrada"]`.
- `MoveFx.RULES["cutia"]`:
```gdscript
{"on": "frame", "move": "special_down", "frame": 6, "fx": "fx_cova", "at": "feet_front", "time": 0.45},
{"on": "active", "move": "special_side", "fx": "fx_poeira_carrinho", "at": "feet_behind", "every": 4, "time": 0.35, "ground": true},
{"on": "proj_hit", "fx": "fx_saquinho_rasga", "at": "target", "time": 0.35},
```

---

## 5. Calango · ambulante de praia (Rápido) — código novo

### (a) Golpe a golpe (código atual de `calango.gd`)
| Golpe | Hoje | Único? | Troca |
|---|---|---|---|
| Neutro "Joga areia" | hitbox 34 + projétil 0.25 s (2 acertos; o projétil não cega) | **cegar é único** | só o projétil (`areia.png`, reto, rasante, 175 px), dano 1, quase sem empurrão; o acerto do projétil aplica `sand_time` + `fx_areia_olho` seguindo enquanto durar |
| Lado "Corrida" | 1000 fixo, sobe se `is_on_wall()` | parede ≈ Maracajá | **acelera enquanto segura** (600→1250), atropela de novo a cada 8 quadros, **sobe a parede correndo sem grudar** (1 subida por pulo), no topo dá um pulinho por cima |
| Cima "Salto de lagartixa" | salto 1200 | genérico | P3: **Chinelada**: ao subir, o chinelo cai como projétil (4%, ângulo −70) e volta para o pé no pouso. Sem arte nova por enquanto: dá para usar círculo provisório |
| Baixo "Tomar sol" | +30% de velocidade 7 s, de uma vez | deitar ≈ cochilo | **3 níveis**: segurando especial, a cada 20 quadros sobe um nível (+10/+20/+30%) com `fx_sol`; levar golpe deitado perde tudo |
| Mecânica "Rabo solto" | volta em 15 s, não encerra o golpe | **a melhor ideia das 6** | **1 vez por vida**; encerra o golpe, pulinho curto, intangível 0.6 s, sprite `sem_rabo`; o rabo no chão é **isca de verdade** (absorve 1 golpe) |

### (b) Efeitos (máx. 4)
| # | Folha | Quadros | Quando | Onde | Situação |
|---|---|---|---|---|---|
| 1 | `fx_areia_olho` | 4 (loop) | areia **hit** (proj_hit), repete enquanto `sand_time > 0` | on_target (`target_head`, segue) | **pedir** (= rodada11/13) |
| 2 | `fx_sol` | 4 | baixo, a cada nível ganho | on_self (`above`, acima da cabeça) | ✅ existe |
| 3 | `fx_poeira_corrida` | 4 | **active** do lado a cada 3 quadros (no chão: `feet_behind`; na parede: `wall`) | below/atrás | **pedir** |
| 4 | `fx_rabo_poof` | 4 | rabo solta (evento `tail`) | on_self, atrás (`behind`) | **pedir** |
| proj | `areia.png` | 3 | neutro | — | **pedir** (= rodada11/12) |
| obj | `rabo_solto.png` | 4 | rabo no chão | chão | opcional (o `rabo.png` atual tem só 2 quadros e grade fora do padrão) |

### (c) Interações
- **Sucuri × areia**: alvo com `sand_time > 0` **não é hipnotizado** (olho fechado de areia); Sucuri cegada **erra** a hipnose. 1 linha em `mestra_sucuri._hypnotize`.
- **Contra-ataque (Juba/Maracajá)**: o contra chama `receive_hit` direto, então **não erra** com areia. Manter (é reflexo).
- **Tucão blindado / Onça prisão**: os lançamentos grandes deles são os gatilhos típicos do rabo solto. Ok.
- **Rabo-isca**: golpe de adversário cujo hitbox encostar no rabo **antes** do Calango é gasto no rabo (o rabo pula e some). Funciona contra Tucão, Onça, todos. CPU mira no rabo por 1 s (grupo `iscas`).
- **Parede**: só Caatinga (laje) e ilhas do Cerrado; limitar a 1 subida por pulo (como `CLING_COOLDOWN` da Maracajá) para não virar escada infinita nas ilhas.
- **Bolha de moleza**: o bônus do sol não vale dentro da bolha (lá todo mundo é lento, piada: "nem o sol esquenta").
- **Cama elástica**: corrida que entra na cama é lançada (já acontece). Ok.

### (d) Especificação de código (delta sobre `calango.gd` / `rabo_solto.gd`)
```gdscript
const SAND_SPEED := 700.0
const SAND_LIFE := 0.25
const SAND_BLIND := 2.5
const RUN_MIN := 600.0
const RUN_MAX := 1250.0
const RUN_ACCEL := 1800.0        # px/s²
const RUN_MAX_FRAMES := 50
const RUN_TICK := 8              # atropela de novo
const WALL_RUN_SPEED := 900.0
const WALL_RUN_FRAMES := 18
const WALL_MIN_HEIGHT := 40.0
const SUN_STEP := 20             # quadros por nível
const SUN_BONUS := [0.0, 0.10, 0.20, 0.30]
const SUN_TIME := 7.0
const TAIL_LAUNCH := 900.0
const TAIL_INVULN := 0.6
var tail_ready := true           # volta só no respawn()
var _sun_level := 0
var _wall_run_used := false
```
- **Areia**: `.tres` neutro `hitbox_radius 34→0`, `damage 3→1`, `base_knockback 120→60`. Projétil com `areia.png` e `p.on_hit = func(t): t.sand_time = SAND_BLIND; move_fx.play_follow("fx_areia_olho", t, SAND_BLIND)` (gancho de projétil §8). Reaplicar só renova.
- **Corrida**: enquanto `controls.pressed("special")` e `frame < RUN_MAX_FRAMES`: `attack_frame = startup + 1`, `velocity.x = move_toward(velocity.x, RUN_MAX*facing, RUN_ACCEL*delta)`, `_hit_targets.clear()` a cada `RUN_TICK`. Parede alta (2 raycasts `LAYER_STAGE` a −10 e −50 px) e `not _wall_run_used` → `velocity = Vector2(0, -WALL_RUN_SPEED)` por `WALL_RUN_FRAMES`, `_wall_run_used = true` (zera ao pousar), no fim `velocity = Vector2(200*facing, -400)`. Último toque ao soltar: dano 6, `growth 6`.
- **Tomar sol**: golpe vira "segurável" (como a carga do Capivas): enquanto segura, a cada `SUN_STEP` quadros `_sun_level = mini(3, +1)` + `move_fx.play("fx_sol","above", null, 1.5 + 0.5*_sun_level)`. Ao soltar (ou 90 quadros): aplica `SUN_BONUS[_sun_level]` por `SUN_TIME`. `hit_taken` durante o golpe → `_sun_level = 0`. Buff ativo: `modulate = Color(1.08, 1.0, 0.92)`.
- **Rabo solto**: em `receive_hit`, antes de qualquer coisa (copiar a ordem do `seu_peba.gd`): se `tail_ready` e não SHIELD e `launch_speed >= TAIL_LAUNCH`: `tail_ready = false`; `if attack: _end_attack()`; `damage_percent += data.damage`; `release_hold()`; `state = State.AIR`; `velocity = Vector2(direction_sign*260, -300)`; `invincible_time = TAIL_INVULN`; `_drop_tail()`; `move_fx.play("fx_rabo_poof","behind")`. `respawn()` → `tail_ready = true`. `anim_override()` → troca `parado/andar` por `sem_rabo` enquanto `not tail_ready` (folha já importada).
- **RaboSolto como isca**: grupo `iscas`, `func hurt_rect() -> Rect2` (36×14). Em `Fighter._check_hits`, antes do laço dos lutadores: se o hitbox encosta numa isca de outro dono → isca `pop()` (salta e some com `fx_rabo_poof`), `_hit_targets.append(isca)` e o golpe acaba aí. Vida 4 s.
- `rabo_solto.gd`: `n = maxi(1, tex.get_width() / 64)` em vez do `2` fixo (aceita a folha nova de 4 quadros).
- Importador: `OBJETOS += ["rabo", "rabo_solto", "areia"]`.
- `MoveFx.RULES["calango"]`:
```gdscript
{"on": "active", "move": "special_side", "fx": "fx_poeira_corrida", "at": "feet_behind", "every": 3, "time": 0.3},
{"on": "tail", "fx": "fx_rabo_poof", "at": "behind", "time": 0.4},
```

---

## 6. Berrante · bugio radialista (Forte) — só concept (mudar agora é de graça)

### (a) Golpe a golpe
| Golpe | Proposta | Parece com | Troca |
|---|---|---|---|
| Neutro "Berro em onda" | onda que empurra | rugido antigo da Onça | manter (com a Onça virando "Parado aí!" o berro fica só dele); a força **cresce com o volume**; projéteis na onda são **empurrados de volta devagar** (não rebatidos) |
| Lado "Investida com megafone" | investida | investida nº 7 | **Fio do microfone**: gira o microfone pelo fio e lança à frente (alcance 180 px, ponta forte); **no ar, se a ponta tocar uma borda, ele se pendura** (único "tether" do jogo; o laço da Sucuri pega gente, não borda) |
| Cima "Berro para baixo" | jato para baixo | fole do Peba | manter, mas **altura = volume** (volume 0: 800; 4: 1250); **rouco: só tosse** e sobe 500. O jato tem hitbox embaixo que empurra para baixo quem estiver pendurado na borda |
| Baixo "Teste do som" | todo mundo perto pula de susto | ondas curtas (Capivas/Canga/Onça) | **sem dano**: quem está a 200 px faz um pulinho involuntário (sai do escudo, **acorda o Preguiçoso**, **solta hipnose**, interrompe carga do Capivas/Maracajá); dá +1 volume |
| Mecânica "Volume" | barra; no máximo fica rouco | única | 4 barrinhas tipo equalizador acima da cabeça (desenho em código, como a `FichaMarca`); cada berro +1; golpes +8% por barra; com 4, o próximo berro é "MÁXIMO" (dobro) e ele fica **rouco 5 s** (barra zera) |
| Rabo preênsil (passivo) | — | — | agarra a borda **de costas** também (alcance da borda +20 px atrás). Cara de bugio sem custo |

### (b) Efeitos (máx. 4)
| # | Folha | Quadros | Quando | Onde |
|---|---|---|---|---|
| 1 | `fx_berro` | 4 | **impact** do neutro (px 2, maior com volume: 2/2.5/3); **impact** do cima com `rot: 90` | front (boca) / below |
| 2 | `fx_susto` | 3 | **hit** do teste do som (em cada um que pulou) | on_target (`target_head`) |
| 3 | `fx_rouco` | 4 | ao ficar rouco e a cada berro rouco | on_self (`nose`) |
| 4 | `fx_microfonia` | 4 | berro MÁXIMO (volume 4) e ponta do fio acertando | front / on_target |

### (c) Interações
- **Preguiçoso**: teste do som acorda o cochilo/café (cancela a cura). Contra natural.
- **Sucuri**: teste do som solta o hipnotizado ("acorda!"); berro empurra a Sucuri para fora do alcance do laço.
- **Canga**: o berro **desafina** a bateria: quem está a 230 px do estandarte perde o "na batida" por 1 s (`estandarte.silence(1.0)`, já existe a lógica de silêncio da paradinha).
- **Tucão/Onça**: berro empurra a pipoca/saquinho de volta; "Parado aí!" da Onça apaga o berro? Não (berro não é projétil). Ok.
- **Fio do microfone**: pendura na borda como o `_grab_ledge` normal; o laço não pega plataforma fina.
- **Arenas**: no Pantanal o tether salva da água; nada quebra.

### (d) Notas para o livro de sprites (`art/prompts/pedidos/bugio/todos.md`, antes de gerar)
- `especial_lado`: trocar "megafone, corpo esticado" por "**gira o microfone pelo fio acima da cabeça · lança à frente, fio esticado · puxa de volta**" (o fio esticado é feito pelo jogo; no sprite o microfone sai da mão no quadro 4).
- `especial_baixo` já serve (bate no microfone e berra curto).

---

## 7. Seu Preguiçoso · fiscal da prefeitura (Pesado) — só concept

### (a) Golpe a golpe
| Golpe | Proposta | Parece com | Troca |
|---|---|---|---|
| Neutro "Bolha de moleza" | bolha de câmera lenta | nada (**a mecânica mais original do jogo**) | manter: bolha de raio 150 px por 4 s no lugar onde ele está; dentro, adversários e projéteis a 50% da velocidade; ele não; 1 por vez, recarga 8 s |
| Lado "Abraço lento que puxa" | agarrão | Capivas, Sucuri, bote da Maracajá | **Carona**: estica as garras, se pegar **gruda nas costas** do adversário por até 3 s: o outro anda 40% mais devagar e pula 30% menos; o Preguiçoso pode bater de leve (1%) a cada 20 quadros. Sai: o outro aperta escudo/ataque (cada aperto −0.3 s), bate numa parede, ou leva golpe |
| Cima "Pendura no galho" | galho invisível | parede/escalada da Maracajá (pouco) | manter (é a cara do bicho): aparece um **galho** acima, ele sobe pendurado e pode ficar **até 1 s pendurado** (pausa no ar; único) |
| Baixo "Cochilo que cura" | dorme e cura | cochilo da Maracajá (inclusive o `fx_sono`) | **Hora do cafezinho**: senta e toma café da garrafa térmica: cura 1% a cada 0.3 s enquanto segura (máx. 12%); levar golpe derrama o café (perde 2 s de recarga) |
| Passivo "Cochila se ninguém bate" | cura devagar | — | manter como o **parado** depois de 4 s sem levar golpe: bolha no nariz, cura 1%/s até 10% por vida |

### (b) Efeitos (máx. 4)
| # | Folha | Quadros | Quando | Onde |
|---|---|---|---|---|
| 1 | `fx_bolha_moleza` | 4 (loop) | neutro: borda da bolha (px 4–5 = 256–320 px na tela), repete enquanto existe | no lugar (on_self no início, depois fixo) |
| 2 | `fx_galho` | 3 | **impact** do cima | acima (`above`) |
| 3 | `fx_cafe` | 4 (loop) | **during** do baixo, a cada 18 quadros | on_self (`head`, perto da boca) |
| 4 | `fx_bolha_nariz` | 4 (loop) | passivo cochilando (`rest`) | on_self (`nose`) |

### (c) Interações
- **Bolha × projéteis**: pipoca, saquinho, areia, castanha do Juba, nota do Peba, pandeiro/arco (bumerangue demora a voltar) ficam lentos dentro. Projétil lento + Cabeceio do Tucão: fácil de rebater (bom).
- **Bolha × objetos**: cama elástica lança a 50%; estandarte: a **batida da Canga fica 2x mais lenta** dentro (`BEAT` local); castanha arma 2x mais devagar; rabo do Calango se mexe em câmera lenta (só visual).
- **Bolha × mecânicas**: hipnose e areia **duram o dobro** para quem está dentro (o relógio deles anda a 50%); bônus do sol do Calango não vale dentro.
- **Carona × Peba casco**: grudar nas costas do Peba = grudar no casco: escorrega e cai (não pega). Piada e regra simples (`target is SeuPeba` → falha).
- **Carona × Calango**: grudar nas costas pode puxar o rabo: se o rabo estiver pronto, o Calango solta o rabo e foge (a preguiça fica segurando o rabo!). Usa o mesmo `_drop_tail()`.
- **Carona × Tucão blindado / Onça**: carona é agarrão, passa pela blindagem.
- **Teste do som (Berrante)** acorda/cancela café e cochilo.

### (d) Código necessário (resumo para quando entrar)
- `Fighter.slow_factor := 1.0` (definido pela área da bolha a cada quadro): timers e gravidade usam `delta * slow_factor`; `attack_frame` avança por acumulador (`_slow_acc += slow_factor; while _slow_acc >= 1: avança 1 quadro`); `move_and_slide` com `velocity * slow_factor`. `Projectile` idem. Bolha = `Node2D` no grupo `bolhas_moleza`, `match_cleanup`.
- Carona: inverso do `hold()`: `rider`/`ridden_by` no `Fighter`; o Preguiçoso copia a posição das costas do alvo (`-facing*24, -30`) e fica intangível a golpes de frente; `speed_mult`/`jump_mult` no alvo.
- Livro de sprites (`preguica/todos.md`, antes de gerar): `especial_lado` vira "estica as garras · **agarrado nas costas de alguém invisível, abraçando** · bate de leve" e `especial_baixo` vira "senta · **tira a garrafa térmica** · bebe devagar · suspira satisfeito".

---

## 8. Código compartilhado (destrava tudo acima)

1. **Gancho de acerto de projétil** (bug 6): em `projectile.gd`, depois de `target.receive_hit(...)` que retornar true:
   `if owner_fighter.has_method("_on_projectile_hit"): owner_fighter._on_projectile_hit(target, self)` e `owner_fighter.move_fx.on_proj_hit(target, self)` (regra `"on": "proj_hit"`; opcional `p.hit_fx` por projétil). Sinal `landed_still` quando acabam os quiques.
2. **`Projectile.set_sprite_fit(tex, width_px)`**: calcula `sprite_scale = width_px / used_rect.size.x` do 1º quadro. Resolve "veio grande" (pipoca, areia) sem depender do gerador acertar o tamanho.
3. **`MoveFx.play(fx_name, at, target := null, px := 2.0, follow := false)`** público (hoje cada personagem tem seu `_fx`); carrega a textura sob demanda. Eventos novos chamados pelos personagens: `armor`, `ficha`, `prisao`, `trap`, `tail`, `ko`. Novas posições: `feet_front`, `feet_behind`, `front_feet`, `above` (`-HEIGHT - 30`). Chaves novas na regra: `rot` (graus, para `fx_berro` virado para baixo), `ground` (só se `is_on_floor()`), `follow`.
4. **`Fighter._attack_for(target)`** (prisão da Onça; serve também à batida da Canga e ao volume do Berrante).
5. **`Fighter.turn_lock`**, **`Fighter.slow_factor`**, `on_ko_scored()`; zerar `turn_lock`, `sand_time` no `respawn()`.
6. **Objetos de chão**: função comum `ArenaUtil.floor_below(at)` (`LAYER_STAGE`) + distância mínima entre grupos `estandartes`, `camas_elasticas`, `castanhas_enterradas`, `faixas`.
7. **Importador**: `OBJETOS += ["castanha_enterrada", "rabo", "rabo_solto", "pipoca", "areia", "faixa_interditado"]`; importar `tucano` e `onca` de novo para trazer os `fx_*` que já chegaram (Cutia/Calango só depois que os chats do Codex fecharem).

## 9. Ordem sugerida

- **P1 só código**: bugs 1–9; gancho de projétil; `MoveFx.play` + regras dos 4 com as folhas que **já existem** (8 efeitos aparecem na hora); rabo solto correto; areia só projétil.
- **P1 imagem** (fx.md): `tucano/pipoca` (refazer), `onca/fx_carimbo`, `onca/fx_rugido`, `calango/areia`, `calango/fx_areia_olho` — são os pedidos 04/05/07/12/13 da rodada 11, consolidados nos novos `fx.md` (não pedir duas vezes).
- **P2**: "Parado aí!", Abordagem, Interditado (+ `faixa_interditado`), peixinho/trave (+ `fx_trave_tranco`), cabeceio, carrinhada colhedora (+ `fx_poeira_carrinho`), saquinho que planta (+ `fx_saquinho_rasga`), corrida acelerada (+ `fx_poeira_corrida`), `fx_rabo_poof`, sol em 3 níveis.
- **P3**: Gol do Tucão, chinelada do Calango, `rabo_solto` 4 quadros, roubo de castanha.
- **Berrante e Preguiçoso**: ajustar os livros `todos.md` (§6d, §7d) **antes** de gerar os sprites; os `fx.md` deles já estão prontos para quando o código entrar.
- Cancelar: `rodada11/08_cutia_ourico` (o saquinho fica).
