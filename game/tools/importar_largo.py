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


def frames_free(sheet, cid):
    """Folha fora do formato: acha cada linha pelo fundo, mede o corpo (1/4 da
    esquerda) e reduz para a altura do parado do personagem."""
    from PIL import Image as I
    px = sheet.load()
    w, h = sheet.size
    rows, start = [], None
    for y in range(h):
        filled = any(not bg(px[x, y]) for x in range(0, w, 3))
        if filled and start is None:
            start = y
        elif not filled and start is not None:
            if y - start > 20:
                rows.append((start, y))
            start = None
    if start is not None:
        rows.append((start, h))
    par = I.open(os.path.join(os.path.dirname(__file__), "..", "assets", "characters", cid, "pixel", "parado.png")).crop((0, 0, 64, 64)).getbbox()
    body_native = par[3] - par[1]
    out = []
    for (a, b) in rows:
        row = sheet.crop((0, a, w, b))
        rp = row.load()
        cols = [x for x in range(w) if any(not bg(rp[x, y]) for y in range(0, b - a, 2))]
        x0 = cols[0]
        body = row.crop((x0, 0, x0 + (cols[-1] - x0) // 4, b - a))
        bb = I.new("RGB", body.size)
        bp = body.load()
        ys = [y for y in range(body.size[1]) if any(not bg(bp[x, y]) for x in range(0, body.size[0], 2))]
        scale = (ys[-1] - ys[0] + 1) / body_native
        crop = row.crop((x0, 0, cols[-1] + 1, b - a))
        nw, nh = max(1, round(crop.size[0] / scale)), max(1, round(crop.size[1] / scale))
        small = crop.resize((nw, nh), I.NEAREST)
        sp = small.load()
        tmp = Image.new("RGBA", small.size, (0, 0, 0, 0))
        tp = tmp.load()
        for y in range(nh):
            for x in range(nw):
                if not bg(sp[x, y]):
                    tp[x, y] = (*sp[x, y][:3], 255)
        bbox = tmp.getbbox()
        tmp = tmp.crop(bbox)
        global W
        W = max(W, ((par[0] + tmp.size[0] + 4 + 31) // 32) * 32)
        out.append((tmp, par[0]))
    frames = []
    for tmp, x in out:
        fr = Image.new("RGBA", (W, H), (0, 0, 0, 0))
        fr.paste(tmp, (x, BASE + 1 - tmp.size[1]))
        frames.append(fr)
    return frames
    return out


def main():
    cid, anim, files = sys.argv[1], sys.argv[2], sys.argv[3:]
    frames = []
    for f in files:
        sheet = Image.open(f).convert("RGB")
        if sheet.size != (1536, 1024):
            print(f"{f}: {sheet.size} fora do formato; ajustando pela altura do parado")
            frames += frames_free(sheet, cid)
            continue
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
