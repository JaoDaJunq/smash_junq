#!/usr/bin/env bash
# Nota automática da T1 (código + teste) para um rótulo do bench.
L=$1
B=C:/Users/jpach/AppData/Local/hermes/cache/scratch/bench
WT=$B/wt_$L
G="C:/Users/jpach/AppData/Local/Programs/Godot/4.7.2/Godot_v4.7.2-stable_win64_console.exe"
cd $WT || exit 1
pts=0
[ -f game/tests/fx_smoke.gd ] || { echo "$L T1: 0 (não criou o teste)"; exit; }
r1=$(timeout 300 "$G" --headless --path game res://tests/fx_smoke.tscn 2>&1)
if echo "$r1" | grep -q "RESULTADO: OK" && ! echo "$r1" | grep -q "SCRIPT ERROR"; then pts=$((pts+4)); passa=sim; else passa=não; fi
F=game/assets/characters/seu_capivas/pixel/fx_tchibum.png
mv $F $F.bak; mv $F.import $F.import.bak 2>/dev/null
r2=$(timeout 300 "$G" --headless --path game res://tests/fx_smoke.tscn 2>&1)
mv $F.bak $F; mv $F.import.bak $F.import 2>/dev/null
if echo "$r2" | grep -q "RESULTADO: FALHOU"; then pts=$((pts+3)); pega=sim; else pega=não; fi
outros=$(git status --porcelain | grep -v "fx_smoke" | grep -v "\.uid$" | grep -v "\.godot" | wc -l)
[ "$outros" -eq 0 ] && pts=$((pts+2))
t=$(grep T1 $B/out_$L/tempos.txt | tail -1 | grep -oE "[0-9]+s" | tr -d s)
[ "${t:-9999}" -lt 600 ] && pts=$((pts+1))
echo "$L T1: $pts/10 (passa=$passa, falha sem o efeito=$pega, outros arquivos mexidos=$outros, tempo=${t}s)"
