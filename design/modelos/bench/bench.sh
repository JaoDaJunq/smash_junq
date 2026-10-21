#!/usr/bin/env bash
# Roda as 3 tarefas do teste de desempenho para UM modelo, num worktree isolado.
#   bench.sh <rotulo> <ferramenta:claude|codex> <modelo> [esforço]
set -u
LABEL=$1; TOOL=$2; MODEL=$3; EFFORT=${4:-medium}
REPO=C:/Projetos/smash_junq
B=C:/Users/jpach/AppData/Local/hermes/cache/scratch/bench
WT=$B/wt_$LABEL
OUT=$B/out_$LABEL
mkdir -p $OUT
cd $REPO && git worktree remove --force $WT 2>/dev/null; git worktree add -f --detach $WT HEAD >/dev/null 2>&1
# assets importados não estão todos no git? copia a pasta de assets/imports do projeto real
cp -r $REPO/game/.godot $WT/game/ 2>/dev/null

T1="Projeto Godot 4.7 em ./game (jogo de luta 2D). Tarefa: crie game/tests/fx_smoke.gd e game/tests/fx_smoke.tscn (um Node com o script), no mesmo estilo de game/tests/novos_smoke.gd (Game.suppress_scene_changes, carrega res://scenes/match.tscn, imprime '[OK]'/'[FALHA]' e 'RESULTADO: OK (0 falha(s))' ou 'RESULTADO: FALHOU (N falha(s))', e get_tree().quit(falhas)). O teste deve provar que os efeitos de golpe de game/scripts/visual/move_fx.gd aparecem: (1) com o Seu Capivas (personagem índice 1) dando o especial para baixo no chão, nasce na cena um PixelFx cuja textura é res://assets/characters/seu_capivas/pixel/fx_tchibum.png; (2) com a Mestra Sucuri (índice 5) usando o especial neutro com um adversário perto e à frente, nasce um PixelFx com a textura fx_hipnose.png. NÃO altere nenhum outro arquivo. Rode o teste com: \"C:/Users/jpach/AppData/Local/Programs/Godot/4.7.2/Godot_v4.7.2-stable_win64_console.exe\" --headless --path game res://tests/fx_smoke.tscn e deixe-o passando. Responda no fim só com o resultado do teste."
T2="Você revisa pixel art de um jogo de luta. Abra e OLHE as duas imagens: (A) art/pixel/sucuri/candidatos/v1/especial_lado.png e (B) art/pixel/arara_canga/parado.png. Cada imagem é uma folha 1536x1024 com grade 3x2 (cada célula de 512 é UM quadro do personagem, fundo magenta). Para cada folha diga APROVADA ou REPROVADA para entrar no jogo e liste os defeitos que um jogador exigente veria (personagem cortado pela borda da célula, pedaços soltos de outro quadro, troca de tamanho, sujeira). Responda em português simples, no máximo 8 linhas. Não altere arquivos."
T3="Rode exatamente estes dois comandos na raiz do projeto: python game/tools/checar_personagem.py marianinha  e  python game/tools/auditar_tiras.py marianinha . Depois resuma para o dono do jogo (que não é programador) em no máximo 6 linhas, em português simples: o que falta para a personagem e quais animações têm defeito. Não invente nada que não esteja na saída. Não altere arquivos."

run() {
  local n=$1 prompt=$2
  local t0=$(date +%s)
  if [ $TOOL = claude ]; then
    (cd $WT && timeout 900 ~/.local/bin/claude -p --model $MODEL --effort $EFFORT --permission-mode bypassPermissions --output-format json "$prompt" > $OUT/$n.json 2> $OUT/$n.err)
  else
    (cd $WT && timeout 900 codex exec -m $MODEL -c model_reasoning_effort="\"$EFFORT\"" -s danger-full-access --skip-git-repo-check "$prompt" > $OUT/$n.txt 2>&1)
  fi
  echo "$n $(( $(date +%s) - t0 ))s" >> $OUT/tempos.txt
}
: > $OUT/tempos.txt
run T1 "$T1"
(cd $WT && git status --porcelain > $OUT/T1_arquivos.txt)
run T2 "$T2"
run T3 "$T3"
echo FIM $LABEL
