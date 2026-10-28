#!/usr/bin/env python
"""Confere o quadro de "impacto" dos golpes de cada personagem.

Para cada golpe (animações de ATTACK_ANIM do pixel_sprite.gd) mede, quadro a
quadro da tira, o quanto o desenho se estica NA DIREÇÃO DO GOLPE (pixels opacos,
alfa > 0.5) e compara o quadro mais esticado com o "impacto" do animacoes.json.

Direção por golpe:
  frente  -> coluna opaca mais à direita (as folhas olham para a direita)
  tras    -> coluna opaca mais à esquerda (alcance para trás)
  cima    -> linha opaca mais alta
  baixo   -> linha opaca mais baixa
  largura -> largura total da caixa opaca (golpes sem direção clara)

Uso (da raiz do repositório):
    python game/tools/medir_impacto.py [personagem ...] [--todos] [--min 2]

Lista só os golpes em que o mais esticado ganha do impacto atual por pelo menos
--min pixels nativos (padrão 2); com --todos lista todos.
Só usa a biblioteca padrão + Pillow.
"""
import argparse
import json
import os
import sys

from PIL import Image

RAIZ = os.path.join(os.path.dirname(os.path.abspath(__file__)), "..", "assets", "characters")
# Caso claro: o quadro mais esticado fica a no máximo JANELA quadros do impacto.
JANELA = 2

# animação -> (golpe, direção)
GOLPES = {
    "jab": ("jab", "frente"), "jab_b": ("jab2", "frente"), "jab_c": ("jab3", "frente"),
    "golpe_frente": ("ftilt", "frente"), "golpe_cima": ("utilt", "cima"), "golpe_baixo": ("dtilt", "frente"),
    "aereo_neutro": ("nair", "largura"), "aereo_frente": ("fair", "frente"), "aereo_tras": ("bair", "tras"),
    "aereo_cima": ("uair", "cima"), "aereo_baixo": ("dair", "baixo"),
    "especial_neutro": ("special_neutral", "largura"), "especial_lado": ("special_side", "frente"),
    "especial_cima": ("special_up", "cima"), "especial_baixo": ("special_down", "largura"),
}


def caixa(img, x0, fw, h):
    """(esq, topo, dir, base) dos pixels opacos do quadro; None se vazio."""
    px = img.load()
    esq, topo, dir_, base = None, None, None, None
    for y in range(h):
        for x in range(fw):
            if px[x0 + x, y][3] > 127:
                esq = x if esq is None else min(esq, x)
                dir_ = x if dir_ is None else max(dir_, x)
                topo = y if topo is None else min(topo, y)
                base = y if base is None else max(base, y)
    if esq is None:
        return None
    return esq, topo, dir_, base


def alcance(c, direcao):
    esq, topo, dir_, base = c
    return {"frente": dir_, "tras": -esq, "cima": -topo, "baixo": base, "largura": dir_ - esq}[direcao]


def medir(personagem):
    pasta = os.path.join(RAIZ, personagem, "pixel")
    meta_path = os.path.join(pasta, "animacoes.json")
    if not os.path.exists(meta_path):
        return []
    meta = json.load(open(meta_path, encoding="utf-8"))
    largos = {}
    if os.path.exists(os.path.join(pasta, "largos.json")):
        largos = json.load(open(os.path.join(pasta, "largos.json"), encoding="utf-8"))
    linhas = []
    for anim, (golpe, direcao) in GOLPES.items():
        if anim not in meta or anim in largos or not isinstance(meta[anim], dict):
            continue
        m = meta[anim]
        n, impacto, fator = int(m["quadros"]), int(m.get("impacto", 0)), int(m.get("fator", 1))
        img = Image.open(os.path.join(pasta, anim + ".png")).convert("RGBA")
        fw = img.width // n
        medidas = []
        for i in range(n):
            c = caixa(img, i * fw, fw, img.height)
            medidas.append(alcance(c, direcao) if c else -999)
        # mais esticado; empate: o mais perto do impacto atual
        melhor = max(range(n), key=lambda i: (medidas[i], -abs(i - impacto)))
        # "caso claro": olhando só perto do impacto (+-JANELA), sem o 1º e o último
        # quadro (pose de guarda), e só golpes com direção (não "largura").
        perto = [i for i in range(max(1, impacto - JANELA), min(n - 1, impacto + JANELA + 1))]
        claro = max(perto, key=lambda i: (medidas[i], -abs(i - impacto))) if perto else impacto
        linhas.append({
            "personagem": personagem, "anim": anim, "golpe": golpe, "direcao": direcao,
            "quadros": n, "fator": fator, "impacto": impacto, "mais_esticado": melhor,
            "ganho": medidas[melhor] - medidas[impacto], "medidas": medidas,
            "claro": claro if direcao != "largura" else impacto,
            "ganho_claro": medidas[claro] - medidas[impacto],
        })
    return linhas


def main() -> int:
    ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
    ap.add_argument("personagens", nargs="*")
    ap.add_argument("--todos", action="store_true", help="lista também os golpes que já batem")
    ap.add_argument("--min", type=int, default=2, help="ganho mínimo (px nativos) para listar")
    a = ap.parse_args()
    nomes = a.personagens or sorted(os.listdir(RAIZ))
    total = diferentes = claros = 0
    for p in nomes:
        for l in medir(p):
            total += 1
            difere = l["mais_esticado"] != l["impacto"] and l["ganho"] >= a.min
            claro = l["claro"] != l["impacto"] and l["ganho_claro"] >= a.min
            diferentes += difere
            claros += claro
            if difere or a.todos:
                med = " ".join("%d%s" % (v, "*" if i == l["impacto"] else "") for i, v in enumerate(l["medidas"]))
                print("%-12s %-16s %-16s %-7s impacto=%d mais_esticado=%d ganho=%+d px  [%s]%s" % (
                    p, l["golpe"], l["anim"], l["direcao"], l["impacto"], l["mais_esticado"], l["ganho"], med,
                    ("  <-- CLARO: %d (%+d px)" % (l["claro"], l["ganho_claro"])) if claro else ""))
    print("MEDIDOS: %d golpe(s); %d com quadro mais esticado != impacto (ganho >= %d px); "
          "%d caso(s) claro(s) (vizinho do impacto, golpe com direção)" % (total, diferentes, a.min, claros))
    return 0


if __name__ == "__main__":
    sys.exit(main())
