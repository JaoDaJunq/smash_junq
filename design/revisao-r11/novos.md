# Revisão R11 · personagens novos (Tucão, Dona Onça, Cutia, Calango)

> Levantamento (só leitura). Base: fichas em `design/personagens/`, código em `game/scripts/characters/`,
> `novos_smoke.tscn -- tucano onca` (25/25 OK) e prints `evidence/golpes/{tucano,onca}/special_*.png`.
> Nos prints, os 8 especiais dos dois só mostram o sprite + a faísca de acerto genérica: **nenhum efeito
> próprio** (a tabela `MoveFx.RULES` não tem entrada `tucano` nem `onca`). É o "golpe seco" que o João reclamou.

## 0. Bugs achados no caminho (só código, corrigir antes de qualquer coisa)

| # | Onde | Problema | Correção |
|---|---|---|---|
| B1 | `tucao.gd` `BICO` | Usa `"jab_c"`, mas o id do 3º jab é `"jab3"` (`jab_b/jab_c` são só nomes das folhas, ver `pixel_sprite.gd:29`). O 3º jab (bicada) não tem blindagem | Trocar por `"jab3"` |
| B2 | `dona_onca.gd` `PATADAS` | Usa `"jab_b"`; o 2º e 3º jab (`jab2`, `jab3`) não anotam ficha | `["jab","jab2","jab3","ftilt","dtilt","fair","special_side"]` (tirar `nair`, que é giro, não patada) |
| B3 | `marianinha.gd:_on_hit_landed` | Mesmo erro: `trim_suffix("_b"/"_c")` não junta `jab2/jab3` com `jab`; a sequência de jab conta como 3 golpes "diferentes" e sobe a nota | `move_id.trim_suffix("2").trim_suffix("3")` só quando começa com `jab` (avisar o revisor 2) |
| B4 | `tucao.tscn` | Ave sem pulo extra: `air_jumps` fica no padrão 1. A regra do elenco é "Aves: todas com um pulo extra" (Canga tem 2, Marianinha 3) | `air_jumps = 2` |
| B5 | `dona_onca.gd` voz de prisão | O golpe turbinado (x1.5/x1.6) vale para **qualquer** um que ele acertar, e fica guardado se errar (ok); mas as fichas **não zeram quando o alvo leva KO** (estrelas continuam em cima dele depois de voltar) | No `_on_attack_frame`, só turbinar se `_boosted_target` estiver na hitbox; zerar `fichas` quando o alvo emitir `damage_changed(0)` (o `respawn()` já emite) |
| B6 | `dona_onca.gd` rugido | Empurra mudando `velocity.x`, mas quem está em HITSTUN (inclusive hipnotizado) tem a velocidade recalculada de `_launch` todo quadro: o rugido não faz nada nele. O hitbox de dano (raio 46) acerta antes e lança quem está perto, então o empurrão só vale de 116 a 260 px | Empurrar somando em `_launch` quando `state == HITSTUN`; ver proposta nova do rugido abaixo |
| B7 | `onca.md` | Cores ainda da síndica ("roupão rosa-chá, bobes azuis"), mas o concept é delegada | Trocar por blazer escuro `#2B2F3A`, distintivo `#E8B83A`, óculos `#1A1A1A` |
| B8 | `tucano.md` | Mecânica diz "ao tirar KO joga pipoca e grita GOOOL", não existe no código | Ver Tucão §3 (gancho de KO) |
| B9 | `tucao.gd` blindagem | Sem limite: no lado (24 quadros de blindagem a 900 px/s) ele atravessa qualquer golpe, inclusive smash de 20%. Forte já bate muito | Limite por golpe: `ARMOR_MAX := 12.0` de dano; acima disso apanha normal |

---

## 1. Tucão · tucano pipoqueiro do estádio (Forte)

### 1.1 É diferente do elenco?
Ideia boa e única (pipoca + futebol + bico blindado). O que se parece demais:
- **Narrador/gritão** ↔ **Berrante** (bugio radialista, berro em onda). Os dois "gritam". Regra: o Tucão **nunca usa onda de som**; a cara dele é **pipoca e futebol** (peixinho, cabeceio, trave, gol). O grito fica só na piada do KO.
- **Lado "bicada investida"** = mais uma investida reta (Juba investida, Onça patada, Peba rolamento, Calango corrida). Diferenciar com **"Gol de peixinho"** (abaixo): blindado + bate na trave (parede).
- **Baixo "bicada pilão" no ar** ↔ aéreo baixo da Canga (salto plataforma "caindo como pilão") e mergulho do Capivas. Diferenciar pelo chão: **o bico entala** e estoura pipoca do chão.
- **Carrinho de pipoca** do concept ↔ **carrinhada da Cutia**. Deixar o carrinho só para a Cutia; o Tucão usa o **saquinho**.
- **Cima "voo de bico"** = subida reta genérica (Onça, Peba, Canga). Trocar por **"Cabeceio"**, que rebate projéteis.

### 1.2 Efeitos novos (pasta `art/pixel/tucano/`, grade 3x2, só o efeito)
| Arquivo | Pedido ao gerador | Golpe / momento | Posição |
|---|---|---|---|
| `fx_pipoca_estouro.png` | ★ Pipoca estourando: grão de milho amarelo vira flor branca de pipoca, 3 lasquinhas de casca voando | Acerto de cada pipoca (neutro) e saída do saquinho | `target` / boca do saquinho (`front`) |
| `fx_grama_peixinho.png` | ★ Tufo de grama verde e torrões de terra subindo, rastro baixo e comprido | Lado no chão, a cada 4 quadros ativos | `feet` (rastro) |
| `fx_trave.png` | Pancada na trave: estrelinhas amarelas girando + 2 tracinhos de "tóim" (sem letras) | Lado batendo em parede | cabeça (`head`) |
| `fx_bico_entalado.png` | ★ Rachadura em estrela no chão com pedrinhas e 4 pipocas pulando para cima | Baixo no chão (impacto) e quando entala | `feet`, na frente (`front` com y do pé) |
| `fx_cabeceio.png` | Arco branco de impacto em cima da cabeça, como bola batendo na testa, 2 riscos de velocidade | Cima, ao rebater projétil | acima da cabeça (`head`) |
| `fx_gol_pipoca.png` | ★ Chuva de pipoca e confete verde-amarelo caindo de cima (comemoração) | KO dado pelo Tucão | acima dele, 1,2 s |

Reaproveitar: `fx_confete` da Canga não (cores de carnaval); este é o do futebol.

### 1.3 Ajustes de golpe
- **Neutro "Punhado de pipoca"**: pipocas com **gravidade e um quique** (precisa de `gravity`/`bounces` no `Projectile`, ver §5). Constantes: `pipoca_speed 760 → 620`, `PIPOCA_GRAVITY := 1400.0`, ângulos `[-0.35, -0.12, 0.1]` (sobem em arco), vida `0.45 → 0.9`, `PIPOCA_BOUNCES := 1`. No .tres: `damage 3.5 → 3.0`, `hitbox_radius 16 → 14`. Fica "jogar pipoca para o alto" e alimenta o cabeceio.
- **Lado "Gol de peixinho"** (renomear): mesma física (`LUNGE_SPEED 900`), mas no ar vai **reto** (`velocity.y = 0` nos ativos, hoje deixa cair até 60). Se encostar numa parede (`is_on_wall()`) nos ativos: **bate na trave**: `_end_attack()`, `velocity = Vector2(-300*facing, -350)`, `hypnotize(0.45)` (fica tonto) + `fx_trave`. No .tres: `active 14 → 12`, `recovery 20 → 24` (é blindado, tem que ser punível).
- **Cima "Cabeceio"** (troca do voo de bico): sobe `FLY_SPEED 1180 → 1120`, hitbox em cima (já é). Nos ativos, qualquer `Projectile` a menos de 70 px da cabeça (inclusive a pipoca dele) é **rebatido para a frente**: `p.velocity = Vector2(1100*facing, -80)`, `p.owner_fighter = self`, dano do projétil x1.5 (duplicar `p.data`). Mesmo padrão da roda de baiana (`dona_canga.gd:_spin_step`). Fica fora da lista `BICO` (sem blindagem na recuperação).
- **Baixo "Bico pilão"**: no ar continua o mergulho (`DIVE_SPEED 1300`). No chão: crava o bico; se **errar**, entala: `recovery += 18` só nesse caso (no `_on_attack_end` checar `_hit_targets.is_empty()`; mais simples: no quadro `startup+active`, se não acertou, `attack_frame -= 18` uma vez) + `fx_bico_entalado`. Ao bater no chão, solta 4 pipocas para cima (projéteis de 2% cada, `angle 80`, raio 60 px em volta). No .tres: `damage 12 → 13`, `base_knockback 330 → 300`.
- **Mecânica "Bico blindado"**: corrigir B1/B9. Mostrar a blindagem: `modulate` laranja piscando 1 quadro quando absorve + `fx_pipoca_estouro` pequeno no peito (o João precisa VER que ele aguentou).
- **Gol!**: gancho de KO. Em `match_manager.gd` já existe `ko_scored(scorer, victim)`; no Tucão, guardar `_last_victim` + tempo no `_on_hit_landed`; o match chama `scorer_fighter.on_ko_scored()` (método vazio no `Fighter`, novo). O Tucão toca `fx_gol_pipoca` e a pose de vitória por 0.5 s se estiver no chão.

### 1.4 Interações e riscos
- **Hipnose (Sucuri)**: `hypnotize()` não passa por `receive_hit`, então ignora a blindagem. Correto (olhar não é pancada), manter.
- **Laço/abraço (Sucuri), bote (Maracajá), agarrão**: usam `hold()`, passam pela blindagem. Correto (agarrão vence blindagem, regra clássica).
- **Voz de prisão (Onça)**: a blindagem segura o lançamento x1.6; com o limite `ARMOR_MAX 12` a prisão (≥15%) volta a lançar. Sem o limite é um contra cruel.
- **Casco (Peba)**: bicada pelas costas do Peba dá meia força; nada quebra.
- **Roda de baiana (Canga)**: rebate as pipocas, que viram dela. O cabeceio pode rebater de volta (pingue-pongue, é divertido, não quebra: cada rebate troca o dono).
- **Fita (Marianinha)**: destrói pipocas. Ok.
- **Cama elástica**: mergulho do pilão em cima da cama → a cama lança (código da cama só olha `velocity.y >= 0` e posição). Vira combo "pilão + quique", divertido. Risco: o mergulho tem `helpless`? Não (`special_down` não tem `helpless_after`), ok.
- **Estandarte**: bicada derruba com 2 golpes como qualquer um. Opcional: pilão conta como 2 golpes (`_hp -= 2` se `foe.attack_id == "special_down"`), piada boa.
- **Arenas**: "trave" precisa de parede: **Caatinga** (laje alta) e as ilhas do **Cerrado** têm; na Ruínas não. No **Pantanal**, vitória-régia móvel: peixinho fora da borda cai, ok. Risco: `is_on_wall()` também dispara em degrau pequeno do terreno → exigir `get_wall_normal().x == -facing` e altura da parede ≥ 40 px (raycast de 2 pontos).

---

## 2. Dona Onça · onça-pintada delegada do bairro (Pesada)

### 2.1 É diferente do elenco?
A **ficha corrida** é boa e única (a marca fica **no outro**, ao contrário da nota da Marianinha, do ritmo da Canga e do volume do Berrante, que ficam em quem bate). O resto se parece demais:
- **Neutro "Rugido" que empurra** ↔ **Berrante** (berro em onda que empurra) e **paradinha da Canga**. Diferenciar: o rugido vira **"Parado aí!"**: não é onda, é **ordem**. Empurra pouco, **vira o adversário de costas** e **apaga projéteis**.
- **Lado "patada carregada"** ↔ pancada carregada do **Capivas** e espreita da **Maracajá** (as duas carregáveis). E o código nem carrega. Trocar por **"Enquadro"**: patada que **encosta na parede**.
- **Baixo "batida do distintivo" (onda dos dois lados)** ↔ **pisão/tchibum do Capivas**, **paradinha da Canga**, **"teste do som" do Berrante**. É a mais repetida do jogo. Trocar por **"Área interditada"**: objeto de palco (fita zebrada), como estandarte e cama elástica.
- **Cima "salto da onça"** reto = igual Tucão/Peba. Trocar por **bote diagonal**.
- Falta a piada visual: a delegada **anota no caderninho**. Usar em tudo (carimbo, caderninho, cone).

### 2.2 Efeitos novos (pasta `art/pixel/onca/`)
| Arquivo | Pedido ao gerador | Golpe / momento | Posição |
|---|---|---|---|
| `fx_carimbo.png` | ★ Carimbo de madeira batendo e deixando uma estrela de distintivo dourada (3 quadros: desce, bate, estrela brilha) | Cada ficha anotada (substitui as estrelas desenhadas em `ficha_marca.gd`) | em cima do alvo (`target_head`), segue o alvo |
| `fx_algema.png` | ★ Estrela de distintivo vermelha grande estourando em raios dourados + 2 algemas de brinquedo girando | Voz de prisão acertando | `target` |
| `fx_rugido.png` | ★ Arcos amarelo-alaranjados curtos saindo da boca em cone, com 3 rosetas pretas voando dentro (não é anel de som, é "bafo de onça") | Neutro, no startup | `front` (boca) |
| `fx_caderninho.png` | Caderninho abrindo e uma folhinha voando (sem letras, só riscos) | Cada ficha nova, ao lado dela | `head` dela, pequeno (px 1.5) |
| `fx_poeira_parede.png` | Rachadura na parede com reboco e poeira saindo para o lado | Enquadro contra parede | ponto de contato do alvo |
| `faixa_interditado.png` (objeto, não fx) | Dois cones laranja com fita zebrada amarela e preta esticada entre eles, 3 quadros balançando + 1 quadro rasgando | Baixo (objeto que fica no palco) | no chão, como `estandarte.png` |
| `fx_rasto_bote.png` | Rastro de garras: 3 riscos amarelos em arco + rosetas | Cima (bote diagonal) | `behind` |

### 2.3 Ajustes de golpe
- **Neutro "Parado aí!"**: no .tres `startup 14 → 12`, `damage 2 → 0` e `hitbox_radius 46 → 0` (sem hitbox; quem age é o código). No código: cone `ROAR_RADIUS 260`, `absf(d.y) < 100`. Efeito em quem está no cone: `ROAR_PUSH 900 → 420` (empurrão curto; se HITSTUN, somar em `_launch`), **vira de costas** para ela (`f.facing = int(signf(d.x))`, com `d = f.global_position - global_position`) e trava a virada por `ROAR_TURN_LOCK := 0.4` s (campo novo `turn_lock` no `Fighter`, checado onde o lutador vira no chão/ar). Projéteis no cone somem (`queue_free`, mesmo laço da fita da Marianinha). Se o alvo já tem 3 fichas: escudo dele quebra (`_break_shield()`): "teje preso!". Recarga: `ROAR_COOLDOWN := 1.5` s para não virar trava infinita.
- **Lado "Enquadro"**: avança como hoje (`POUNCE_SPEED 760`), sem carga (tirar "carregada" da ficha). No acerto: se houver parede/limite de terreno a ≤ 160 px atrás do alvo (raycast `LAYER_STAGE` na direção `facing`), o golpe vira **"encosta na parede"**: `base_knockback x1.3`, ângulo 38 → 20 (bate e prende na parede) + `fx_poeira_parede` + **+2 fichas** em vez de 1. No .tres: `startup 16 → 14`, `damage 14 → 12` (o bônus de parede compensa).
- **Cima "Bote da onça"**: `velocity = Vector2(480*facing, -1080)` (diagonal) em vez de reto. No .tres `hitbox_offset (10,-70) → (40,-50)`, `angle 85 → 60`. Pode agarrar a borda de um pouco mais longe nos ativos: `ledge_reach (70,50) → (100,70)` só durante o golpe.
- **Baixo "Área interditada"**: bate o distintivo (mantém hitbox pequena: `hitbox_radius 90 → 50`, `damage 9 → 6`) e finca a faixa (objeto novo `FaixaInterditada`, ver código abaixo). Uma por vez.
- **Ficha corrida**: `fx_carimbo` no lugar das estrelas desenhadas; na 3ª, `fx_algema` + a dona Onça faz `fx_caderninho`. Corrigir B2/B5.

```gdscript
class_name FaixaInterditada
extends Node2D
## "Área interditada" da Dona Onça (especial para baixo). Dois cones com fita.
## Adversário que ATRAVESSA a fita leva +1 ficha e é freado. 2 golpes rasgam.
const LIFETIME := 7.0
const WIDTH := 150.0         # entre os cones
const HITS := 2
const BRAKE := 0.3           # velocity.x *= BRAKE ao atravessar
const CROSS_COOLDOWN := 0.8  # por lutador
const SPRITE_PATH := "res://assets/characters/onca/pixel/faixa_interditado.png"
# plant(by, at) igual Estandarte.plant (grupo "match_cleanup" e "faixas"),
# chão por raycast LAYER_STAGE. _physics_process: para cada foe != dona:
#   lado = signf(foe.x - global_position.x); se lado mudou desde o quadro anterior
#   e foe.feet.y perto do chão da faixa (+-30) e |foe.x - x| < WIDTH*0.5+10:
#      owner.set_ficha(foe, mini(3, owner.ficha_de(foe)+1)); foe.velocity.x *= BRAKE
#   golpes ativos do adversário na caixa Rect2(-75,-50,150,50) tiram 1 de _hp (igual estandarte).
```

### 2.4 Interações e riscos
- **Peba (casco)**: "Parado aí!" vira o Peba **de costas para ela** → o casco fica do lado dela e a patada seguinte bate meia força. É uma piada ótima e um contra-jogo legítimo (a Onça tem que escolher). Documentar na dica de jogo.
- **Sucuri hipnose**: alvo hipnotizado + rugido: com a correção B6 ele desliza um pouco parado. Não empilhar: se `foe._hitstun > 0`, não aplicar `turn_lock`.
- **Juba/Maracajá contra-ataque**: o rugido não tem hitbox (proposta), então não ativa o contra. Bom: é a resposta da Onça a quem fica parado esperando.
- **Canga estandarte**: a faixa e o estandarte são objetos parecidos; manter as regras iguais (2 golpes, 1 por vez, `match_cleanup`). A faixa **não** pode ser fincada a menos de 120 px de um estandarte (senão um sprite cobre o outro).
- **Cama elástica**: a faixa no mesmo lugar da cama: quem quica e cai do outro lado conta "atravessou"? Pela regra do lado mudar com o pé perto do chão: só conta no chão. Ok.
- **Tucão blindado**: o enquadro lança pouco por causa da blindagem; ficha conta mesmo assim (o `_on_hit_landed` roda porque `receive_hit` retorna true). Ok.
- **Arenas**: enquadro rende na **Caatinga** (laje) e nas ilhas do **Cerrado**. No **Pantanal**, a faixa em cima da ilha de barro só (raycast `LAYER_STAGE`, não fica na vitória-régia móvel; se ficasse, não acompanharia o movimento). Risco: `turn_lock` precisa ser zerado no `respawn()`.

---

## 3. Cutia Ligeira · cutia feirante de castanha (Rápida, sem código)

### 3.1 É diferente do elenco?
Mecânica de **armadilha no chão** é única no elenco (ninguém prepara o palco escondido). O que conflita:
- **Neutro "saquinho de castanha"** ↔ **Castanha do Juba** (neutro dele, projétil reto). Mesma coisa com outro nome. Trocar por **ouriço-da-castanheira**: a cutia é o único bicho que consegue abrir o ouriço (fato real, ótimo para a ficha). Projétil **pesado, rolando e quicando**, nada a ver com a castanha reta do Juba.
- **Lado "carrinhada"** = mais uma investida. Diferenciar com **"Entrega expressa"**: o carrinho **pega o adversário**, leva e despeja.
- **Rápido** junto com Juba (aéreo), Maracajá (rasteiro/parede) e Calango. Papel da Cutia: **rápida de chão que arma o palco** (planta, corre, faz o outro pisar).
- **"Rouba frutas e some"** do elenco ficou de fora da ficha; entra no agarrão (rouba castanha, ver abaixo).

### 3.2 Efeitos (pasta `art/pixel/cutia/`)
| Arquivo | Pedido ao gerador | Golpe / momento | Posição |
|---|---|---|---|
| `fx_cova.png` | ★ Terra marrom sendo cavada e jogada para trás em 3 punhados, montinho no fim | Baixo (enterrar) | `feet` |
| `castanha_enterrada.png` (objeto) | Montinho de terra com a pontinha de uma castanha aparecendo; 2 quadros: quieto / tremendo (armada) | Fica no chão | no chão |
| `fx_estouro_castanha.png` | ★ Explosão de terra com castanhas voando para cima e folhinhas | Armadilha disparando | onde estava |
| `ourico.png` (projétil) | Ouriço de castanha: bola marrom de casca grossa com a "tampinha" redonda, 4 quadros girando | Neutro | projétil |
| `fx_ourico_abre.png` | Ouriço rachando em gomos e castanhas saindo | Ouriço acertando ou parando | `target` |
| `fx_poeira_carrinho.png` | Poeira de feira + 2 folhas de alface voando | Lado, a cada 4 quadros ativos | `feet` |
| `fx_castanhas_caindo.png` | 5 castanhas caindo do avental, girando | Cima (ao pular) | `below` |
| `carrinho.png` (só se o sprite do especial lado não tiver o carrinho) | Carrinho de mão de madeira com castanhas | — | — |

### 3.3 Especiais propostos (código, `cutia.gd`, `class_name CutiaLigeira extends Fighter`)
```gdscript
const PROJECTILE := preload("res://scenes/combat/projectile.tscn")
const PIX := "res://assets/characters/cutia/pixel/"
# Neutro "Ouriço de castanha": rola e quica. Em cima de uma castanha dela: desenterra
# e o arremesso sai "turbinado".
const OURICO_SPEED := Vector2(560.0, -380.0)   # arco
const OURICO_GRAVITY := 1500.0
const OURICO_BOUNCES := 2                      # quica 2x e rola
const OURICO_LIFE := 1.6
const DESENTERRA_RANGE := 50.0                 # pé a até 50 px de uma castanha dela
const TURBO_DAMAGE := 1.6                      # x dano/lançamento do ouriço desenterrado
# Lado "Entrega expressa": empurra o carrinho; quem bater na frente é pego e levado.
const CART_SPEED := 820.0
const CART_CARRY := 16       # quadros levando o adversário
const CART_DUMP := Vector2(380.0, -520.0)  # despejo (vira throw_data própria)
# Cima "Pulo de susto": pulo reto altíssimo e instantâneo; derrama castanhas para baixo.
const SCARE_JUMP := 1350.0
const DROPS := 3             # castanhas que caem (projéteis de 3%, só para baixo)
# Baixo "Enterra castanha": cava e deixa uma armadilha.
const MAX_BURIED := 3        # a 4ª faz a mais antiga sumir
const ARM_TIME := 0.6        # s até armar (montinho treme)
const TRAP_DAMAGE := 7.0
const TRAP_ANGLE := 80.0     # joga para cima
const TRAP_KB := 300.0
const TRAP_GROWTH := 5.0
const TRAP_LIFE := 14.0
```
Regras:
- **Neutro**: `_on_attack_frame` no startup → se `_castanha_perto()` (dela, a ≤ 50 px dos pés): remove o objeto, usa `attack.duplicate()` com dano/knockback x1.6 e `fx_cova`. Spawna `Projectile` com `gravity`/`bounces` (§5) e `ourico.png`. No ar: só arremessa (sem desenterrar).
- **Lado**: igual dash do Peba, mas `_check_hits` próprio: o 1º alvo atingido vira `hold(target)` e anda junto `CART_CARRY` quadros; no fim (ou se faltar chão à frente, raycast como `seu_peba._burrow_move`), `throw_held(cart_throw, facing)`. **Para na borda** (não sai do palco levando ninguém, evita suicídio duplo). Escudo bloqueia (não é agarrão). No ar: só um passo curto sem pegar ninguém (`velocity.x = 500*facing`, sem hold).
- **Cima**: `velocity.y = -SCARE_JUMP` no quadro 3 (sai rápido, é de susto), `helpless_after = true`; solta 3 projéteis para baixo (`Vector2(±80, 500)`), dano 3, ângulo -60 (afunda quem está embaixo na borda).
- **Baixo**: só no chão (`LAYER_STAGE`, igual cama elástica: não em plataforma fina nem móvel). `startup 14`, `recovery 16`, sem hitbox. Cria `CastanhaEnterrada` (objeto novo, grupo `match_cleanup` e `castanhas`). No ar: aéreo baixo normal (coice).
- **CastanhaEnterrada**: arma depois de `ARM_TIME`; estoura quando os pés de um adversário ficam a ≤ 34 px no chão (`is_on_floor()`), com `AttackData` próprio (7%, ângulo 80) e `fx_estouro_castanha`. A dona não dispara as próprias. Somem em `TRAP_LIFE` s, com KO da dona não (ficam; é a graça), mas a revanche limpa (`match_cleanup`).
- **Agarrão "Rouba e some"** (só código, opcional P3): arremesso para trás rouba "a castanha" do outro: ela ganha 1 castanha extra no limite (`MAX_BURIED + 1` por 8 s). Ligação direta com o "rouba frutas" do elenco.

No `.tres` (`cutia.tres`, partir do `agil.tres`): `special_neutral startup 12 active 2 recovery 16 damage 6 angle 40 bkb 200 growth 4.5 radius 22`; `special_side startup 8 active 14 recovery 18 damage 5 (o despejo dá o resto: 6, angle 45, bkb 260, growth 6.5)`; `special_up startup 3 active 6 recovery 14 damage 4 helpless_after`; `special_down startup 14 active 0 recovery 16`. Peso ~85, `run_speed 640` (a mais rápida no chão), `air_speed 380` (fraca no ar, ao contrário do Juba).

### 3.4 Interações e riscos
- **Peba (toca)**: quando o Peba passa por baixo da terra por cima de uma castanha, ela **estoura sem dano** ("cavou e achou"). Precisa: no `_burrow_move`, chamar `castanha.defuse()` para cada uma no caminho. Ótima interação, barata.
- **Sucuri abraço/laço**: alvo preso em cima da castanha não dispara (pés não estão no chão/`state == HELD`). Ok.
- **Cama elástica / estandarte / faixa da Onça**: castanha não pode ficar a < 60 px de outro objeto de chão (sprites se cobrem e o jogador não vê a armadilha).
- **Hipnose em cima da castanha**: hipnotizado parado em cima de uma castanha armada estoura na hora (pés no chão). Combo Sucuri+Cutia só existe em 2v2; em 1v1 nada quebra.
- **Roda de baiana / fita / cabeceio**: o ouriço é `Projectile` normal, pode ser rebatido/destruído. Ok.
- **Arenas**: **Pantanal** tem pouco chão sólido (ilha de barro): 3 castanhas cobrem a ilha inteira → `MAX_BURIED 3` ok, mas distância mínima entre castanhas de 90 px. **Cerrado** compacto: idem. Castanha nunca em `LAYER_PLATFORM` (galhos do ipê, vitória-régia) porque não acompanharia a plataforma.
- **CPU**: o `cpu_brain` não sabe das armadilhas; ele vai pisar sempre. Para não ficar fácil demais, a castanha pisca 1 quadro a cada 1 s (visível para humano e "justo").

---

## 4. Calango · lagarto ambulante de praia (Rápido, sem código)

### 4.1 É diferente do elenco?
**Rabo solto** é a melhor ideia das 4 fichas: única e com cara do bicho. O que conflita:
- **"Corre até pela parede"** (elenco) ↔ **Maracajá gruda na parede**. Diferenciar: o Calango **não gruda**; ele **corre parede acima sem parar** só durante a corrida (lado). A Maracajá para e pula; o Calango sobe correndo.
- **Neutro "joga areia"** ↔ **magnésio da Marianinha** (nuvem de pó). Diferenciar: areia é um **punhado arremessado** (projétil curto em leque, amarelo), e o efeito é **cegar** (erra o próximo golpe), não escorregar.
- **Baixo "tomar sol" deitado** ↔ **cochilo da Maracajá** e **descanso/gato no sol** dela. Diferenciar com o gesto real do calango: **flexões** (lagarto faz "flexão" de cabeça no sol). Em pé na pedra, fazendo flexões, com óculos escuros.
- **Lado "corrida"** = mais uma investida reta. Diferenciar: **acelera enquanto segura**, atropela várias vezes e **sobe parede**.
- Piada de ambulante (picolé, guarda-sol) não aparece em golpe. Proposta: o **guarda-sol** é a recuperação (abre e plana) e o **picolé** cura nada mas é a pose do sol.

### 4.2 Efeitos (pasta `art/pixel/calango/`)
| Arquivo | Pedido ao gerador | Golpe / momento | Posição |
|---|---|---|---|
| `areia.png` (projétil) | ★ Punhado de areia amarela em leque, grãos soltos, 3 quadros abrindo | Neutro | projétil curto |
| `fx_areia_olho.png` | ★ Grãozinhos de areia girando em volta da cabeça + 2 lágrimas azuis (o alvo esfrega o olho) | Alvo cegado, loop enquanto dura | `target_head`, segue o alvo |
| `fx_poeira_corrida.png` | Poeira de areia de praia saindo dos pés em jatos curtos, cada vez maior | Lado, a cada 3 quadros ativos | `feet` (`behind`) |
| `fx_sol.png` | ★ Raios de sol amarelos descendo sobre ele + brilho; 3 níveis (o jogo usa px 1.5/2/2.5) | Baixo, a cada flexão | `head` |
| `fx_aquecido.png` | Rastro de calor (ondinhas laranja) atrás dele enquanto está acelerado | Buff do sol, a cada 8 quadros correndo | `behind` |
| `rabo_solto.png` (objeto) | ★ Rabo de lagarto solto se mexendo em S no chão, 3 quadros | Mecânica rabo solto | no chão |
| `fx_rabo_poof.png` | Nuvenzinha branca de "poof" + estrelinha (sem sangue, cartoon) | Momento em que o rabo solta | `behind` |
| `guarda_sol.png` (só se o sprite do especial cima não tiver) | Guarda-sol listrado aberto, visto de lado | — | — |

### 4.3 Especiais propostos (código, `calango.gd`, `class_name Calango extends Fighter`)
```gdscript
# Neutro "Joga areia": leque curto; quem leva fica de "olho cheio de areia".
const SAND_SPEED := 700.0
const SAND_LIFE := 0.25          # curtíssimo (≈175 px)
const SAND_SPREAD := [-0.18, 0.0, 0.18]
const BLIND_TIME := 2.0          # s; o 1º golpe corpo a corpo dele nesse tempo ERRA
# Lado "Corrida de calango": acelera enquanto segura; sobe parede.
const RUN_MIN := 600.0
const RUN_MAX := 1250.0
const RUN_ACCEL := 1800.0        # px/s²
const RUN_MAX_FRAMES := 50
const RUN_TICK := 8              # atropela de novo a cada 8 quadros
const WALL_RUN_SPEED := 900.0    # na parede: vira velocidade para cima
const WALL_RUN_FRAMES := 18
# Cima "Guarda-sol": salta e abre o guarda-sol; desce planando.
const HOP_SPEED := 1050.0
const GLIDE_FALL := 260.0        # (Canga usa 220; manter maior para não ser igual)
const GLIDE_TIME := 1.2
# Baixo "Tomar sol" (flexões): cada toque de Especial durante o golpe = 1 flexão.
const SUN_LEVELS := 3
const SUN_PER_PUSHUP := 1        # 3 flexões = nível 3
const SUN_SPEED_BONUS := [0.0, 0.10, 0.20, 0.30]   # walk/run/air
const SUN_TIME := 7.0
# Mecânica "Rabo solto": 1 vez por vida.
const TAIL_MIN_LAUNCH := 1500.0  # velocidade de lançamento que ativa
const TAIL_KEEP := 0.25          # lançamento fica em 25%
const TAIL_INVULN := 0.5
const TAIL_LIFE := 4.0           # rabo no chão
```
Regras:
- **Cegueira (só código, no `Fighter`)**: campo `blind_time`. Em `Fighter._check_hits`, se `blind_time > 0` e é o 1º golpe com alvo dentro: não acerta, `blind_time = 0`, toca `fx_areia_olho` sumindo. Projéteis do cegado não erram (simplifica; documentar). Zerar no `respawn()`.
- **Neutro**: 3 `Projectile` de areia com `SAND_LIFE`; dano 1, `base_knockback 60` (quase não empurra); no acerto, `target.blind_time = BLIND_TIME` + `fx_areia_olho` seguindo (`set_meta("follow")`, igual hipnose). Não acumula: reaplicar só renova.
- **Lado**: enquanto `controls.pressed("special")` e `frame < RUN_MAX_FRAMES`, `attack_frame = startup+1` e `velocity.x = move_toward(velocity.x, RUN_MAX*facing, RUN_ACCEL*dt)`; não vira; `_hit_targets.clear()` a cada `RUN_TICK`. Se `is_on_wall()` com parede alta (mesmo teste do Tucão): `velocity = Vector2(0, -WALL_RUN_SPEED)` por `WALL_RUN_FRAMES`, depois sai em `AIR` com 1 pulo de volta. Para na borda só se o jogador soltar (corre para fora se quiser: é rápido, volta fácil). Dano por toque 3, `angle 45`, `bkb 160`, `growth 3.0`; o último toque (soltar o botão) 6%, `growth 6.0`.
- **Cima**: `velocity.y = -HOP_SPEED`, hitbox de cabeçada com o guarda-sol fechado (5%); no fim, planando com `max_fall = GLIDE_FALL` por `GLIDE_TIME` (pode andar para os lados). Pular ou atacar fecha o guarda-sol. `helpless_after = true` só ao fechar.
- **Baixo**: no chão; o golpe dura até 90 quadros; cada `just_pressed("special")` com 12 quadros de intervalo = 1 flexão + `fx_sol` (nível sobe até 3). Soltar direção/pular cancela. O buff multiplica `walk/run/air_speed` por `1+bônus` por `SUN_TIME` s e solta `fx_aquecido`. **Levar golpe durante as flexões perde 1 nível** (risco real).
- **Rabo solto**: em `receive_hit`, calcular `Combat.launch_speed(data, damage_percent + data.damage, weight)`; se `>= TAIL_MIN_LAUNCH` e `has_tail`: chama `super` com `data` duplicado (`base_knockback/knockback_growth * TAIL_KEEP`), `invincible_time = TAIL_INVULN`, cria `RaboSolto` no chão (raycast `LAYER_STAGE`, cai como a cama elástica) e `fx_rabo_poof`. `has_tail = true` no `respawn()`. O **rabo-isca**: o `cpu_brain` mira nele por 1 s (precisa de 1 linha na escolha de alvo, via grupo `iscas`); para humanos é só a piada.

No `.tres` (`calango.tres`, partir do `agil.tres`): `special_neutral startup 9 active 3 recovery 16 damage 1`; `special_side startup 8 active 6 recovery 20 damage 3 angle 45 bkb 160 growth 3.0`; `special_up startup 5 active 8 recovery 10 damage 5 angle 80`; `special_down startup 10 active 0 recovery 14`. Peso 80 (o mais leve depois da Marianinha), `run_speed 600`, `air_speed 400`.

### 4.4 Interações e riscos
- **Sucuri hipnose ↔ areia**: alvo com `blind_time > 0` **não é hipnotizado** (olho fechado de areia) e uma **Sucuri cegada erra a hipnose**. Uma linha em `mestra_sucuri._hypnotize`. Interação temática ótima.
- **Juba/Maracajá contra-ataque**: com cegueira, o contra-ataque deles "pega" mas o golpe de resposta erra? O contra chama `receive_hit` direto, não `_check_hits`, então **não erra**. Decidir: deixar (contra é reflexo, não precisa ver).
- **Tucão blindado**: rabo solto + blindagem nunca se encontram (um é de quem apanha, outro de quem bate). Prisão da Onça (x1.6) é o gatilho mais comum do rabo solto: a ficha zera do mesmo jeito (B5). Ok, é a graça: "fugiu da prisão".
- **Peba casco**: sem conflito.
- **Corrida na parede**: só a **Caatinga** (laje à esquerda) e as ilhas do **Cerrado** têm parede de verdade. É a arena do calango (sertão): bom. Risco: subir parede **por baixo** do palco principal (paredes das ilhas viram "escada infinita") → limitar a 1 subida por pulo (resetar ao pousar), igual o `CLING_COOLDOWN` da Maracajá.
- **Cama elástica + guarda-sol**: quicar na cama e abrir o guarda-sol = subir muito e planar = fuga longa. Limitar: abrir o guarda-sol 1 vez por pulo.
- **Rabo solto e a zona de KO**: se o lançamento já reduzido ainda leva para fora, não salva; ok. Risco de bug: o `receive_hit` dele precisa vir **antes** do escudo e do `release_hold` do `super` (copiar a ordem de `seu_peba.gd`).
- **Arte**: o sprite continua com rabo depois de soltar (sem folhas novas sem rabo). Aceitar como desenho animado (o rabo "cresce" no quadro seguinte) ou, em P3, pedir `parado/andar/correr/pulo` sem rabo (4 folhas). Recomendo aceitar.

---

## 5. Código compartilhado (vale para os 4)
- `Projectile`: `var gravity := 0.0`, `var bounces := 0` (no chão: raycast `LAYER_STAGE` no movimento; `velocity.y = -absf(velocity.y)*0.55`, `bounces -= 1`; sem quiques sobrando, some ou rola por 0.3 s). Usado por pipoca, ouriço, castanhas caindo.
- `Fighter`: `blind_time`, `turn_lock`, `on_ko_scored()` vazio; zerar os dois no `respawn()`.
- `MoveFx.RULES`: entradas `tucano`, `onca`, `cutia`, `calango` com os gatilhos que já existem (`impact`, `active`, `hit`, `frame`). Gatilhos novos: `armor` (Tucão), `ko`, `ficha` (chamados pelo personagem, como `on_shell_block`).
- `FichaMarca`: trocar o desenho de estrelas por `fx_carimbo.png` quando existir (mantém o desenho como reserva).
- Objetos de chão (estandarte, cama, faixa, castanha): função comum `ArenaUtil.floor_below(at)` (`LAYER_STAGE`) e checagem de distância mínima entre objetos (grupo `objetos_chao`).

---

## 6. Lista priorizada

### Só código
- **P1** B1–B6 e B9 (ids `jab2/jab3`, `air_jumps 2` do Tucão, ficha zera no KO, rugido em hitstun, limite da blindagem `ARMOR_MAX 12`).
- **P1** `MoveFx.RULES` para `tucano`/`onca` já ligadas aos nomes de arquivo acima (aparecem sozinhas quando a folha chegar).
- **P1** `Projectile.gravity/bounces` (pipoca em arco; destrava ouriço da Cutia).
- **P1** Onça: "Parado aí!" (vira de costas, apaga projétil, `turn_lock`), "Enquadro" com bônus de parede, bote diagonal.
- **P1** Tucão: peixinho reto + trave na parede, cabeceio que rebate projéteis, bico entalado.
- **P1** Cutia e Calango: especiais acima + `CastanhaEnterrada`, `blind_time`, rabo solto (com os testes no `novos_smoke`: castanha estoura ao pisar, Peba desarma, areia faz errar 1 golpe, rabo solto salva 1x por vida, corrida sobe parede só na Caatinga/Cerrado).
- **P2** Onça `FaixaInterditada`; Tucão gancho de KO "Gol"; Sucuri × areia; Peba desarma castanha.
- **P2** B3 (Marianinha jab) e B7/B8 nas fichas.
- **P3** Pilão conta 2 no estandarte; Cutia rouba castanha no agarrão; CPU mira no rabo-isca e enxerga castanha.

### Precisa de imagem nova (só efeito, folha separada)
- **P1** (★, mudam a cara do golpe): `tucano/fx_pipoca_estouro`, `tucano/fx_grama_peixinho`, `tucano/fx_bico_entalado`, `onca/fx_carimbo`, `onca/fx_algema`, `onca/fx_rugido`, `cutia/ourico`, `cutia/castanha_enterrada`, `cutia/fx_estouro_castanha`, `cutia/fx_cova`, `calango/areia`, `calango/fx_areia_olho`, `calango/fx_sol`, `calango/rabo_solto` (14 folhas).
- **P2**: `tucano/fx_gol_pipoca`, `tucano/fx_trave`, `tucano/fx_cabeceio`, `onca/faixa_interditado`, `onca/fx_poeira_parede`, `onca/fx_rasto_bote`, `cutia/fx_poeira_carrinho`, `cutia/fx_castanhas_caindo`, `calango/fx_poeira_corrida`, `calango/fx_rabo_poof`, `calango/fx_aquecido`.
- **P3**: `onca/fx_caderninho`, `cutia/fx_ourico_abre`; folhas do Calango sem rabo (só se o João não aceitar o "cresce na hora").
- Antes de pedir as de Cutia/Calango: conferir se os sprites `especial_lado` (carrinho) e `especial_cima` (guarda-sol) já desenham o objeto; se não, entram `carrinho.png` e `guarda_sol.png` como folhas separadas.
