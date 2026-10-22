# Revisão e correção: Dona Canga, Marianinha e Seu Capivas (4 arenas)

Ponto de partida: a revisão r11 (`design/revisao-r11/trio.md`) tinha a lista de defeitos, mas nenhum estava corrigido no código. Aqui eu **corrigi** a maior parte, conferi de novo nas 4 arenas (números + prints) e acrescentei detalhes que dão mais cara de cada personagem. Não rodei git.

## Como testei
- `tests/trio_diag.tscn` (headless, já existia): mede cada especial dos 3 nas 4 arenas: beirada, plataformas (as vitórias-régias também), laje da Caatinga, no ar, fora do palco, interações e recuperação. **Antes: ~40 alertas. Depois: 17**, e todos os 17 são falsos ou vêm do próprio teste (ver "Alertas que sobraram"). Log: `scratch/rev/diag2.log` e `diag3.log`.
- `tests/revisao_trio_shots.tscn` (novo, com janela): é uma cópia do `trio_shots` com os casos novos `golpes` (paradinha, esplendor, estandarte jogado do ar, estandarte na vitória-régia depois de 2 s, tontura, magnésio, adversário quicando na cama, arco rolando, plaquinha, pisão no chão e no ar, pulo alto). Os prints ficam em `evidence/revisao-canga/<arena>_<caso>.png`: 35 por arena, 4 arenas. Olhei todos em recortes no tamanho real ou ampliados.
  `"$G" --path game --resolution 1920x1080 res://tests/revisao_trio_shots.tscn -- [0-3] [cama|estandarte|tchibum|roda|arco|fita|extra|golpes]`
- Sondas headless novas: `tests/revisao_probe.tscn` (estandarte e cama a 12 e a 90 px da quina, nas 4 arenas), `revisao_probe2.tscn` (estandarte e cama na vitória-régia que sobe e desce) e `revisao_probe3.tscn` (ponta da laje da Caatinga).
- Bateria `rodar_testes.sh`: **15/15 OK, 0 erros de script** (no fim, com todas as mudanças).

## Por arena (depois das correções)
| Arena | O que conferi | Resultado |
|---|---|---|
| Ruínas da Mata | cama e estandarte nas 2 quinas e nas 2 plataformas, pisão aéreo, bufada, roda contra quem está pendurado, fita a 250/350/450 px, arco na beirada, recuperação | tudo apoiado e visível (antes, a bandeira, a cama e as plumas ficavam **atrás das montanhas do fundo**: ver D11) |
| Pantanal | o mesmo + estandarte e cama **na vitória-régia que se mexe** | os dois acompanham a folha (diferença de 1 px); nada cai na lagoa |
| Caatinga | o mesmo + estandarte de frente para a laje, arco contra a laje, cama e estandarte na ponta de cima da laje | a bandeira não entra mais na rocha; o arco quica na laje e volta |
| Cerrado | o mesmo + vãos grandes entre as ilhas e galhos | tudo apoiado; o Capivas agarra a quina no pisão aéreo e no pulo alto |

## Defeitos achados e corrigidos (arquivo:linha atual)

### Seu Capivas (`pesado.gd`, `move_fx.gd`)
- **C1 Torre de tchibuns no pisão aéreo:** a regra "impact" do MoveFx disparava a cada quadro do mergulho. Agora o tchibum sai do `pesado.gd`, uma vez só: no pisão no chão (`pesado.gd:152`, escala 2,4) e **no pouso do mergulho, maior** (`:68`, escala 3). A base da folha fica no chão (`_tchibum`, `:214`). No `move_fx.gd` só tirei as 2 regras do Capivas (linhas 16-19); o código geral do arquivo ficou igual.
- **C2 A bufada quase não aparecia:** agora sai a cada 10 quadros de carga e **cresce com a carga** (escala 1,6 → 3,0), com espelho pelo lado (`:87`, `_bufada` `:220`). O diagnóstico conta 6 bufadas (antes, 1).
- **C3 Pisão aéreo fora do palco = KO certo:** quando não tem chão embaixo, durante o mergulho ele pode agarrar a quina (`:159`). Agarrou nas 4 arenas.
- **Novo · pulo alto passava do lado da quina sem pegar:** na descida, ainda dentro do golpe, ele pode agarrar a quina (`:141`). No Cerrado, o caso "300 px fora / 350 abaixo" do lado direito passou a funcionar.
- **Cara do golpe:** no pulo alto sai um espirro pequeno do chão, "pulando da piscina" (`:135`).

### Marianinha (`marianinha.gd`, `cama_elastica.gd`, `marianinha.tres`)
- **M1 A cama atravessava as plataformas e caía na lagoa:** agora o raio vê palco e plataforma (`marianinha.gd:234`, `cama_elastica.gd:15`), a cama gruda na plataforma e **acompanha a vitória-régia** (`cama_elastica.gd` `_settle`).
- **M2 Cama com metade no vazio na quina:** ela escorrega para dentro até as duas pernas apoiarem (`_fit_on_floor`, `cama_elastica.gd:76`).
- **M3 (ALTA) Agarrão no ar em cima da cama prendia a vítima para sempre:** a cama não lança quem está agarrado, agarrando, pendurado, voltando ou atordoado (`NO_BOUNCE`, `:18`). Quem estiver no meio de um golpe tem o golpe encerrado do jeito certo (`_end_attack`, `:116`). O diagnóstico agora dá 9 quadros presa (antes, 600).
- **Novo · a cama flutuava 16 px:** a folha era desenhada alta demais. Agora as pernas tocam o chão (`:136`), e quem pisa quica na altura da lona (`LONA`, `:13`).
- **M4 A fita desenhada acertava só até a metade:** agora são 6 pontos de acerto ao longo da fita desenhada, de 40 a 530 px (`RIBBON_*`, `marianinha.gd:32-35`, `_ribbon_step`). Acerta a 250, 350 e 450 px. Para não ficar forte demais, o toque baixou de 2,5 para 2,0 (`marianinha.tres:112-114`). A fita segurada inteira tira 20-26%. Projétil cortado pela fita solta uma poeirinha de magnésio.
- **M5/M6 Nota 10:** o 10 agora é gasto **no começo** do próximo golpe, que leva o bônus (`:156`). A fita não gasta mais o 10 sem dar bônus, e o arco não fica com +50% para sempre (dano dos arcos: 9, 6, 6). Cada uso conta **uma vez** para a nota: uma fita inteira vale 1 golpe. O acerto do arco agora entra na nota (`_hook_foes`/`_on_foe_hit`, `:65`).
- **M7 O arco atravessava a laje e saía voando do palco:** quando bate na parede, quica e volta. Rolando no chão, volta na hora quando o chão acaba (`_guide_hoop`, `:79`). Nos prints ele fica em cima do palco.
- **Cara do golpe:** a nuvem de magnésio ficou do tamanho da área do golpe (escala 3, `:247`). A plaquinha dos jurados dá um pulinho quando a nota muda e ganhou um cabinho (`_draw`). O confete da nota 10 sai em cima do alvo. Os efeitos agora espelham pelo lado.

### Dona Canga (`dona_canga.gd`, `estandarte.gd`)
- **D1/D2/D3 Estandarte no vazio, dentro da laje, ou caindo da plataforma para o chão de baixo:** `_plant_flag` foi reescrito (`dona_canga.gd:197`). Ele começa nos pés dela, não atravessa parede e vê palco e plataforma. Recua de 10 em 10 px até achar chão, com o mastro pelo menos 30 px para dentro da quina; também procura até 80 px **atrás** dela, porque o avanço do golpe às vezes leva a Canga para fora da quina.
- **D4 Estandarte parado no ar quando a vitória-régia se mexe:** ele acompanha a plataforma (`estandarte.gd:99`). Quando é fincado no ar, **cai até o chão** e some se cair do palco (`_settle`, `:63`). Só dá "ritmo" se estiver fincado.
- **D5 A roda puxava quem estava pendurado para dentro da pedra:** ela ignora quem está pendurado, agarrado ou voltando, e a puxada usa `move_and_collide`, que respeita parede (`:178`).
- **D6 Tontura com cara de "levou golpe":** depois de girar demais, ela usa a folha `tonto` (`anim_override`, `:107`).
- **D7 Barra da nota do desfile em cima do "P1":** a barra subiu para cima do texto (`:265`).
- **D8 O pulso de plumas flutuava ~20 px e ficava escondido:** agora tem escala 2,6, a base no chão e é mais largo que a saia (`:68`).
- **D9 Apoteose fácil demais com o estandarte:** a roda conta 1 vez por giro (`:233`). Quando o golpe só está "na batida" por causa da bandeira, a nota sobe metade (`_beat_from_flag`, `:122`). Com a bandeira, a Apoteose saiu com 6 golpes (antes, 4). O teste de 4 golpes na batida de verdade continua passando.
- **D10:** o confete da paradinha ficou do tamanho da área do golpe (escala 3,6) e ganhou uma onda de plumas no chão (`:148`). O esplendor solta penas (`:141`). A roda, ao rebater o arco da Marianinha, faz o arco não "voltar para a mão" de ninguém (`return_after = -1`) e devolve 20% mais rápido, com um tufo de plumas (`:187`). Os efeitos espelham pelo lado.
- **D11 (novo, ALTA visual) Bandeira, cama, plumas e espirro "de trás" sumiam atrás do fundo da Ruínas:** eles usavam z −1, e as montanhas do fundo (z 0) cobriam tudo. Na Ruínas, a cama da quina nem aparecia. Agora usam z 0 e entram **antes do lutador** na árvore: ficam atrás dos lutadores, mas na frente do cenário (`estandarte.gd:41`, `cama_elastica.gd:40`, `dona_canga.gd:95`, `pesado.gd:207`).
- **Cara do golpe:** a **coroa pisca no ritmo** (brilho dourado no turbante a cada batida, como diz a ficha, `:255`). Golpe que entra na batida solta confete no alvo. Ao fincar a bandeira, sai um confete.
- **Interação nova:** a bandeira agora também cai com **projéteis**: o projétil some e conta como 1 dos 2 golpes. Ela treme quando apanha (`estandarte.gd:117`).

## Alertas que sobraram no `trio_diag` (não são defeito)
- "pisão no ar: tchibum fora do chão" (8): o teste espera o centro da folha 56 px acima dos pés (escala 2). O tchibum do pouso agora tem escala 3 (centro 84 px acima) e a base continua no chão, como mostram os prints `*_pisao_ar_pouso.png`.
- "Caatinga, cama/estandarte na beirada lado −1": o teste põe a personagem em y = −60 **dentro da laje** (a quina esquerda da Caatinga fica em y = −120). Na `revisao_probe3`, na ponta de verdade da laje, os dois ficam apoiados.
- Recuperação "falhas": quase todas as trilhas terminam **em pé numa plataforma alta** (y −265 ou −385), e o teste só aceita y perto de 0. No Cerrado, o lado esquerdo "300/350" falha para os 3, então vale conferir o vão (pendente).

## Pendente (fora do meu escopo ou decisão do João)
- **C4:** "Volta ao palco 2" na ficha do Capivas, mas ele volta melhor que a Canga. Baixar o `UP_RISE` quebra o `pesado_smoke` ("sobe > 250 px"), e a barrinha fica no `game_state.gd` (fora do escopo). É decisão de balanço.
- `move_fx.gd`, código geral: a regra `"impact"` dispara a cada quadro se o golpe prender o quadro de impacto. Hoje nenhum personagem faz isso (o Capivas saiu da tabela), mas a correção do r11 (disparar 1 vez por golpe) protege o futuro. A `fx_boia` usa z −1 e pode sumir atrás do fundo da Ruínas: trocar por "antes do lutador na árvore", como fiz nos outros.
- O avanço do especial lado da Canga (`self_velocity` 380) pode levar ela para fora da quina. A bandeira já é fincada atrás dela, mas a Canga pode cair. Vale um "freio na quina" no Fighter (fora do escopo).
- O recuo de 80 px do estandarte é um limite: se ela passar mais que isso da quina, a bandeira cai do palco (comportamento escolhido: cai e some).
- Cerrado: o caso de recuperação "lado esquerdo 300/350" falha para todos. Conferir se é o teste ou a geometria do vão.
- Testes `trio_diag`/`trio_shots`: atualizar o valor esperado do tchibum (base no chão, e não centro −56) e o posicionamento na laje da Caatinga.

## Pedidos de arte (não gerei nada)
1. `art/pixel/seu_capivas/fx_gotas.png`: 4 quadros 64×64, gotas de água caindo/escorrendo do corpo ao subir no pulo alto ("saindo da piscina"). Hoje uso um tchibum pequeno no chão.
2. `art/pixel/seu_capivas/fx_abraco.png`: 4 quadros 64×64, estrelinhas tontas girando + coraçãozinho, em cima do arremessado do agarrão ("abraço de tio").
3. `art/pixel/arara_canga/fx_penas.png`: 5 quadros 64×64, 3 ou 4 penas vermelhas/azuis/amarelas caindo balançando (voo de alegoria). Hoje uso o pulso de plumas.
4. `art/pixel/arara_canga/fx_brilho_batida.png`: 3 quadros 32×32 ou 64×64, brilho dourado de 4 pontas para a coroa e o golpe na batida. Hoje é desenhado por código.
5. `art/pixel/marianinha/fx_nota.png`: 4 quadros 64×64, plaquinhas de jurado (7, 8, 9, 10) subindo com confete pequeno, para o 10. Hoje uso o confete da Canga.
6. Opcional: `art/pixel/marianinha/fx_fita_corte.png`: 3 quadros 64×64, laço de fita cortando o projétil. Hoje uso o magnésio pequeno.

## Arquivos mexidos
`game/scripts/characters/dona_canga.gd`, `estandarte.gd`, `marianinha.gd`, `cama_elastica.gd`, `pesado.gd`; `game/data/movesets/marianinha.tres` (fita); `game/scripts/visual/move_fx.gd` (só a tabela do `seu_capivas`). Testes novos: `game/tests/revisao_trio_shots.*`, `revisao_probe.*`, `revisao_probe2.*`, `revisao_probe3.*`. Não mexi nas cenas `.tscn` dos personagens nem em `dona_canga.tres`/`pesado.tres`.
