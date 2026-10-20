"""Apaga pedaços soltos que vieram da célula vizinha numa tira importada:
em cada quadro de 64x64, remove ilhas de pixels que encostam na borda esquerda/direita
do quadro e são pequenas (< 12% da maior ilha do quadro).
  python limpar_bordas.py <personagem> <animacao> [...]"""
import sys
from PIL import Image

cid = sys.argv[1]
LIMIAR = 0.12
if sys.argv[2].startswith("--limiar="):
    LIMIAR = float(sys.argv.pop(2).split("=")[1])
for anim in sys.argv[2:]:
    p = f"C:/Projetos/smash_junq/game/assets/characters/{cid}/pixel/{anim}.png"
    im = Image.open(p).convert("RGBA")
    px = im.load()
    removed = 0
    for f in range(im.width // 64):
        x0 = f * 64
        seen = set()
        comps = []
        for y in range(64):
            for x in range(64):
                if (x, y) in seen or px[x0 + x, y][3] == 0:
                    continue
                stack, comp = [(x, y)], []
                seen.add((x, y))
                while stack:
                    cx, cy = stack.pop()
                    comp.append((cx, cy))
                    for dx in (-1, 0, 1):
                        for dy in (-1, 0, 1):
                            nx, ny = cx + dx, cy + dy
                            if 0 <= nx < 64 and 0 <= ny < 64 and (nx, ny) not in seen and px[x0 + nx, ny][3] > 0:
                                seen.add((nx, ny))
                                stack.append((nx, ny))
                comps.append(comp)
        if not comps:
            continue
        big = max(len(c) for c in comps)
        for c in comps:
            edge = any(x in (0, 63) for x, _ in c)
            if len(c) < big * LIMIAR and (edge or LIMIAR > 0.2):
                for x, y in c:
                    px[x0 + x, y] = (0, 0, 0, 0)
                removed += len(c)
    im.save(p)
    print(anim, "pixels removidos:", removed)
