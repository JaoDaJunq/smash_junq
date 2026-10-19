"""Confere o que um personagem já tem e o que falta (roteiro em design/novo-personagem.md).

    python game/tools/checar_personagem.py <id>

Para cada etapa, lista os arquivos esperados com OK ou FALTA e, nas folhas, o
número de quadros encontrados (células não magenta na grade 3x2).
"""
import os
import sys

from PIL import Image

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))

LOTE1 = {"parado": 4, "andar": 6, "correr": 6, "pulo": 6, "transicoes_a": 6, "transicoes_b": 6,
         "jab": 3, "jab_b": 3, "jab_c": (3, 5), "golpe_frente": 5, "defesa_esquiva": 6, "dor": 4}
LOTE2 = {"golpe_cima": 5, "golpe_baixo": 5, "aereo_neutro": 5, "aereo_frente": 5, "aereo_tras": 5,
         "aereo_cima": 5, "aereo_baixo": 5, "especial_neutro": 6, "especial_lado": 6, "especial_cima": 6,
         "especial_baixo": 6, "agarrar": 6, "tonto": 4, "pendurado": 2, "descanso": 4, "vitoria": (3, 4)}
LOTE3 = {"parado_meio": 4, "andar_meio": 6, "correr_meio": 6, "pulo_meio": 5,
         "golpe_frente_meio": 4, "golpe_cima_meio": 4, "golpe_baixo_meio": 4,
         "aereo_neutro_meio": 4, "aereo_frente_meio": 4, "aereo_tras_meio": 4, "aereo_cima_meio": 4,
         "aereo_baixo_meio": 4, "especial_neutro_meio": 5, "especial_lado_meio": 5,
         "especial_cima_meio": 5, "especial_baixo_meio": 5, "dor_meio": 3, "tonto_meio": 4}
# Juba usa uma folha só para tonto e cambalhota do pulo duplo
EQUIVALENTE = {"tonto": ["tonto_pulo_duplo"], "tonto_meio": ["tonto_pulo_duplo"]}


def frames(path):
    im = Image.open(path).convert("RGB")
    if im.size != (1536, 1024):
        return None
    n = 0
    for r in range(2):
        for c in range(3):
            cell = im.crop((c * 512 + 16, r * 512 + 16, c * 512 + 496, r * 512 + 496)).resize((48, 48))
            if any(not (p[0] > 200 and p[2] > 200 and p[1] < 80) for p in cell.getdata()):
                n += 1
    return n


def check_sheets(cid, title, sheets):
    print(f"\n{title}")
    missing = 0
    for name, want in sheets.items():
        path = os.path.join(ROOT, "art", "pixel", cid, name + ".png")
        alt = [a for a in EQUIVALENTE.get(name, []) if os.path.exists(os.path.join(ROOT, "art", "pixel", cid, a + ".png"))]
        if not os.path.exists(path):
            if alt:
                print(f"  ok     {name:22} (em {alt[0]}.png)")
                continue
            print(f"  FALTA  {name}.png")
            missing += 1
            continue
        n = frames(path)
        lo, hi = want if isinstance(want, tuple) else (want, want)
        if n is None:
            print(f"  ATENÇÃO {name}.png fora do tamanho 1536x1024")
        elif lo <= n <= hi:
            print(f"  ok     {name:22} {n} quadros")
        else:
            print(f"  ATENÇÃO {name:21} {n} quadros (esperado {lo}" + (f"-{hi})" if hi != lo else ")"))
    return missing


def check_files(title, files):
    print(f"\n{title}")
    missing = 0
    for label, path, needle in files:
        full = os.path.join(ROOT, path)
        ok = os.path.exists(full)
        if ok and needle:
            ok = needle in open(full, encoding="utf-8").read()
        print(f"  {'ok   ' if ok else 'FALTA'}  {label}")
        missing += 0 if ok else 1
    return missing


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        return 1
    cid = sys.argv[1]
    print(f"Personagem: {cid}")
    total = check_files("1 · Ficha", [
        (f"design/personagens/{cid}.md", f"design/personagens/{cid}.md", None),
        (f"art/prompts/pixel/{cid}.md (paleta e regras)", f"art/prompts/pixel/{cid}.md", None),
        ("concept escolhido (art/concepts/<id>/escolhido.png)", f"art/concepts/{cid}/escolhido.png", None),
    ])
    total += check_files("2 · Base", [(f"art/pixel/{cid}/base.png", f"art/pixel/{cid}/base.png", None)])
    total += check_sheets(cid, "3 · Lote 1 (jogável)", LOTE1)
    total += check_sheets(cid, "4 · Lote 2 (golpes completos)", LOTE2)
    total += check_sheets(cid, "5 · Lote 3 (fluidez)", LOTE3)
    total += check_files("6 · Interface", [
        (f"art/ui/retrato_{cid}.png", f"art/ui/retrato_{cid}.png", None),
        (f"art/ui/apresentacao_{cid}.png", f"art/ui/apresentacao_{cid}.png", None),
        ("retrato importado", f"game/assets/characters/{cid}/retrato_pixel.png", None),
    ])
    total += check_files("7 · Código", [
        ("sprites importados", f"game/assets/characters/{cid}/pixel/animacoes.json", None),
        ("entrada em CHARACTERS", "game/scripts/match/game_state.gd", f'"id": "{cid}"'),
        ("no manifest", "assets/manifest.csv", cid),
    ])
    print(f"\n{'Tudo pronto!' if total == 0 else f'{total} item(ns) faltando.'}")
    return 0


if __name__ == "__main__":
    sys.exit(main())
