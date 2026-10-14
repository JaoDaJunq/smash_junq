# Smash Junq

Projeto de jogo de luta em plataformas 2D, criado com apoio de IA e desenvolvido em Godot.

## Estado do projeto

**Etapa 1 — GDD e backlog.** A Etapa 0 (escolha e validação do jogo) foi concluída em 14/10/2026.

O jogo é um platform fighter 2D lateral, inspirado no formato de combate de Super Smash Bros. Os golpes acumulam dano; com mais dano, o adversário tende a ser lançado mais longe. Cada nocaute fora da arena vale um ponto, e vence quem chegar primeiro a 3 KOs.

## Decisões já tomadas

- Começar em 2D, mantendo aberta a possibilidade de ampliar ou mudar o formato depois do protótipo.
- PC Windows como primeira plataforma.
- Modos: 2 jogadores locais no mesmo computador e jogador contra a CPU.
- Gamepad como controle-alvo, com teclado suportado durante o protótipo.
- Partidas de 3 KOs, sem limite de tempo.
- Personagens, nomes, visuais, sons e cenários originais.

## Primeiro corte (aprovado)

Uma arena, dois personagens temporários, golpes básicos e especiais, dano, lançamento, recuperação, nocaute fora da arena e reinício rápido, jogável em 1 contra 1 local ou contra a CPU.

Fora do primeiro corte: multiplayer online, campanha ou progressão, elenco grande, várias arenas e itens.

## Organização

- [Brief da Etapa 0 — aprovado](design/brief-etapa-0.md)
- [GDD — rascunho para aprovação](design/gdd.md)
- [Backlog do primeiro corte — rascunho](design/backlog.md)
- [Arsenal, rota de produção, pesquisa e decisões](docs/arsenal-jogo-ia.md)
- As decisões confirmadas e as propostas em validação devem ficar identificadas separadamente.
- A rota de produção recomendada está no arsenal; o avanço de etapa depende dos critérios de saída definidos ali.

## Base técnica prevista

Godot 4.7.2, Claude-Code-Game-Studios para organizar briefs e tarefas, godot-ai como ponte com o editor, e geração 3D/animação pesada em serviços de nuvem, conforme a necessidade. O PC de casa ainda não foi medido, então decisões de desempenho ficam pendentes de teste.
