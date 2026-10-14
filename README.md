# Smash Junq

Projeto de jogo de luta em plataformas 2D, criado com apoio de IA e desenvolvido em Godot.

## Estado do projeto

**Etapa 0 — escolha e validação do jogo.**

A proposta aprovada é um platform fighter 2D lateral, inspirado no formato de combate de Super Smash Bros. Os golpes acumulam dano; com mais dano, o adversário tende a ser lançado mais longe. A vitória acontece ao arremessá-lo para fora dos limites da arena.

## Decisões já tomadas

- Começar em 2D.
- Manter aberta a possibilidade de ampliar ou mudar o formato depois do protótipo.
- Criar personagens, nomes, visuais, sons e cenários originais.

## Próximo corte proposto

Uma arena, dois personagens, combate local 1 contra 1, golpes básicos e especiais, recuperação após lançamento, nocaute fora da arena e reinício rápido. **Esse escopo ainda é uma proposta; plataforma e modos não foram fechados.**

## Organização

- [Arsenal, rota de produção, pesquisa e decisões](docs/arsenal-jogo-ia.md)
- As decisões confirmadas e as propostas em validação devem ficar identificadas separadamente.
- A rota de produção recomendada está no arsenal; o avanço de etapa depende dos critérios de saída definidos ali.

## Base técnica prevista

Godot 4.7.2, Claude-Code-Game-Studios para organizar briefs e tarefas, godot-ai como ponte com o editor, e geração 3D/animação pesada em serviços de nuvem, conforme a necessidade. O PC de casa ainda não foi medido, então decisões de desempenho ficam pendentes de teste.
