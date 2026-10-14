# Smash Junq

Projeto de jogo de luta em plataformas 2D, criado com apoio de IA e desenvolvido em Godot.

## Estado do projeto

**Etapa 2 — engine e ponte com a IA.** As Etapas 0 (validação do jogo) e 1 (GDD e backlog) foram concluídas em 14/10/2026. Próxima tarefa: T01 do [backlog](design/backlog.md), medir o PC de casa e instalar o Godot 4.7.2.

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
3. Aperte **F5** para jogar. Jogador 1: W A S D, Espaço para pular. Jogador 2: setas, Numpad 0 para pular. Gamepads também funcionam.

O que já funciona (greybox, formas simples): andar, correr (toque duplo), pulo, pulo curto, pulo duplo, queda rápida, descer das plataformas flutuantes (para baixo), agarrar a borda e subir (para cima) e câmera que acompanha os dois lutadores. Ainda não há golpes.

**Teste automático do movimento**, a partir da raiz do repositório (abre uma janela por alguns segundos e salva screenshots em `evidence/etapa-2/`):

```bash
godot --path game res://tests/movement_smoke.tscn
```

Se mudar o mapeamento de controles em `game/tools/configure_input_map.gd`, regrave o `project.godot` com:

```bash
godot --headless --path game --script res://tools/configure_input_map.gd
```

## Base técnica prevista

Godot 4.7.2, Claude-Code-Game-Studios para organizar briefs e tarefas, godot-ai como ponte com o editor, e geração 3D/animação pesada em serviços de nuvem, conforme a necessidade. O PC de casa ainda não foi medido, então decisões de desempenho ficam pendentes de teste.
