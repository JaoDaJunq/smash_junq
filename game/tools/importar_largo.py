"""Importa folhas LARGAS (quadros mais compridos que 64, ex.: o laço da Sucuri com a
cauda esticada) para o jogo. Cada folha 1536x1024 tem 2 linhas = 2 quadros de 192x64
ampliados 8x. O corpo fica nos 64 px da esquerda, no mesmo lugar dos quadros normais.

  python game/tools/importar_largo.py <personagem> <animacao> art/pixel/<id>/largos/<folha1.png> [...]
(as folhas largas ficam em art/pixel/<id>/largos/, fora do importar_pixel.gd)

Grava game/assets/characters/<id>/pixel/<animacao>.png (quadros lado a lado) e
acrescenta a animação em largos.json (o importar_pixel.gd não mexe nesse arquivo).
Alinha pelos pés: a linha mais baixa do desenho vai para a linha 59."""
import sys, os, json
from PIL import Image

W, H, S, BASE = 192, 64, 8, 59


def bg(p):
    return p[0] > 180 and p[2] > 180 and p[1] < 110


def frame(sheet, row):
    out = Image.new("RGBA", (W, H), (0, 0, 0, 0))
    px = sheet.load()
    o = out.load()
    for y in range(H):
        for x in range(W):
            p = px[x * S + S // 2, row * H * S + y * S + S // 2]
            if not bg(p):
                o[x, y] = (p[0], p[1], p[2], 255)
    bbox = out.getbbox()
    if bbox:
        dy = BASE + 1 - bbox[3]
        moved = Image.new("RGBA", (W, H), (0, 0, 0, 0))
        moved.paste(out, (0, dy))
        out = moved
    return out


def main():
    cid, anim, files = sys.argv[1], sys.argv[2], sys.argv[3:]
    frames = []
    for f in files:
        sheet = Image.open(f).convert("RGB")
        assert sheet.size == (1536, 1024), f"{f}: {sheet.size}"
        for row in range(2):
            fr = frame(sheet, row)
            if fr.getbbox():
                frames.append(fr)
    strip = Image.new("RGBA", (W * len(frames), H), (0, 0, 0, 0))
    for i, fr in enumerate(frames):
        strip.paste(fr, (i * W, 0))
    root = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", "assets", "characters", cid, "pixel"))
    strip.save(os.path.join(root, anim + ".png"))
    jp = os.path.join(root, "largos.json")
    meta = json.load(open(jp, encoding="utf-8")) if os.path.exists(jp) else {}
    meta[anim] = {"quadros": len(frames), "largura": W}
    json.dump(meta, open(jp, "w", encoding="utf-8"), indent=2)
    print(anim, len(frames), "quadros ->", root)


main()
