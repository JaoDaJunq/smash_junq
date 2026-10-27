"""Conserta folhas em que o gerador desenhou o quadro atravessando a divisão das
células (o bico/cauda invade a célula vizinha), SEM mudar a escala nem centralizar
cada quadro (o que faria o corpo pular entre quadros).

- reduz a folha para o tamanho nativo (1 pixel por bloco de 8x8: 192x128);
- separa os pedaços do desenho (componentes ligados) e entrega cada pedaço à
  célula onde está a maior parte dele (pedaços pequenos vão para o pedaço grande
  mais próximo);
- cada quadro é deslocado o MÍNIMO necessário para caber na sua célula de 64x64
  (com 1 px de folga); quem já cabe não se mexe;
- grava de volta em 1536x1024 (8x).

Uso: python game/tools/recentrar_folha.py <folha.png> [saida.png] [--so-medir] [--margem N]
--margem N: grava células de 64+2N (quadros largos; ver MARGEM em importar_pixel.gd).
Sai com erro se um quadro tiver mais de 62x62 nativos (aí não tem como caber).
"""
import sys
from PIL import Image

N, S = 64, 8
MAG = (255, 0, 255)


def bg(p):
    return p[0] > 180 and p[2] > 180 and p[1] < 110


def main():
    argv = sys.argv[1:]
    m = 0
    if "--margem" in argv:
        i = argv.index("--margem")
        m = int(argv[i + 1])
        del argv[i:i + 2]
    args = [a for a in argv if not a.startswith("--")]
    so_medir = "--so-medir" in sys.argv
    src = args[0]
    dst = args[1] if len(args) > 1 else src
    im = Image.open(src).convert("RGB")
    W, H = im.size
    cols, rows = 3, 2
    w, h = W // S, H // S
    small = [[None] * w for _ in range(h)]
    for y in range(h):
        for x in range(w):
            p = im.getpixel((x * S + S // 2, y * S + S // 2))
            small[y][x] = None if bg(p) else p
    # componentes ligados (8 vizinhos)
    seen = [[False] * w for _ in range(h)]
    comps = []
    for y in range(h):
        for x in range(w):
            if small[y][x] is not None and not seen[y][x]:
                st, pts = [(x, y)], []
                seen[y][x] = True
                while st:
                    cx, cy = st.pop()
                    pts.append((cx, cy))
                    for dx in (-1, 0, 1):
                        for dy in (-1, 0, 1):
                            nx, ny = cx + dx, cy + dy
                            if 0 <= nx < w and 0 <= ny < h and not seen[ny][nx] and small[ny][nx] is not None:
                                seen[ny][nx] = True
                                st.append((nx, ny))
                comps.append(pts)
    big = [c for c in comps if len(c) >= 40]
    frames = {}
    for c in big:
        cnt = {}
        for (x, y) in c:
            k = (min(cols - 1, x // N), min(rows - 1, y // N))
            cnt[k] = cnt.get(k, 0) + 1
        k = max(cnt, key=cnt.get)
        frames.setdefault(k, []).extend(c)
    for c in comps:
        if len(c) >= 40:
            continue
        cx, cy = c[0]
        best, bd = None, 1e9
        for k, pts in frames.items():
            d = min(abs(px - cx) + abs(py - cy) for (px, py) in pts[::3])
            if d < bd:
                best, bd = k, d
        if best is not None and bd <= 6:
            frames[best].extend(c)
    CW = N + 2 * m
    out = Image.new("RGB", (cols * CW * S, rows * N * S), MAG)
    moved = 0
    for k in sorted(frames, key=lambda k: (k[1], k[0])):
        pts = frames[k]
        xs = [p[0] for p in pts]
        ys = [p[1] for p in pts]
        x0, x1, y0, y1 = min(xs), max(xs), min(ys), max(ys)
        fw, fh = x1 - x0 + 1, y1 - y0 + 1
        cx0, cy0 = k[0] * N - m, k[1] * N
        if N < fh <= N + 3:  # até 3 linhas a mais: corta o topo (ponta de orelha/pelo)
            pts = [p for p in pts if p[1] > y1 - N]
            ys = [p[1] for p in pts]
            y0 = min(ys)
            fh = y1 - y0 + 1
            print(f"  quadro {k}: {fh + 0} de altura depois de cortar o topo")
        if fw > CW - 2 or fh > N:
            print(f"  quadro {k}: {fw}x{fh} nativos, NÃO cabe em 64")
            if not so_medir:
                sys.exit(f"{src}: quadro maior que 62 px; precisa pedir de novo")
            continue
        dx = 0
        if x0 < cx0 + 1:
            dx = cx0 + 1 - x0
        elif x1 > cx0 + CW - 2:
            dx = cx0 + CW - 2 - x1
        dy = 0
        if fh > N - 2:
            dy = cy0 - y0
        elif y0 < cy0 + 1:
            dy = cy0 + 1 - y0
        elif y1 > cy0 + N - 2:
            dy = cy0 + N - 2 - y1
        if dx or dy:
            moved += 1
            print(f"  quadro {k}: {fw}x{fh}, deslocado ({dx},{dy})")
        for (x, y) in pts:
            p = small[y][x]
            nx, ny = x + dx - k[0] * N + m + k[0] * CW, y + dy
            for yy in range(S):
                for xx in range(S):
                    out.putpixel((nx * S + xx, ny * S + yy), p)
    print(f"{src}: {len(frames)} quadros, {moved} deslocados")
    if not so_medir:
        out.save(dst)


if __name__ == "__main__":
    main()
