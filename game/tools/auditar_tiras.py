"""Auditoria automática das tiras importadas de um personagem:
- CORTADO: desenho encostando na borda esquerda/direita/cima do quadro de 64 (saiu da célula);
- SOLTO: pedaço separado do corpo (> 6 px) — resto da célula vizinha;
- PULO: tamanho do desenho muda > 25% entre quadros vizinhos (pisca no jogo).
  python auditar_tiras.py <id>"""
import sys, json
from PIL import Image

cid = sys.argv[1]
d = f"C:/Projetos/smash_junq/game/assets/characters/{cid}/pixel"
meta = json.load(open(f"{d}/animacoes.json", encoding="utf-8"))
PROPS = {"pandeiro", "semente", "nota", "castanha"}


FW = 64  # largura do quadro (personagens com MARGEM no importador têm quadros mais largos)


def comps(px, x0):
    seen, out = set(), []
    for y in range(64):
        for x in range(FW):
            if (x, y) in seen or px[x0 + x, y][3] == 0:
                continue
            st, c = [(x, y)], []
            seen.add((x, y))
            while st:
                cx, cy = st.pop()
                c.append((cx, cy))
                for dx in (-1, 0, 1):
                    for dy in (-1, 0, 1):
                        nx, ny = cx + dx, cy + dy
                        if 0 <= nx < FW and 0 <= ny < 64 and (nx, ny) not in seen and px[x0 + nx, ny][3] > 0:
                            seen.add((nx, ny))
                            st.append((nx, ny))
            out.append(c)
    return out


total = 0
for anim in sorted(meta):
    if anim in PROPS:
        continue
    im = Image.open(f"{d}/{anim}.png").convert("RGBA")
    px = im.load()
    n = int(meta[anim]["quadros"]) if isinstance(meta.get(anim), dict) else im.width // 64
    FW = im.width // n  # noqa
    areas, probs = [], []
    for f in range(n):
        cs = comps(px, f * FW)
        area = sum(len(c) for c in cs)
        areas.append(area)
        if not cs:
            probs.append(f"{f+1}:VAZIO")
            continue
        big = max(cs, key=len)
        xs = [x for x, _ in big]
        ys = [y for _, y in big]
        edges = [s for s, ok in (("esq", min(xs) == 0), ("dir", max(xs) == FW - 1), ("topo", min(ys) == 0 and anim != "pendurado")) if ok]
        if edges:
            probs.append(f"{f+1}:CORTADO({'/'.join(edges)})")
        loose = [len(c) for c in cs if c is not big and len(c) > 6]
        if loose:
            probs.append(f"{f+1}:SOLTO{loose}")
    for f in range(1, n):
        a, b = areas[f - 1], areas[f]
        if a and b and max(a, b) / min(a, b) > 1.25:
            probs.append(f"{f}->{f+1}:PULO({min(a,b)*100//max(a,b)}%)")
    if probs:
        total += 1
        print(f"{anim:22s} {n:2d}q  " + "  ".join(probs))
print(f"--- {total} animações com problema de {len([a for a in meta if a not in PROPS])}")
