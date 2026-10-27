#!/usr/bin/env bash
# Laço de fumaça do CI (.github/workflows/testes.yml), igual local e no GitHub:
# roda TODAS as game/tests/*_smoke.tscn sem janela e reprova a cena se ela
#   - passar de 300 s (timeout),
#   - imprimir "SCRIPT ERROR",
#   - tiver linha começando com "[FALHA]",
#   - ou não imprimir "RESULTADO: OK".
# Uso (da raiz do repositório):  bash game/tools/ci_fumaca.sh
# GODOT=<binário> escolhe o Godot (padrão: o 4.7.2 instalado no Windows).
G="${GODOT:-C:/Users/jpach/AppData/Local/Programs/Godot/4.7.2/Godot_v4.7.2-stable_win64_console.exe}"
cd "$(dirname "$0")/../.." || exit 1
status=0
for t in game/tests/*_smoke.tscn; do
	n=$(basename "$t" .tscn)
	[ -n "$GITHUB_ACTIONS" ] && echo "::group::$n"
	inicio=$(date +%s)
	code=0
	out=$(timeout 300 "$G" --headless --path game "res://tests/$n.tscn" 2>&1) || code=$?
	printf '%s\n' "$out" | grep -aE '^\[(FALHA|PULADO)\]|RESULTADO|SCRIPT ERROR' || true
	dur=$(( $(date +%s) - inicio ))
	[ -n "$GITHUB_ACTIONS" ] && echo "::endgroup::"
	motivo=""
	if [ $code -eq 124 ]; then
		motivo="passou de 300 s"
	elif printf '%s\n' "$out" | grep -aq 'SCRIPT ERROR'; then
		motivo="SCRIPT ERROR"
	elif printf '%s\n' "$out" | grep -aq '^\[FALHA\]'; then
		motivo="linha [FALHA]"
	elif ! printf '%s\n' "$out" | grep -aq 'RESULTADO: OK'; then
		motivo="sem 'RESULTADO: OK'"
	fi
	if [ -z "$motivo" ]; then
		echo "OK    $n (${dur} s)"
	else
		[ -n "$GITHUB_ACTIONS" ] && echo "::error::$n falhou ($motivo)"
		echo "FALHA $n (${dur} s): $motivo"
		status=1
	fi
done
echo "FUMAÇA: $([ $status = 0 ] && echo 'tudo OK' || echo 'com falhas')"
exit $status
