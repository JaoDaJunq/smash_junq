"""Reorganiza uma folha de pixel art que veio fora da grade padrão (ex.: 4 quadros
lado a lado numa linha) para a grade do importador: 1536x1024, 3x2 células de
512x512, quadros de 64x64 ampliados 8x, fundo magenta #FF00FF.

- acha cada quadro pelas faixas de fundo magenta (linhas e colunas vazias);
- usa pixel de 8x8 (o que o pedido exige; outro valor com --bloco N);
- reduz para o tamanho nativo e amplia 8x, centrado na célula, pés na linha 59.

Uso (a partir da raiz do repositório):
  python game/tools/normalizar_folha.py <entrada.png> [saida.png]
Sem saída, sobrescreve a entrada. --topo: encosta o desenho no alto da célula e
corta o que passar de 64 embaixo (poses penduradas, presas pela mão). Criado no playtest 01 (o gerador às vezes ignora a grade).
"""
import sys
from PIL import Image

CELL, NATIVE, SCALE, BASELINE = 512, 64, 8, 59
MAG = (255, 0, 255)
## O pedido sempre exige pixel de 8x8; o gerador erra a grade, não o tamanho do pixel.
## Para outra escala: --bloco N.
BLOCO = 8


def bg(p):
    return p[0] > 180 and p[2] > 180 and p[1] < 110


def bands(mask_line, min_gap):
    """Intervalos [a, b) onde há conteúdo, unindo buracos menores que min_gap."""
    out, start, gap = [], None, 0
    for i, v in enumerate(mask_line):
        if v:
            if start is None:
                start = i
            gap = 0
        elif start is not None:
            gap += 1
            if gap >= min_gap:
                out.append((start, i - gap + 1))
                start, gap = None, 0
    if start is not None:
        out.append((start, len(mask_line) - gap))
    return out


def main():
    global BLOCO
    args = sys.argv[1:]
    if "--bloco" in args:
        i = args.index("--bloco")
        BLOCO = float(args[i + 1])
        del args[i:i + 2]
    topo = "--topo" in args
    if topo:
        args.remove("--topo")
    src = args[0]
    dst = args[1] if len(args) > 1 else src
    im = Image.open(src).convert("RGB")
    W, H = im.size
    px = im.load()
    rows = bands([any(not bg(px[x, y]) for x in range(0, W, 2)) for y in range(H)], 40)
    frames = []
    for (ya, yb) in rows:
        cols = bands([any(not bg(px[x, y]) for y in range(ya, yb, 2)) for x in range(W)], 8)
        # dois quadros colados (sem fundo entre eles): corta na coluna mais vazia
        fixed = []
        for (xa, xb) in cols:
            while xb - xa > NATIVE * BLOCO:
                lo, hi = xa + int((xb - xa) * 0.3), xa + int((xb - xa) * 0.7)
                cut = min(range(lo, hi), key=lambda x: sum(not bg(px[x, y]) for y in range(ya, yb)))
                fixed.append((xa, cut))
                xa = cut
            fixed.append((xa, xb))
        cols = fixed
        for (xa, xb) in cols:
            frames.append((xa, ya, xb, yb))
    if len(frames) > 6:
        sys.exit(f"{src}: {len(frames)} quadros achados, mais que 6; confira à mão")
    out = Image.new("RGB", (1536, 1024), MAG)
    for i, box in enumerate(frames):
        b = BLOCO
        xa, ya, xb, yb = box
        w, h = max(1, round((xb - xa) / b)), max(1, round((yb - ya) / b))
        small = Image.new("RGBA", (w, h), (0, 0, 0, 0))
        for y in range(h):
            for x in range(w):
                p = im.getpixel((min(W - 1, int(xa + (x + 0.5) * b)), min(H - 1, int(ya + (y + 0.5) * b))))
                if not bg(p):
                    small.putpixel((x, y), (*p, 255))
        if topo and h > NATIVE:  # pendurado: a mão fica no topo, corta só a ponta de baixo
            print(f"  quadro {i + 1}: {h - NATIVE} linha(s) de baixo cortadas")
            small = small.crop((0, 0, w, NATIVE))
            h = NATIVE
        if w > NATIVE or h > NATIVE:
            sys.exit(f"{src}: quadro {i + 1} com {w}x{h} nativos (bloco {b}); maior que 64")
        cell = Image.new("RGBA", (NATIVE, NATIVE), (0, 0, 0, 0))
        cell.alpha_composite(small, ((NATIVE - w) // 2, 0 if topo else max(0, BASELINE + 1 - h)))
        big = cell.resize((CELL, CELL), Image.NEAREST)
        c, r = i % 3, i // 3
        layer = Image.new("RGB", (CELL, CELL), MAG)
        layer.paste(big, (0, 0), big)
        out.paste(layer, (c * CELL, r * CELL))
        print(f"  quadro {i + 1}: bloco {b}px -> {w}x{h} nativos")
    out.save(dst)
    print(f"{src}: {len(frames)} quadros -> {dst}")


if __name__ == "__main__":
    main()
