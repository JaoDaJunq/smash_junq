"""Importa a arte de uma arena gerada pelo Codex para o jogo.

Entrada (art/arenas/<nome>/):
  fundo_longe.png  1536x1024, pixel art em blocos de 4x4 (céu e horizonte)
  fundo_perto.png  1536x1024, blocos de 4x4, fundo magenta = transparente
  palco.png        1536x1024, grade 3x2 de blocos 64x64 ampliados 8x, fundo magenta:
                   1 ponta esquerda, 2 meio, 3 ponta direita, 4 corpo de baixo,
                   5 e 6 as duas metades da plataforma pequena
Saída (game/assets/arenas/<nome>/):
  fundo_longe.png (384x256), fundo_perto.png (768x256: original + espelho, com transparência),
  palco.png (tira 384x64 com os 6 blocos) e arena.json com a linha da
  superfície (onde se pisa) de cada bloco.

Uso, a partir da raiz do repositório:
  python game/tools/importar_arena.py pantanal
"""
import json
import os
import sys
from PIL import Image

NATIVE = 64


def is_magenta(p):
    return p[0] > 180 and p[2] > 180 and p[1] < 110


def reduce(im, block, alpha):
    w, h = im.width // block, im.height // block
    out = Image.new("RGBA", (w, h), (0, 0, 0, 0))
    src = im.load()
    dst = out.load()
    for y in range(h):
        for x in range(w):
            p = src[x * block + block // 2, y * block + block // 2]
            if alpha and is_magenta(p):
                continue
            dst[x, y] = (p[0], p[1], p[2], 255)
    return out


def fill_width(tile, index):
    """Estica o bloco na horizontal até as bordas do quadro, para os blocos
    repetidos encostarem uns nos outros sem vão. Nas pontas do palco (0 e 2)
    só estica do lado que emenda com o meio; a quina de fora fica onde está."""
    box = tile.getbbox()
    if not box:
        return tile
    x0, _, x1, _ = box
    if index == 0:
        x1n, x0n = NATIVE, x0
    elif index == 2:
        x0n, x1n = 0, x1
    elif index == 4:
        x0n, x1n = x0, NATIVE
    elif index == 5:
        x0n, x1n = 0, x1
    else:
        x0n, x1n = 0, NATIVE
    if (x0n, x1n) == (x0, x1):
        return tile
    part = tile.crop((x0, 0, x1, NATIVE)).resize((x1n - x0n, NATIVE), Image.NEAREST)
    out = Image.new("RGBA", (NATIVE, NATIVE), (0, 0, 0, 0))
    out.paste(part, (x0n, 0))
    return out


def fill_cell(tile, k):
    """Estica o desenho de um bloco de terreno até as bordas do quadro, para os
    blocos encostarem sem buraco: os de cima (0-2) do topo do desenho até
    embaixo, os do corpo (3-5) no quadro todo, os de baixo (6-8) de cima até o
    fim do desenho. O gerador quase nunca enche a célula inteira."""
    box = tile.getbbox()
    if not box:
        return tile
    x0, y0, x1, y1 = box
    # Tira 2 pixels dos lados que emendam com outro bloco (o gerador costuma pôr
    # contorno ali, e isso vira uma grade no terreno).
    cut = 2
    if k in (1, 4, 7) or k in (0, 3, 6):
        x1 -= cut
    if k in (1, 4, 7) or k in (2, 5, 8):
        x0 += cut
    if k in (3, 4, 5):
        y0 += cut
        y1 -= cut
    elif k < 3:
        y1 -= cut
    else:
        y0 += cut
    box = (x0, y0, x1, y1)
    if k < 3:
        target = (0, y0, NATIVE, NATIVE)
    elif k < 6:
        target = (0, 0, NATIVE, NATIVE)
    else:
        target = (0, 0, NATIVE, y1)
    part = tile.crop(box).resize((target[2] - target[0], target[3] - target[1]), Image.NEAREST)
    out = Image.new("RGBA", (NATIVE, NATIVE), (0, 0, 0, 0))
    out.paste(part, (target[0], target[1]))
    return out


def surface_row(tile):
    """Primeira linha com pelo menos 40% de pixels desenhados (o chão do bloco)."""
    px = tile.load()
    for y in range(NATIVE):
        filled = sum(1 for x in range(NATIVE) if px[x, y][3] > 0)
        if filled >= NATIVE * 0.4:
            return y
    return 0


def main():
    name = sys.argv[1]
    root = os.getcwd()
    src = os.path.join(root, "art", "arenas", name)
    dst = os.path.join(root, "game", "assets", "arenas", name)
    os.makedirs(dst, exist_ok=True)
    sheet = Image.open(os.path.join(src, "palco.png")).convert("RGB")
    tiles = reduce(sheet, 8, True)  # 192x128: 3x2 blocos de 64
    strip = Image.new("RGBA", (NATIVE * 6, NATIVE), (0, 0, 0, 0))
    surfaces = []
    for i in range(6):
        c, r = i % 3, i // 3
        t = tiles.crop((c * NATIVE, r * NATIVE, (c + 1) * NATIVE, (r + 1) * NATIVE))
        if i != 3:
            t = fill_width(t, i)
        strip.paste(t, (i * NATIVE, 0))
        surfaces.append(surface_row(t))
    strip.save(os.path.join(dst, "palco.png"))
    meta = {"superficie": surfaces}
    # Versão 2 (rodada 4): cenário pintado + blocos de terreno em 9 partes.
    v2 = os.path.join(src, "v2")
    if os.path.isdir(v2):
        Image.open(os.path.join(v2, "fundo.png")).convert("RGB").save(os.path.join(dst, "fundo.png"))
        blocks = Image.new("RGBA", (NATIVE * 12, NATIVE), (0, 0, 0, 0))
        for half, sheet_name in enumerate(("blocos_cima.png", "blocos_baixo.png")):
            cells = reduce(Image.open(os.path.join(v2, sheet_name)).convert("RGB"), 8, True)
            for i in range(6):
                c, r = i % 3, i // 3
                t = cells.crop((c * NATIVE, r * NATIVE, (c + 1) * NATIVE, (r + 1) * NATIVE))
                k = half * 6 + i
                if k < 9:
                    t = fill_cell(t, k)
                blocks.paste(t, (k * NATIVE, 0))
        blocks.save(os.path.join(dst, "blocos.png"))
        meta["superficie_blocos"] = surface_row(blocks.crop((NATIVE, 0, 2 * NATIVE, NATIVE)))
        meta["versao"] = 2
    with open(os.path.join(dst, "arena.json"), "w", encoding="utf-8") as f:
        json.dump(meta, f, indent=2)
    print(f"{name}: plataformas {surfaces}, terreno {meta.get('superficie_blocos')} -> {dst}")


if __name__ == "__main__":
    main()
