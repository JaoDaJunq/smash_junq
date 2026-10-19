"""Importa a arte das telas fora da partida (art/ui/) para o jogo.

    python game/tools/importar_ui.py

- menu_fundo.png  -> game/assets/ui/menu_fundo.png (cópia)
- logo.png, mapa_brasil.png -> game/assets/ui/ (magenta vira transparente,
  recortado no desenho)
- retrato_<id>.png -> game/assets/characters/<id>/retrato_pixel.png
"""
import os
import sys

from PIL import Image

ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
SRC = os.path.join(ROOT, "art", "ui")
UI = os.path.join(ROOT, "game", "assets", "ui")
CHARS = os.path.join(ROOT, "game", "assets", "characters")


def key_magenta(im):
    """Magenta (e a franja rosada em volta) vira transparente; recorta no desenho."""
    im = im.convert("RGBA")
    px = im.load()
    w, h = im.size
    for y in range(h):
        for x in range(w):
            r, g, b, a = px[x, y]
            # quanto mais "magenta" (vermelho e azul altos, verde baixo), mais transparente
            m = min(r, b) - g
            if m > 110:
                px[x, y] = (0, 0, 0, 0)
            elif m > 60:
                # franja: tira o rosa (puxa vermelho/azul para o verde) e deixa meio opaco
                k = (m - 60) / 50.0
                px[x, y] = (int(r - (r - g) * k * 0.8), g, int(b - (b - g) * k * 0.8), int(255 * (1 - k)))
    box = im.getbbox()
    return im.crop(box) if box else im


def main():
    os.makedirs(UI, exist_ok=True)
    done = []
    bg = os.path.join(SRC, "menu_fundo.png")
    if os.path.exists(bg):
        Image.open(bg).convert("RGB").save(os.path.join(UI, "menu_fundo.png"))
        done.append("menu_fundo")
    names = ["logo", "mapa_brasil"] + sorted(f[:-4] for f in os.listdir(SRC) if f.startswith("apresentacao_") and f.endswith(".png"))
    for name in names:
        p = os.path.join(SRC, name + ".png")
        if os.path.exists(p):
            key_magenta(Image.open(p)).save(os.path.join(UI, name + ".png"))
            done.append(name)
    for f in sorted(os.listdir(SRC)):
        if f.startswith("retrato_") and f.endswith(".png"):
            cid = f[len("retrato_"):-4]
            dst = os.path.join(CHARS, cid)
            if os.path.isdir(dst):
                key_magenta(Image.open(os.path.join(SRC, f))).save(os.path.join(dst, "retrato_pixel.png"))
                done.append(f)
    print("importado:", ", ".join(done) or "nada")


if __name__ == "__main__":
    sys.exit(main())
