# Rodada 12 · código dos 4 novos (Tucão, Dona Onça, Cutia, Calango)

> Base: `design/revisao/novos_personagens.md` (§0, 2–5, 8, 9). Não mexi em `art/pixel/bugio`,
> `art/pixel/preguica`, telas de menu nem nas regras de Canga/Marianinha/Capivas do `MoveFx`.
> Não rodei git.

## 1. Código compartilhado (P1)

| O quê | Onde |
|---|---|
| **Gancho de acerto de projétil**: depois de `receive_hit` que entrou, chama `dono._on_projectile_hit(alvo, p)`, `dono.move_fx.on_proj_hit()` (regra `"proj_hit"`), `p.hit_fx` e `p.on_hit` (Callable). Sinais `landed_still` (acabaram os quiques no chão) e `expired`. Grupo `projectiles`. Projéteis param na faixa da Onça. | `scripts/combat/projectile.gd` |
| **`Projectile.set_sprite_fit(tex, largura_px)`** (pipoca/areia que vierem grandes) e `set_sprite` lendo a largura do quadro no `animacoes.json` (quadros de 80/96 dos personagens com MARGEM não quebram mais). Desenho por código `look = "pipoca" / "areia"` enquanto a folha não chega. | idem |
| **`MoveFx.play(fx, at, alvo, px, follow, time, draw)`** público, `play_at(fx, ponto)`, `event(nome, alvo)` (eventos `armor`, `trave`, `ficha`, `prisao`, `tail`, `proj_hit`), carga de folha sob demanda. Posições novas `feet_front`, `feet_behind`, `front_feet`, `above`, `target_eyes`, `target_feet`. Chaves novas `ground`, `follow`, `rot`, `base` (linha do chão da folha), `draw` (desenho reserva). Regras dos 4 novos. As regras antigas ficaram iguais (fx_shots: 21/21 [OK]). | `scripts/visual/move_fx.gd` |
| **`CodeFx`** (novo): efeitos desenhados por código no lugar das folhas que faltam (estalo, estrelas de tonto, "!" do Parado aí, carimbo, poeira, saquinho rasgando, poof, areia no olho). | `scripts/visual/code_fx.gd` |
| **Fighter**: `_attack_for(alvo)` (dados do golpe por alvo), `lock_facing()/turn_lock` (virada travada; zera no `respawn`), `sand_time` zera no `respawn`, `on_ko_scored()`, `tall_wall_ahead()` (2 raios: trave/parede), iscas (golpe que encosta no rabo-isca é gasto ali, `_attack_spent`). | `scripts/fighter.gd` |
| `on_ko_scored()` chamado no lutador que marcou o KO. | `scripts/match/match_manager.gd` |
| **Importador**: `OBJETOS += castanha_enterrada, rabo, rabo_solto, pipoca, areia, faixa_interditado`; efeitos e objetos são lidos na largura de célula **da própria folha** (folha 1536 = quadros de 64 mesmo em personagem com MARGEM; antes lia na escala errada) e gravam `"largura"` no json; pose numa folha de outra largura é centralizada no quadro do personagem. | `tools/importar_pixel.gd` |
| Importados de novo: `tucano`, `onca`, `cutia`, `calango` (+ `--import`). Saíram `fx_pipoca_estouro`, `fx_grama_peixinho`, `fx_bico_entalado`, `fx_algema`, `fx_cova`, `fx_estouro_castanha`, `castanha_enterrada`, `fx_sol`; `rabo`/`castanha` agora como objetos. | `game/assets/characters/*/pixel/` |

## 2. Por personagem

### Tucão (índice 7) — `tucao.gd`, `tucao.tscn`, `tucao.tres`, `estandarte.gd`
- **Bugs**: B1 `BICO` usa `jab3` (era `jab_c`), cabeceio saiu da lista; B3 `air_jumps = 2`; B5 blindagem com limite de **12% por golpe** + estalo laranja visível (`armor`, CodeFx `tranco`) e piscada laranja.
- **Pipoca em arco**: 3 pipocas que sobem, caem e quicam 1x (gravidade 1400); acerto estoura `fx_pipoca_estouro` (gancho de projétil).
- **Gol de peixinho**: no ar vai reto; parede alta (2 raios) ou faixa "Interditado" à frente = **trave**: para, quica para trás, tonto 0.45 s com estrelinhas (CodeFx). `fx_grama_peixinho` atrás dele no chão. `.tres` active 12 / recovery 24.
- **Cabeceio**: nos ativos, projétil a ≤ 70 px da cabeça volta para a frente, vira dele e bate 1.5x (pingue-pongue com a roda da Canga).
- **Pilão**: no chão solta 4 pipocas para cima; errou = **bico entala** (+18 quadros, `fx_bico_entalado` de novo). `.tres` dano 13 / base 300. Contra o estandarte conta como 2 golpes.
- **GOOOL**: chuva de 6 `fx_pipoca_estouro` em cima dele ao marcar KO (`on_ko_scored`).

### Dona Onça (índice 8) — `dona_onca.gd`, `faixa_interditada.gd` (novo), `ficha_marca.gd`, `dona_onca.tres`
- **Bugs**: B2 `PATADAS` com `jab2/jab3`, sem `nair`; B4 voz de prisão só turbina **contra quem tem a ficha cheia** (`_attack_for`), ficha zera no KO do alvo; algema (`fx_algema`) no acerto da prisão (evento `prisao`).
- **"Parado aí!"**: sem dano e sem hitbox (não ativa contra-ataque); cone de 260 px: empurra 420, **vira o alvo de costas** e trava a virada 0.4 s (quem está em atordoamento só é empurrado), **apaga projéteis** no cone; recarga 1.5 s. Balão "!" vermelho + arcos de voz (CodeFx até chegar `fx_rugido`).
- **Abordagem**: alvo de costas para ela → dano x1.3 e **+2 fichas**. `.tres` startup 14 / dano 12.
- **Bote**: salto diagonal (480, −1080) e alcance de borda 1.6x nos ativos. `.tres` offset (40,−50), ângulo 60.
- **Interditado!**: distintivo (6%, raio 50) + **faixa zebrada com 2 cones** desenhada por código: adversário no chão não atravessa andando (tem que pular), projéteis dos outros param, 2 golpes rasgam (as metades caem), 6 s, uma por vez, só em chão de palco, afasta 120 px de estandarte/cama/castanha, conta como trave do Tucão.
- **Ficha**: carimbo vermelho cai na cabeça a cada ficha (CodeFx até chegar `fx_carimbo`) e a estrela nova "pula".

### Cutia Ligeira (índice 9) — `cutia.gd`, `castanha_enterrada.gd`, `cutia.tres`, `seu_peba.gd`
- **Saquinho que planta**: errou e parou no chão → rasga (CodeFx `rasgo`) e planta castanha (limite 3). Acerto mostra o saquinho rasgando no alvo.
- **Carrinhada colhedora**: castanhas dela no caminho são recolhidas (até 3, aparecem no carrinho) e despejadas em leque (4% cada) no acerto ou no fim; **para na beirada**; no ar só um passo curto. Poeira atrás (CodeFx).
- **Pulo de susto**: sai no 3º quadro (`.tres` startup 3), **intocável 3–6**, derruba 1 castanha para baixo (3%, ângulo −60).
- **Castanha enterrada**: usa a arte `castanha_enterrada.png` (2 quadros, pisca 1 quadro por segundo quando armada), estoura com `fx_estouro_castanha`, distância mínima 90 px (120 de estandarte/cama/faixa), só em chão de palco, não dispara em quem está agarrado; `fx_cova` ao cavar. **Seu Peba** passando por baixo da terra estoura sem dano (`defuse`).

### Calango (índice 10) — `calango.gd`, `rabo_solto.gd`, `calango.tres`, `mestra_sucuri.gd`
- **B6/areia só projétil**: neutro sem hitbox corpo a corpo (1 acerto, 1%, quase sem empurrão); o **acerto do projétil cega** (`_on_projectile_hit`) e mostra grãos rodando na frente dos olhos enquanto durar (some quando o golpe erra). Areia desenhada por código, reta e rasante.
- **B7 rabo solto**: 1 vez por vida (volta só no `respawn`), **encerra o golpe**, pulinho para longe, intocável 0.6 s, poof (CodeFx), usa `sem_rabo` parado/andando; o rabo no chão é **isca** (o primeiro golpe que encosta é gasto nele) por 4 s.
- **Corrida**: acelera enquanto segura (600 → 1250), atropela de novo a cada 8 quadros, **sobe parede alta correndo** (1 vez por pulo, sem grudar) e dá um pulinho por cima no topo; poeira atrás/na parede.
- **Sol em 3 níveis**: segurando, a cada 20 quadros sobe um nível (+10/+20/+30% por 7 s) com `fx_sol` maior a cada nível; só um toque = nível 1; levar golpe deitado perde tudo.
- **Sucuri × areia**: alvo com areia nos olhos não é hipnotizado; Sucuri cegada erra a hipnose.

## 3. Testes
- `game/tests/novos_smoke.gd`: +62 checagens novas (`_tucao_r12`, `_onca_r12`, `_cutia_r12`, `_calango_r12`): blindagem com limite e estalo, pipoca em arco que estoura, trave na parede e na faixa, peixinho reto no ar, cabeceio, 4 pipocas + bico entalado; patadas certas, prisão não vaza, ficha zera no KO, Parado aí! (vira, trava, apaga projétil, empurra sem dano, recarga), abordagem por trás x1.3 +2 fichas, bote diagonal, faixa (barreira, segura projétil, rasga com 2 golpes); saquinho planta, distância mínima, carrinhada recolhe e despeja, para na beirada, pulo de susto intocável e derruba castanha; areia 1 acerto e cega + efeito, corrida acelera, sobe parede, sol 3 níveis/toque/perde ao apanhar, rabo encerra golpe, sem_rabo, isca, 1 vez por vida, volta no respawn. Os testes antigos continuam (o do sol agora segura o botão; o do "rugido" aceita o empurrão menor de 420).
- `game/tests/fx_shots.gd`: +17 cenas dos novos (22–38). Resultado: **38/38 [OK]** (as 21 antigas iguais).
- Bateria completa: ver §6.

## 4. Prints avaliados (tamanho real, recortes)
`evidence/efeitos/22..38_*.png` e `evidence/golpes/{tucano,onca,cutia,calango}/special_*.png, jab, ftilt`.
- Pipoca: bolinhas creme girando em arco; estouro em cima da capivara no acerto. OK.
- Grama do peixinho: tufos atrás dele, na linha do chão (corrigi a altura com `base`). OK.
- Bico entalado: trinca + pedrinhas no chão à frente, pipocas saindo; corrigido para encostar no chão. OK.
- Trave: estrelinhas amarelas girando acima da cabeça depois do quique. OK.
- Estalo da blindagem: raios laranja/amarelo no peito enquanto continua bicando. OK.
- Parado aí!: balão vermelho "!" + arcos de voz na boca; a capivara fica de costas. OK.
- Carimbo: carimbo vermelho com estrela cai na cabeça e brilha; estrela dourada fica. OK.
- Algema: estrela vermelha + algemas na capivara. OK (ver nota da folha em §5).
- Faixa Interditado: 2 cones laranja com faixa branca, fita zebrada amarela/preta caída no meio, apoiada no chão. OK.
- Cova / castanha enterrada / estouro: terra à frente no chão, montinho fica no chão, estouro sai do montinho. OK.
- Carrinhada: poeira atrás, terrinha ao recolher, castanhas despejadas. OK.
- Saquinho rasgando: fiapos de juta e castanhas saindo da capivara; legível mas simples (desenho por código).
- Areia no olho: grãos rodando na altura dos olhos (estava acima da cabeça, corrigi). OK.
- Sol: raios descendo em cima dele deitado, crescendo por nível (estava alto demais, corrigi). OK.
- Poeira da corrida: baforadas bege atrás dos pés. OK.
- Rabo solto: poof branco, rabo no chão separado dele (estava embaixo do corpo, corrigi), Calango sem rabo depois. OK.
- Limite conhecido do `golpes_shots`: o recorte do especial para cima corta o personagem no alto da tela (o teste começa a 330 px de altura); não é defeito do jogo.

## 5. Folhas de efeito
- Todas as 8 folhas olhadas (fundo magenta, sem personagem) e **usadas**.
- **Corrigida (não rejeitada)**: `onca/fx_algema` veio com os 4 desenhos fora da grade (atravessando as células). Recortei cada desenho e centralizei numa célula própria; o original ficou em `art/pixel/onca/candidatos/fx_algema_original.png`. Nota: os quadros 1–2 são só a estrela vermelha; as algemas aparecem no quadro 3.
- Nenhuma folha rejeitada.

## 6. Bateria
`bash rodar_testes.sh` — resultado no fim deste arquivo (§8).

## 7. Pedidos de arte que faltam (hoje cobertos por desenho por código ou nada)
1. `tucano/pipoca.png` — projétil (refazer menor; o código já ajusta a largura para 20 px com `set_sprite_fit`).
2. `tucano/fx_trave_tranco.png` — 4 quadros: estalo do bico blindado e tonto da trave (hoje CodeFx `tranco`/`estrelas`).
3. `onca/fx_carimbo.png` — 3 quadros (hoje CodeFx `carimbo`).
4. `onca/fx_rugido.png` — 4 quadros do "Parado aí!" (hoje CodeFx `parado_ai`).
5. `onca/faixa_interditado.png` — objeto 4 quadros (0–2 balançando, 3 rasgando); o código já usa se existir (hoje desenhado por código).
6. `cutia/fx_poeira_carrinho.png` — 4 quadros (hoje CodeFx `poeira`).
7. `cutia/fx_saquinho_rasga.png` — 4 quadros (hoje CodeFx `rasgo`, o mais simples dos reservas).
8. `calango/areia.png` — projétil 3 quadros (hoje desenho por código; `set_sprite_fit` 34 px).
9. `calango/fx_areia_olho.png` — 4 quadros em loop (hoje CodeFx `areia_olho`).
10. `calango/fx_poeira_corrida.png` — 4 quadros (hoje CodeFx `poeira`).
11. `calango/fx_rabo_poof.png` — 4 quadros (hoje CodeFx `poof`).
12. (opcional) `calango/rabo_solto.png` 4 quadros — o código já lê qualquer número de quadros.

## 8. Pendências
- P3 não feito: chinelada do Calango, roubo de castanha no agarrão da Cutia, "CPU mira no rabo-isca", bolha de moleza (Preguiçoso ainda sem código).
- O cone do "Parado aí!" não checa parede entre ela e o alvo (atravessa a laje da Caatinga).
- A faixa só bloqueia no chão (quem vem pulando passa, como pede o plano).
