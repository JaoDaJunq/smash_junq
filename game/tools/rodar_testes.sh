#!/usr/bin/env bash
# Bateria de testes do Smash Junq: roda cada game/tests/*_smoke.tscn sem janela e
# resume "nome | erros de script: N | RESULTADO: ...". Uso (da raiz do repositório):
#   bash game/tools/rodar_testes.sh            # todos
#   bash game/tools/rodar_testes.sh novos agil # só esses
G="${GODOT:-C:/Users/jpach/AppData/Local/Programs/Godot/4.7.2/Godot_v4.7.2-stable_win64_console.exe}"
cd "$(dirname "$0")/../.." || exit 1
timeout 300 "$G" --headless --path game --import >/dev/null 2>&1
falhas=0
for t in game/tests/*_smoke.tscn; do
	n=$(basename "$t" .tscn)
	if [ $# -gt 0 ]; then
		ok=0; for a in "$@"; do [ "$n" = "${a}_smoke" ] || [ "$n" = "$a" ] && ok=1; done
		[ $ok = 1 ] || continue
	fi
	out=$(timeout 900 "$G" --headless --path game "res://tests/$n.tscn" 2>&1)
	erros=$(printf '%s\n' "$out" | grep -c "SCRIPT ERROR")
	res=$(printf '%s\n' "$out" | grep -a "RESULTADO" | tail -1)
	[ -z "$res" ] && res="RESULTADO: SEM RESULTADO (travou ou não terminou)"
	echo "$n | erros de script: $erros | $res"
	printf '%s\n' "$out" | grep -a "^\[FALHA\]" | head -10
	case "$res" in *"OK (0"*) [ "$erros" = 0 ] || falhas=$((falhas+1));; *) falhas=$((falhas+1));; esac
done
echo "BATERIA: $falhas teste(s) com problema"
