# Playtest 01 · pedidos de arte para o Codex

Índice dos pedidos que saíram do playtest 01 (15/10/2026). O Codex gera **na ordem abaixo**, um pedido por vez, seguindo o arquivo de cada um (prompt pronto, anexos, nome e pasta de saída). Depois o Claude Code avalia e integra.

**Regras que valem para todos** (detalhes em `design/identidade.md`, "Regras de produção do pixel art"):
- Só o personagem e o que ele segura; nada de chão, plataforma, cenário, rastro, poeira, linha de velocidade, brilho ou aura.
- Anexar sempre a folha aprovada **e** o `parado.png` do personagem.
- Salvar só em `art/pixel/<personagem>/candidatos/` com o nome indicado (`_v2` ou `_v1`). **Nunca sobrescrever** `art/pixel/<personagem>/*.png` nem nada em `game/`: são os arquivos em uso no jogo.
- Formato: imagem 1536x1024, grade 3x2, células de 512x512, quadros de 64x64 ampliados 8x, fundo magenta #FF00FF.
- Folhas `_meio_v2` (intermediários) são geradas logo depois da folha principal do mesmo pedido, anexando a principal nova.

## Pedidos, em ordem

| # | Pedido | Anexar | Saída (`art/pixel/...`) |
|---|---|---|---|
| 1 | [Juba · borda sem plataforma](juba/p01_borda.md) | `art/conceitos/juba/folha_v1.jpg`, `art/pixel/juba/parado.png`, `art/pixel/juba/borda.png` | `juba/candidatos/borda_v2.png` (6), `juba/candidatos/borda_meio_v2.png` (5) |
| 2 | [Juba · defesa e rolamento na escala certa](juba/p01_defesa_esquiva.md) | `art/conceitos/juba/folha_v1.jpg`, `art/pixel/juba/parado.png`, `art/pixel/juba/defesa_esquiva.png` | `juba/candidatos/defesa_esquiva_v2.png` (6) |
| 3 | [Juba · descanso (novo)](juba/p01_descanso.md) | `art/conceitos/juba/folha_v1.jpg`, `art/pixel/juba/parado.png` | `juba/candidatos/descanso_v1.png` (4) |
| 4 | [Seu Capivas · a "sentada" sem poeira e sem sobras](seu_capivas/p01_especial_baixo.md) | `art/conceitos/seu_capivas/folha_v1.png`, `art/pixel/seu_capivas/parado.png`, `art/pixel/seu_capivas/especial_baixo.png` | `seu_capivas/candidatos/especial_baixo_v2.png` (6), `seu_capivas/candidatos/especial_baixo_meio_v2.png` (5) |
| 5 | [Seu Capivas · folhas sem efeitos desenhados](seu_capivas/p01_sem_efeitos.md) (10 folhas) | folha aprovada, `parado.png` e, em cada prompt, a folha atual (`art/pixel/seu_capivas/<animacao>.png` e `<animacao>_meio.png`) | `seu_capivas/candidatos/`: `especial_neutro_v2` (6) + `_meio_v2` (5), `aereo_neutro_v2` (5) + `_meio_v2` (4), `defesa_esquiva_v2` (6), `golpe_frente_v2` (5), `golpe_baixo_v2` (5), `golpe_cima_v2` (5), `especial_cima_v2` (6) + `_meio_v2` (5), `dor_v2` (4) + `_meio_v2` (3), `vitoria_v2` (6) + `_meio_v2` (6), `transicoes_b_v2` (6) |
| 6 | [Seu Capivas · descanso (novo)](seu_capivas/p01_descanso.md) | `art/conceitos/seu_capivas/folha_v1.png`, `art/pixel/seu_capivas/parado.png` | `seu_capivas/candidatos/descanso_v1.png` (4) |
| 7 | [Seu Capivas · borda sem plataforma](seu_capivas/p01_borda.md) | `art/conceitos/seu_capivas/folha_v1.png`, `art/pixel/seu_capivas/parado.png`, `art/pixel/seu_capivas/borda.png` | `seu_capivas/candidatos/borda_v2.png` (6), `seu_capivas/candidatos/borda_meio_v2.png` (5) |
| 8 | [Juba · folhas sem efeitos desenhados](juba/p01_sem_efeitos.md) (7 folhas) | folha aprovada, `parado.png` e, em cada prompt, a folha atual (`art/pixel/juba/<animacao>.png` e `<animacao>_meio.png`) | `juba/candidatos/`: `golpe_frente_v2` (5) + `_meio_v2` (4), `golpe_cima_v2` (5), `golpe_baixo_v2` (5), `aereo_neutro_v2` (5), `especial_neutro_v2` (6) + `_meio_v2` (5), `tonto_pulo_duplo_v2` (6), `transicoes_b_v2` (6) |
| 9 | [Juba · especial para cima: Sumiço do Mico](juba/p01_especial_cima_sumico.md) | `art/conceitos/juba/folha_v1.jpg`, `art/pixel/juba/parado.png`, `art/pixel/juba/especial_lado.png` | `juba/candidatos/especial_cima_v2.png` (6), `juba/candidatos/especial_cima_meio_v2.png` (5) |
| 10 | [Efeito · explosão de folhas do Sumiço do Mico](juba/p01_fx_folhas.md) | `art/conceitos/juba/folha_v1.jpg`, `art/pixel/juba/parado.png` | `juba/candidatos/fx_folhas_v1.png` (6) |
| 11 | [Juba · projétil: castanha](juba/p01_castanha.md) | `art/conceitos/juba/folha_v1.jpg`, `art/pixel/juba/parado.png`, `art/pixel/juba/especial_neutro.png` | `juba/candidatos/castanha_v1.png` (4) |

Os números entre parênteses são a quantidade de quadros de cada imagem.

## De onde vieram (auditoria de 15/10/2026)

Checagem automática de ilhas (`game/tools/checar_ilhas.gd`) nos 448 quadros das tiras do jogo (dois personagens) e revisão visual de todos eles. Numeração abaixo = quadro na **tira do jogo** (começa em 0; nas folhas intercaladas, par = quadro da folha principal, ímpar = intermediário).

| Personagem | Animação | Quadros da tira | Problema | Pedido |
|---|---|---|---|---|
| Juba | borda | 0 a 10 | plataforma desenhada; 6 com sobra acima da cabeça | 1 |
| Juba | defesa_esquiva | 0, 1, 5 | cabeça e juba maiores que no parado, rosto de 3/4, postura mais larga; 1 com linhas de tremor | 2 |
| Juba | especial_cima | 1 a 9 | cipó preso fora do quadro; 6 com rastro em espiral | 9 |
| Juba | especial_neutro | 6, 7 | castanha voando desenhada no quadro | 8 e 11 |
| Juba | golpe_frente | 4, 5 | rastro curvo | 8 |
| Juba | golpe_cima | 4, 6 | rastro curvo | 8 |
| Juba | golpe_baixo | 4 | rastro embaixo da perna | 8 |
| Juba | aereo_neutro | 4 | rastro circular | 8 |
| Juba | tonto_pulo_duplo | 0, 1 | estrelinhas | 8 |
| Juba | frear | 0, 1 | poeira | 8 (`transicoes_b`) |
| Seu Capivas | especial_baixo | 0, 2, 4 a 10 | poeira e onda de choque (4 a 8), tracinhos (0), sobras do quadro vizinho (2, 9, 10) | 4 |
| Seu Capivas | especial_neutro | 2, 3, 4, 6, 7, 8, 9, 10 | tremor, linhas de velocidade, estouro, pixels soltos | 5 |
| Seu Capivas | aereo_neutro | 4 a 7 | rastro circular | 5 |
| Seu Capivas | defesa_esquiva | 1, 3, 4 | tremor e redemoinho de rastro | 5 |
| Seu Capivas | golpe_frente | 4, 6 | arcos de rastro e tracinhos | 5 |
| Seu Capivas | golpe_baixo | 4 | poeira | 5 |
| Seu Capivas | golpe_cima | 4 | brilho na laranjinha | 5 |
| Seu Capivas | especial_cima | 2, 7, 10 | poeira nos pés e respingos | 5 |
| Seu Capivas | dor | 0 a 3 | tracinhos de impacto | 5 |
| Seu Capivas | vitoria | 8, 9 | nuvem do suspiro | 5 |
| Seu Capivas | frear e pouso | frear 0, 1; pouso 0, 1 | poeira | 5 (`transicoes_b`) |
| Seu Capivas | borda | 0 a 10 | plataforma desenhada; 1, 2 e 7 com tracinhos | 7 |

**Sobras pequenas sem pedido** (1 a 4 pixels soltos, folha boa no resto): Juba `andar` 2, Seu Capivas `agarrar` 4 e `tonto` 7. Proposta: limpar no importador, apagando ilhas minúsculas soltas, em vez de refazer a folha. Fica para o João decidir.

**Encostam na lateral do quadro** (pé, cauda ou mão tocando a borda da célula; sem pedido por enquanto): Juba `aereo_frente` 7, `andar` 5, `arrancar` 1, `dor` 5, `especial_baixo` 1, `golpe_baixo` 3, `virar` 2, `especial_neutro` 7.

**Ilhas que não são defeito:** a laranjinha voando no `dor` do Seu Capivas é parte da piada (o sprite dela fica; os tracinhos saem). O coco da vitória fica.

## Depois que o Codex gerar

1. Claude Code avalia cada candidato contra o `parado.png` e a folha aprovada, e roda a checagem de ilhas nos dois personagens.
2. Aprovado: copia para `art/pixel/<personagem>/<animacao>.png` (e `_meio.png`), reimporta (`game/tools/importar_pixel.gd`) e faz os ajustes de código anotados em cada pedido (castanha no projétil, folhas e impacto do Sumiço do Mico, descanso na plataforma de volta).
3. Prints dentro do jogo, no zoom real, de todos os golpes e estados, para o João aprovar.
