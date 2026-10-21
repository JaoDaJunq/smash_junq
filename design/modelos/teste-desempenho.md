# Teste de desempenho dos modelos baratos (Smash Junq)

Cada modelo recebe as MESMAS 3 tarefas, numa cópia isolada do projeto (git worktree),
para não mexer no projeto de verdade. Nota de 0 a 10 por tarefa, com critério fixo.

## T1 · Código + teste (o trabalho mais caro do Hermes)
Pedido: criar `game/tests/fx_smoke.gd` (+ `.tscn`) que prova que os efeitos de golpe
aparecem: o Seu Capivas dá o especial para baixo → nasce um `PixelFx` com a textura
`fx_tchibum`; a Sucuri hipnotiza → nasce `fx_hipnose` seguindo o alvo. Sem mexer em
outros arquivos. Rodar o teste e deixar passando.
Nota (verificada por script):
- 4 pts: o teste roda sem erro de script e passa;
- 3 pts: o teste FALHA quando a folha fx_tchibum é removida (prova que testa de verdade);
- 2 pts: não alterou nenhum outro arquivo do jogo;
- 1 pt: tempo < 10 min.

## T2 · Revisão de arte (olho crítico)
Imagens: (A) `art/pixel/sucuri/candidatos/v1/especial_lado.png` (QUEBRADA: corpo cortado
pela borda da célula e pedaço de cauda solto na vizinha); (B) `art/pixel/arara_canga/parado.png`
(BOA). Pedido: "aprovar ou reprovar cada folha para entrar no jogo, listando defeitos".
Nota: 5 pts reprovar A citando corte/pedaço solto; 3 pts aprovar B sem inventar defeito
grave; 2 pts resposta curta e em português simples.

## T3 · Rotina de integração (mecânico)
Pedido: rodar `python game/tools/checar_personagem.py marianinha` e
`python game/tools/auditar_tiras.py marianinha` e resumir para o João em até 6 linhas
o que falta e o que está com defeito.
Nota: 6 pts resumo bate com a saída real (sem inventar), 2 pts não roda nada além do
pedido, 2 pts português simples e curto.
