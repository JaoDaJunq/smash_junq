# Smash Junq

Projeto de jogo de luta em plataformas 2D, criado com apoio de IA e desenvolvido em Godot.

## Estado do projeto

**Primeiro corte jogável, em greybox (formas simples).** As Etapas 0 e 1 foram concluídas em 14/10/2026, e quase todo o [backlog](design/backlog.md) do primeiro corte está feito. Faltam: T01 (medir o PC de casa), T03 (conectar o godot-ai ao Claude no editor), T04 (testar gamepad real), T21 (testes do placar no GdUnit4) e T22 (exportar o `.exe` e fazer o primeiro playtest).

O jogo é um platform fighter 2D lateral, inspirado no formato de combate de Super Smash Bros. Os golpes acumulam dano; com mais dano, o adversário tende a ser lançado mais longe. Cada nocaute fora da arena vale um ponto, e vence quem chegar primeiro a 3 KOs.

## Decisões já tomadas

- Começar em 2D, mantendo aberta a possibilidade de ampliar ou mudar o formato depois do protótipo.
- PC Windows como primeira plataforma.
- Modos: 2 jogadores locais no mesmo computador e jogador contra a CPU.
- Gamepad como controle-alvo, com teclado suportado durante o protótipo.
- Partidas de 3 KOs, sem limite de tempo.
- Personagens, nomes, visuais, sons e cenários originais.

## Primeiro corte (aprovado)

Uma arena, dois personagens temporários, golpes básicos e especiais, escudo, esquiva, agarrão e arremessos, dano, lançamento, recuperação, nocaute fora da arena e reinício rápido, jogável em 1 contra 1 local ou contra a CPU.

Fora do primeiro corte: multiplayer online, campanha ou progressão, elenco grande, várias arenas e itens.

## Organização

- [Brief da Etapa 0 — aprovado](design/brief-etapa-0.md)
- [GDD — aprovado](design/gdd.md)
- [Backlog do primeiro corte — lista oficial de tarefas](design/backlog.md)
- [Arsenal, rota de produção, pesquisa e decisões](docs/arsenal-jogo-ia.md)
- As decisões confirmadas e as propostas em validação devem ficar identificadas separadamente.
- A rota de produção recomendada está no arsenal; o avanço de etapa depende dos critérios de saída definidos ali.

## Como rodar

1. Baixe o **Godot 4.7.2** (versão padrão, não a .NET) em [godotengine.org/download/archive](https://godotengine.org/download/archive/).
2. No Godot, clique em **Importar** e escolha `game/project.godot`.
3. Aperte **F5**. O jogo abre no menu: Jogar → 2 jogadores ou Contra a CPU → escolha Ágil ou Pesado → luta até 3 KOs.

**Controles**

| Ação | Jogador 1 (teclado) | Jogador 2 (teclado) | Gamepad |
|---|---|---|---|
| Mover | W A S D | Setas | Analógico / direcional |
| Pular | Espaço | Numpad 0 | A |
| Ataque | J | Numpad 1 | X |
| Especial | K | Numpad 2 | B |
| Escudo (no ar: esquiva) | L | Numpad 3 | RB ou LB |
| Rolagem | L + esquerda/direita | Numpad 3 + seta | RB + direção |
| Agarrão | L + J | Numpad 3 + Numpad 1 | RT |
| Pausa | Esc | Numpad Enter | Start |

Correr: toque duplo na direção (ou empurrar o analógico rápido). Descer da plataforma: para baixo. Na borda: para cima sobe, pulo salta. Segurando alguém: Ataque bate, direção arremessa.

**O que já funciona:** movimento completo, golpes básicos e especiais dos dois personagens temporários (Ágil e Pesado), escudo, esquivas, agarrão e arremessos, dano %, lançamento, zonas de KO, placar até 3 KOs com morte súbita, menus, pausa, resultado e revanche, e a CPU básica.

**Testes automáticos**, a partir da raiz do repositório. Cada um abre uma janela por alguns segundos, imprime `[OK]`/`[FALHA]` e salva screenshots em `evidence/etapa-2/`:

```bash
godot --path game res://tests/movement_smoke.tscn
```

Os outros seguem o mesmo formato: `combat_smoke`, `defense_smoke`, `agil_smoke`, `pesado_smoke`, `match_smoke` e `cpu_smoke`. Os testes unitários usam o GdUnit4 (no Windows, a partir de `game/`, com a variável `GODOT_BIN` apontando para o executável do Godot):

```bash
addons\gdUnit4\runtest.cmd --headless --ignoreHeadlessMode -a res://tests/unit
```

Para calibrar a força dos golpes, `res://tests/knockback_probe.tscn` imprime até onde cada golpe lança em cada faixa de dano.

Se mudar o mapeamento de controles em `game/tools/configure_input_map.gd`, regrave o `project.godot` com:

```bash
godot --headless --path game --script res://tools/configure_input_map.gd
```

## Base técnica prevista

Godot 4.7.2, Claude-Code-Game-Studios para organizar briefs e tarefas, godot-ai como ponte com o editor, e geração 3D/animação pesada em serviços de nuvem, conforme a necessidade. O PC de casa ainda não foi medido, então decisões de desempenho ficam pendentes de teste.
