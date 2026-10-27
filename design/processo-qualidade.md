# Processo de qualidade (proposta para o AGENTS.md, aguardando aprovação do João)

Origem: a análise externa de 26/10 mostrou que o projeto testava "se roda" e não "se está certo", e o João achou defeitos que passaram pela revisão (Berrante menor no jab_c/tonto, sprites cortados na seleção). Estas regras valem já para o Hermes e os subagentes; quando o João aprovar, entram no AGENTS.md (que também precisa corrigir o elenco: hoje são 13 jogáveis, não só Juba e Seu Capivas).

## Pronto quer dizer

Nada é "pronto" porque compilou. Cada tipo de mudança tem a sua prova, rodada ANTES de mostrar ao João:

- **Código:** `bash game/tools/rodar_testes.sh` com `BATERIA: 0 teste(s) com problema` (todas as cenas `*_smoke`, zero `SCRIPT ERROR`). O CI faz o mesmo (`game/tools/ci_fumaca.sh`) e a alpha só sai com os testes verdes. Conserto de bug vem com um teste que falha sem o conserto.
- **Golpe, personagem ou arena:** simulação CPU x CPU (`res://tests/sim_elenco.tscn`, semente fixa) + `python game/tools/checa_matriz.py`: nenhuma partida sem vencedor; vitória de cada lutador entre 35% e 65% é a meta.
- **Arte de personagem:**
  1. `python game/tools/auditar_escala.py <id>`: nenhuma folha com o personagem menor ou maior que o parado.
  2. `python game/tools/auditar_tiras.py <id>`: sem pedaço solto, salto de tamanho ou corpo cortado.
  3. Prints COM janela de todos os golpes (`res://tests/golpes_shots.tscn`) e das telas com o personagem (`res://tests/ui_revisao_shots.tscn -- so=selecao,hud,resultado`), olhados em tamanho real.
- **Tela (UI):** prints com janela de cada tela mexida, olhados em tamanho real.
- **Visual em movimento:** quando der, clipe curto do Movie Maker (`--write-movie`, com janela, semente fixa) no relatório.

## Quem julga

- Quem fez não aprova sozinho. Arte e telas passam por um revisor em contexto novo (subagente que recebe só as imagens, as referências aprovadas e as regras, sem o pedido) antes de chegar ao João. Defeito apontado pelo revisor bloqueia a entrega.
- Defeito que o João achar vira teste ou auditoria automática, para não voltar.

## Número em documento

Todo número em relatório sai de um comando, colado junto. Sem comando, escrever "não medido".

## Trabalho em paralelo

Subagentes trabalham em worktrees separados (`git worktree add`), cada um com a lista de arquivos que pode mexer combinada antes; o Hermes junta, roda a bateria de novo e só então sobe para main.
