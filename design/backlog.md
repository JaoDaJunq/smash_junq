# Backlog — primeiro corte

> **Versão 1.0 · aprovado em 14/10/2026, lista oficial de tarefas.** Tarefas pequenas, na ordem sugerida de execução. Cada uma só fecha com o critério de aceite cumprido e evidência (screenshot, vídeo curto ou teste) registrada. Base: [GDD](gdd.md).

Legenda de estado: `a fazer` · `fazendo` · `feito`.

## Marco 0 — Base técnica (Etapa 2)

| ID | Tarefa | Critério de aceite | Estado |
|---|---|---|---|
| T01 | Medir o PC de casa (CPU, RAM, placa de vídeo, Windows) e registrar no README | Especificações anotadas; Godot 4.7.2 abre e roda o projeto vazio | a fazer |
| T02 | Criar o projeto Godot 4.7.2 em `game/` com `.gitignore` do Godot | Projeto abre sem erros; arquivos gerados pelo editor não entram no Git | feito (14/10, PC da agência) |
| T03 | Instalar uma release publicada do godot-ai e conectar ao Claude Code | O Claude cria um nó numa cena, roda o jogo e devolve um screenshot | fazendo: plugin v4.3.0 instalado em `game/addons` e ativado (SHA-256 conferido); falta abrir o editor e clicar em Configure para o Claude |
| T04 | Configurar o mapa de entradas para 2 teclados e 2 gamepads | Cada ação do GDD responde nos dois esquemas de teclado e num gamepad | fazendo: teclados testados por simulação; falta testar gamepad real |

## Marco 1 — Movimento

| ID | Tarefa | Critério de aceite | Estado |
|---|---|---|---|
| T05 | Arena greybox: plataforma principal com bordas e duas plataformas atravessáveis | Dá para subir por baixo e descer das flutuantes; a principal é sólida | feito: teste `movement_smoke` + evidência |
| T06 | Lutador greybox com estados: parado, andar, correr, pular, pulo duplo, cair, queda rápida | Todos os estados acessíveis pelo controle; sem travar entre estados | feito: teste `movement_smoke` + evidência |
| T07 | Agarrar a borda e subir | Ao cair perto da borda, o lutador agarra; sobe com cima ou pulo | feito: teste `movement_smoke` + evidência |
| T08 | Câmera dinâmica que enquadra os dois lutadores | Os dois sempre visíveis dentro da arena; zoom limitado e suave | feito: teste `movement_smoke` + evidência |

## Marco 2 — Combate

| ID | Tarefa | Critério de aceite | Estado |
|---|---|---|---|
| T09 | Sistema de hitbox/hurtbox e dados de golpe em Resources | Um golpe de teste acerta, registra dano e é configurado só por dados | feito: teste `combat_smoke` + evidência |
| T10 | Dano %, fórmula de lançamento, atordoamento e pausa no impacto | Com mais dano o mesmo golpe lança mais longe; teste automatizado da fórmula passa | feito: teste `combat_smoke` + evidência |
| T11 | Golpes básicos (9) do personagem A | Os 9 golpes funcionam no chão e no ar conforme a direção | feito: teste `agil_smoke` (27 checagens) + evidência |
| T12 | Especiais (4) do personagem A | Os 4 especiais funcionam; o para cima recupera de fora da plataforma | feito: teste `agil_smoke` (27 checagens) + evidência |
| T13 | Golpes básicos e especiais do personagem B | Idem T11 e T12, com peso e golpes diferentes do A | a fazer |
| T14 | Escudo (com desgaste e quebra) e esquiva | Escudo bloqueia, desgasta e quebra; esquiva dá invencibilidade curta | feito: teste `defense_smoke` + evidência |
| T15 | Agarrão, golpe rápido segurando e 4 arremessos (A e B) | Agarrão vence escudo e perde para ataque; arremessos usam a fórmula de lançamento; quem é agarrado se solta com o tempo | feito: teste `defense_smoke` + evidência |

## Marco 3 — Partida

| ID | Tarefa | Critério de aceite | Estado |
|---|---|---|---|
| T16 | Zonas de KO e retorno com invencibilidade | Sair dos limites conta KO; o lutador reaparece no alto, invencível por 2 s | a fazer |
| T17 | Placar até 3 KOs e morte súbita | A partida termina em 3 KOs; KO simultâneo segue a regra provisória; teste automatizado passa | a fazer |
| T18 | Interface da luta: dano %, KOs, contagem inicial | Dano e KOs atualizam na hora e são legíveis no tamanho real | a fazer |
| T19 | Fluxo de telas: menu, modo, personagem, resultado, revanche, pausa | Dá para jogar várias partidas seguidas sem fechar o jogo | a fazer |

## Marco 4 — CPU

| ID | Tarefa | Critério de aceite | Estado |
|---|---|---|---|
| T20 | CPU básica com os estados do GDD | A CPU luta, marca KOs e volta para a arena na maioria das vezes; nunca fica parada | a fazer |

## Marco 5 — Fechamento do primeiro corte

| ID | Tarefa | Critério de aceite | Estado |
|---|---|---|---|
| T21 | Testes automatizados (GdUnit4) da fórmula de lançamento e do placar | Testes rodam pela linha de comando e passam | fazendo: GdUnit4 6.2.2 instalado, 7 testes da fórmula passam; faltam os do placar |
| T22 | Exportar build Windows e fazer o primeiro playtest | O `.exe` roda no PC de casa; partida completa jogada nos dois modos; notas do playtest registradas | a fazer |

Arte, animação e som definitivos não estão aqui: entram nas Etapas 3 a 6, depois que o combate com formas simples estiver divertido.
