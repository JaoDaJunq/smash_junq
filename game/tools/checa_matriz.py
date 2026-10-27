#!/usr/bin/env python
"""Lê o CSV do game/tests/sim_elenco.tscn e resume o equilíbrio do elenco.

Uso:
    python game/tools/checa_matriz.py sim.csv [--estrito] [--min 35] [--max 65]

Imprime, por personagem (sem contar espelhos): partidas, vitórias e % de vitória,
marcando quem está fora da faixa (padrão 35-65%). Também conta partidas sem
vencedor, a duração mediana e a fração de partidas entre 180 e 300 s.
Com --estrito sai com código 1 se houver alguém fora da faixa ou partida sem vencedor.
Só usa a biblioteca padrão do Python.
"""
import argparse
import csv
import statistics
import sys


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("csv", help="arquivo gerado pelo sim_elenco")
    ap.add_argument("--estrito", action="store_true", help="sai 1 se houver problema")
    ap.add_argument("--min", type=float, default=35.0, help="%% mínima de vitória aceitável")
    ap.add_argument("--max", type=float, default=65.0, help="%% máxima de vitória aceitável")
    a = ap.parse_args()

    with open(a.csv, newline="", encoding="utf-8") as f:
        rows = list(csv.DictReader(f))
    if not rows:
        print("CSV vazio")
        return 1 if a.estrito else 0

    jogos: dict[str, int] = {}
    vitorias: dict[str, int] = {}
    sem_vencedor = 0
    duracoes: list[float] = []
    for r in rows:
        dur = float(r["dur_jogo_s"])
        if r["sem_vencedor"] == "sim":
            sem_vencedor += 1
        else:
            duracoes.append(dur)
        if r["p1_idx"] == r["p2_idx"]:
            continue  # espelho não diz nada sobre equilíbrio
        for lado in ("p1", "p2"):
            nome = r[f"{lado}_nome"]
            jogos[nome] = jogos.get(nome, 0) + 1
            if r["vencedor"] == lado:
                vitorias[nome] = vitorias.get(nome, 0) + 1

    problemas = 0
    print(f"{'personagem':<22}{'jogos':>6}{'vitórias':>10}{'%':>8}")
    for nome in sorted(jogos, key=lambda n: -vitorias.get(n, 0) / jogos[n]):
        pct = 100.0 * vitorias.get(nome, 0) / jogos[nome]
        fora = pct < a.min or pct > a.max
        problemas += fora
        marca = "  <-- fora de %.0f-%.0f%%" % (a.min, a.max) if fora else ""
        print(f"{nome:<22}{jogos[nome]:>6}{vitorias.get(nome, 0):>10}{pct:>7.1f}%{marca}")

    total = len(rows)
    print()
    print(f"partidas: {total}  (espelhos ignorados na tabela)")
    print(f"sem vencedor: {sem_vencedor} ({100.0 * sem_vencedor / total:.1f}%)")
    if duracoes:
        na_faixa = sum(1 for d in duracoes if 180.0 <= d <= 300.0)
        print(f"duração mediana (com vencedor): {statistics.median(duracoes):.1f} s")
        print(f"entre 180 e 300 s: {na_faixa}/{len(duracoes)} ({100.0 * na_faixa / len(duracoes):.1f}%)")
    else:
        print("duração mediana: sem partidas com vencedor")
    print(f"personagens fora da faixa: {problemas}")

    if a.estrito and (problemas > 0 or sem_vencedor > 0):
        return 1
    return 0


if __name__ == "__main__":
    sys.exit(main())
