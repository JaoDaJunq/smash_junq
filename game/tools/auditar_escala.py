"""Audita a escala de cada quadro das folhas de um personagem contra o 'parado'.
Mede a área opaca (pixels com alfa) de cada quadro; pose agachada muda a altura,
mas a área do corpo quase não muda. Um quadro solto pequeno é normal (pose
encolhida); o sinal de escala errada é a FOLHA INTEIRA pequena ou grande: a
mediana da folha < LIM_MENOR ou > LIM_MAIOR da média do parado = reprovada.
Calibrado no Berrante (jab_c 0,56 e tonto 0,60 visivelmente ~20% menores).
Uso: python game/tools/auditar_escala.py <id> [<id> ...]  (sai 1 se achar suspeito)
"""
import json, sys, os
from PIL import Image
LIM_MENOR, LIM_MAIOR = 0.66, 1.45
## Objetos (projéteis, adereços) não são o personagem: fora da auditoria.
IGNORA = {"retrato_pixel", "castanha", "pandeiro", "semente", "nota", "laco_cauda", "estandarte", "arco",
          "cama_elastica", "castanha_enterrada", "rabo", "rabo_solto", "pipoca", "areia", "faixa_interditado"}
base = os.path.join(os.path.dirname(__file__), "..", "assets", "characters")
ruim = 0
ids = sys.argv[1:] or sorted(x for x in os.listdir(base) if os.path.exists(os.path.join(base, x, "pixel", "animacoes.json")))
for cid in ids:
    d = os.path.join(base, cid, "pixel")
    meta = json.load(open(os.path.join(d, "animacoes.json"), encoding="utf-8"))
    def areas(anim):
        im = Image.open(os.path.join(d, anim + ".png")).convert("RGBA")
        n = int(meta[anim]["quadros"]); fw = im.width // n
        out = []
        for i in range(n):
            a = im.crop((i * fw, 0, (i + 1) * fw, im.height)).getchannel("A")
            out.append(sum(1 for p in a.tobytes() if p > 128))
        return out
    ref = areas("parado"); ref = sum(ref) / len(ref)
    print(f"== {cid}: área média do parado = {ref:.0f} px")
    for anim in sorted(meta):
        if anim in IGNORA or anim.startswith("fx_") or not os.path.exists(os.path.join(d, anim + ".png")):
            continue
        r = [a / ref for a in areas(anim)]
        med = sorted(r)[len(r) // 2]
        if med < LIM_MENOR or med > LIM_MAIOR:
            ruim += 1
            print(f"  [ESCALA] {anim}: mediana {med:.2f} do parado   (quadros: {' '.join(f'{x:.2f}' for x in r)})")
print(f"AUDITORIA ESCALA: {ruim} folha(s) suspeita(s)")
sys.exit(1 if ruim else 0)
