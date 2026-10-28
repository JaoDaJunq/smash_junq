"""Redesenha X, K e % nas fontes Kenney Future (CC0): no desenho original o X e o K
são quase iguais ao H ("KOs" lia "HOS", "1 X 3" lia "1 H 3") e o % parecia X/Z.
Mantém altura (640), traço (128) e largura de cada fonte.
Uso: python game/tools/corrigir_fonte.py   (regrava game/assets/fonts/kenney_future*.ttf)
"""
import os
from fontTools.ttLib import TTFont
from fontTools.pens.ttGlyphPen import TTGlyphPen

DIR = os.path.join(os.path.dirname(__file__), "..", "assets", "fonts")
CAP, ST, DG = 640, 128, 150  # altura, traço reto, traço diagonal (medido na horizontal)


def area(p):
    return sum(p[i][0] * p[(i + 1) % len(p)][1] - p[(i + 1) % len(p)][0] * p[i][1] for i in range(len(p))) / 2


def desenha(contornos, glyphset):
    pen = TTGlyphPen(glyphset)
    for c in contornos:
        if area(c) > 0:  # TrueType: contorno externo no sentido horário
            c = list(reversed(c))
        pen.moveTo(c[0])
        for pt in c[1:]:
            pen.lineTo(pt)
        pen.closePath()
    return pen.glyph()


def x(w):
    return [[(0, CAP), (DG, CAP), (w, 0), (w - DG, 0)],
            [(w - DG, CAP), (w, CAP), (DG, 0), (0, 0)]]


def k(w):
    meio = CAP // 2
    return [[(0, 0), (0, CAP), (ST, CAP), (ST, 0)],
            [(ST - 10, meio - 70), (ST + DG - 10, meio - 70), (w, CAP), (w - DG, CAP)],
            [(ST - 10, meio + 70), (ST + DG - 10, meio + 70), (w, 0), (w - DG, 0)]]


def pct(w):
    q = 150
    return [[(0, CAP - q), (0, CAP), (q, CAP), (q, CAP - q)],
            [(w - q, 0), (w - q, q), (w, q), (w, 0)],
            [(0, 0), (DG, 0), (w, CAP), (w - DG, CAP)]]


for nome, w_letra in (("kenney_future.ttf", 640), ("kenney_future_narrow.ttf", 512)):
    p = os.path.join(DIR, nome)
    t = TTFont(p)
    gs = t.getGlyphSet()
    cmap = t.getBestCmap()
    glyf = t["glyf"]
    w_pct = w_letra - 128
    for ch, forma in (("X", x(w_letra)), ("x", x(w_letra)), ("K", k(w_letra)), ("k", k(w_letra)), ("%", pct(w_pct))):
        g = cmap.get(ord(ch))
        if g is None:
            continue
        glyf[g] = desenha(forma, gs)
        glyf[g].recalcBounds(glyf)
        adv, _ = t["hmtx"][g]
        t["hmtx"][g] = (adv, glyf[g].xMin)
    t.save(p)
    print("corrigida:", nome)
