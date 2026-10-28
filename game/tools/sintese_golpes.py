#!/usr/bin/env python
"""Sintetiza os sons de golpe, escudo, KO, menu e as assinaturas do Smash Junq.

Só biblioteca padrão (wave, math, random, struct, array). Gera WAV 48 kHz mono
16 bits numa pasta temporária e converte para .ogg (Vorbis) com o ffmpeg em
game/assets/sfx/. Tudo é som próprio (autoria do projeto), sem amostras de fora.

Uso (da raiz do repositório):
    python game/tools/sintese_golpes.py [--ffmpeg CAMINHO] [--wav-dir PASTA] [--so-wav]

Receita do golpe (análise externa): o alto-falante de celular/notebook quase não
toca abaixo de ~300 Hz, então o "tapa" precisa morar em 1-4 kHz:
  1) transiente agudo 2-9 kHz de 2-4 ms (o estalo chega ao pico em 1-2 ms);
  2) estalo 900-3500 Hz de 15-35 ms;
  3) corpo: seno com queda de tom 190->90 Hz, saturado (gera harmônicos audíveis);
  4) soco médio 250-700 Hz;
  5) cauda curta de ruído grave;
  6) só no forte/KO: um "shing" metálico curto (parciais inarmônicos).
"""
import argparse
import array
import math
import os
import random
import subprocess
import sys
import wave

SR = 48000
ROOT = os.path.abspath(os.path.join(os.path.dirname(__file__), "..", ".."))
OUT_DIR = os.path.join(ROOT, "game", "assets", "sfx")
FFMPEG_DEFAULT = "C:/Users/jpach/AppData/Local/hermes/tools/ffmpeg-9.0.1-win32-x64/bin/ffmpeg.exe"


# --------------------------------------------------------------------------
# Peças básicas
# --------------------------------------------------------------------------

def n_samples(seconds):
    return int(seconds * SR)


def zeros(seconds):
    return [0.0] * n_samples(seconds)


def mix(dst, src, gain=1.0, offset=0.0):
    """Soma src em dst (estende dst se preciso), começando em offset segundos."""
    start = n_samples(offset)
    need = start + len(src)
    if need > len(dst):
        dst.extend([0.0] * (need - len(dst)))
    for i, v in enumerate(src):
        dst[start + i] += v * gain
    return dst


def noise(seconds, rng):
    return [rng.uniform(-1.0, 1.0) for _ in range(n_samples(seconds))]


def env_exp(seconds, decay, attack=0.0005):
    """Envelope: subida linear em `attack` s e queda exponencial (constante `decay` s)."""
    n = n_samples(seconds)
    a = max(1, n_samples(attack))
    out = []
    for i in range(n):
        t = i / SR
        g = min(1.0, (i + 1) / a)
        out.append(g * math.exp(-max(0.0, t - attack) / decay))
    return out


def apply_env(x, env):
    return [a * b for a, b in zip(x, env)]


class Biquad:
    """Filtro biquad (fórmulas do RBJ Audio EQ Cookbook)."""

    def __init__(self, kind, f0, q=0.707):
        w = 2.0 * math.pi * f0 / SR
        cw, sw = math.cos(w), math.sin(w)
        al = sw / (2.0 * q)
        if kind == "lp":
            b0, b1, b2 = (1 - cw) / 2, 1 - cw, (1 - cw) / 2
        elif kind == "hp":
            b0, b1, b2 = (1 + cw) / 2, -(1 + cw), (1 + cw) / 2
        elif kind == "bp":  # ganho 0 dB no centro
            b0, b1, b2 = al, 0.0, -al
        else:
            raise ValueError(kind)
        a0, a1, a2 = 1 + al, -2 * cw, 1 - al
        self.b = (b0 / a0, b1 / a0, b2 / a0)
        self.a = (a1 / a0, a2 / a0)
        self.z1 = self.z2 = 0.0

    def tick(self, x):
        b0, b1, b2 = self.b
        a1, a2 = self.a
        y = b0 * x + self.z1
        self.z1 = b1 * x - a1 * y + self.z2
        self.z2 = b2 * x - a2 * y
        return y

    def run(self, xs):
        return [self.tick(v) for v in xs]


def band(xs, lo, hi, order=2):
    """Passa-faixa por cascata de passa-alta + passa-baixa (`order` vezes cada)."""
    for _ in range(order):
        xs = Biquad("hp", lo).run(xs)
        xs = Biquad("lp", hi).run(xs)
    return xs


def bp_sweep(xs, f_start, f_end, q, curve=1.0):
    """Passa-faixa com centro que anda de f_start para f_end (efeito 'wah')."""
    out = []
    n = len(xs)
    z1 = z2 = 0.0
    for i, x in enumerate(xs):
        u = (i / max(1, n - 1)) ** curve
        f0 = f_start * (f_end / f_start) ** u
        w = 2.0 * math.pi * f0 / SR
        cw, sw = math.cos(w), math.sin(w)
        al = sw / (2.0 * q)
        a0 = 1 + al
        b0, b2 = al / a0, -al / a0
        a1, a2 = -2 * cw / a0, (1 - al) / a0
        y = b0 * x + z1
        z1 = -a1 * y + z2
        z2 = b2 * x - a2 * y
        out.append(y)
    return out


def sine_glide(seconds, f_start, f_end, glide, phase=0.0):
    """Seno com queda exponencial de tom de f_start para f_end em ~glide s."""
    out = []
    ph = phase
    for i in range(n_samples(seconds)):
        t = i / SR
        f = f_end + (f_start - f_end) * math.exp(-t / glide)
        ph += 2.0 * math.pi * f / SR
        out.append(math.sin(ph))
    return out


def partials(seconds, freqs, decays, amps, rng):
    """Soma de senos inarmônicos com queda própria (sinos, metais)."""
    out = [0.0] * n_samples(seconds)
    for f, d, a in zip(freqs, decays, amps):
        ph = rng.uniform(0, 2 * math.pi)
        k = 2.0 * math.pi * f / SR
        for i in range(len(out)):
            out[i] += a * math.sin(ph + k * i) * math.exp(-(i / SR) / d)
    return out


def saturate(xs, drive):
    norm = math.tanh(drive)
    return [math.tanh(v * drive) / norm for v in xs]


def peak(xs):
    return max(1e-9, max(abs(v) for v in xs))


def normalize(xs, peak_db=-1.0):
    g = 10 ** (peak_db / 20.0) / peak(xs)
    return [v * g for v in xs]


def fade_out(xs, seconds=0.006):
    n = min(len(xs), n_samples(seconds))
    for i in range(n):
        xs[len(xs) - n + i] *= 1.0 - (i + 1) / n
    return xs


def dc_block(xs):
    return Biquad("hp", 25.0).run(xs)


def write_wav(path, xs):
    data = array.array("h", (int(max(-1.0, min(1.0, v)) * 32767) for v in xs))
    if sys.byteorder != "little":
        data.byteswap()
    with wave.open(path, "wb") as w:
        w.setnchannels(1)
        w.setsampwidth(2)
        w.setframerate(SR)
        w.writeframes(data.tobytes())


# --------------------------------------------------------------------------
# Golpes
# --------------------------------------------------------------------------

# Parâmetros por peso do golpe. body_* = corpo saturado; snap_* = estalo; etc.
HIT_KINDS = {
    "leve": dict(trans=0.0025, snap_len=0.018, snap=(1100, 3500), snap_g=0.9,
                 body_f=(230, 115), body_len=0.09, body_decay=0.035, body_g=0.55, drive=2.2,
                 punch_g=0.35, punch_decay=0.022, tail_len=0.10, tail_g=0.10, shing=0.0),
    "medio": dict(trans=0.003, snap_len=0.026, snap=(950, 3400), snap_g=0.95,
                  body_f=(200, 95), body_len=0.14, body_decay=0.05, body_g=0.75, drive=2.8,
                  punch_g=0.45, punch_decay=0.03, tail_len=0.16, tail_g=0.14, shing=0.0),
    "forte": dict(trans=0.004, snap_len=0.034, snap=(900, 3300), snap_g=1.0,
                  body_f=(190, 85), body_len=0.22, body_decay=0.075, body_g=0.95, drive=3.4,
                  punch_g=0.55, punch_decay=0.04, tail_len=0.26, tail_g=0.18, shing=0.28),
    "ko": dict(trans=0.004, snap_len=0.035, snap=(900, 3200), snap_g=1.0,
               body_f=(180, 55), body_len=0.55, body_decay=0.16, body_g=1.0, drive=4.0,
               punch_g=0.6, punch_decay=0.06, tail_len=0.7, tail_g=0.25, shing=0.38),
}


def hit(kind, variant):
    p = HIT_KINDS[kind]
    rng = random.Random("%s-%d" % (kind, variant))  # semente fixa: mesmo som a cada geração
    jitter = 1.0 + (variant - 1) * 0.06  # variações: tom um pouco diferente
    out = []
    # 1) transiente agudo 2-9 kHz, pico em ~0,7 ms
    t = band(noise(p["trans"] + 0.002, rng), 2000, 9000)
    mix(out, apply_env(t, env_exp(p["trans"] + 0.002, p["trans"] / 2.5, attack=0.0007)), 2.2)
    # 2) estalo 900-3500 Hz, pico em ~1,5 ms
    lo, hi = p["snap"]
    s = band(noise(p["snap_len"] * 2.5, rng), lo * jitter, hi * jitter)
    mix(out, apply_env(s, env_exp(p["snap_len"] * 2.5, p["snap_len"] / 2.2, attack=0.0015)), 2.4 * p["snap_g"])
    # 3) corpo: seno com queda de tom, saturado
    f0, f1 = p["body_f"]
    b = sine_glide(p["body_len"], f0 * jitter, f1 * jitter, 0.03 + 0.02 * variant)
    b = saturate(apply_env(b, env_exp(p["body_len"], p["body_decay"], attack=0.002)), p["drive"])
    mix(out, b, p["body_g"])
    # 4) soco médio 250-700 Hz
    m = band(noise(p["punch_decay"] * 4, rng), 250, 700)
    mix(out, apply_env(m, env_exp(p["punch_decay"] * 4, p["punch_decay"], attack=0.001)), 3.0 * p["punch_g"])
    # 5) cauda curta (ruído grave/médio)
    c = band(noise(p["tail_len"], rng), 120, 1800, order=1)
    mix(out, apply_env(c, env_exp(p["tail_len"], p["tail_len"] / 4, attack=0.004)), p["tail_g"])
    # 6) "shing" metálico curto (forte e KO)
    if p["shing"] > 0:
        base = rng.uniform(2900, 3400)
        sh = partials(0.32, [base, base * 1.47, base * 2.09, base * 2.71],
                      [0.09, 0.07, 0.05, 0.035], [1.0, 0.7, 0.45, 0.3], rng)
        mix(out, apply_env(sh, env_exp(0.32, 1.0, attack=0.002)), p["shing"], offset=0.001)
    if kind == "ko":  # estrondo grave extra + reverberação simples
        boom = saturate(apply_env(sine_glide(0.9, 95, 38, 0.15), env_exp(0.9, 0.28, attack=0.006)), 2.0)
        mix(out, boom, 0.8, offset=0.004)
        out = _echo(out, [(0.043, 0.25), (0.071, 0.18), (0.113, 0.12)])
    return fade_out(normalize(dc_block(out), -1.0))


def _echo(xs, taps):
    out = list(xs) + [0.0] * n_samples(max(d for d, _ in taps) + 0.01)
    for d, g in taps:
        k = n_samples(d)
        lp = Biquad("lp", 3500)
        for i, v in enumerate(xs):
            out[i + k] += lp.tick(v) * g
    return out


# --------------------------------------------------------------------------
# Escudo, quebra, menu
# --------------------------------------------------------------------------

def shield_hit():
    rng = random.Random(7)
    out = []
    # bolha: seno com tom subindo rápido (três bolhinhas)
    for k, (off, f0, f1) in enumerate([(0.0, 380, 1150), (0.018, 520, 1500), (0.034, 450, 1300)]):
        n = n_samples(0.05)
        ph = 0.0
        bub = []
        for i in range(n):
            t = i / SR
            f = f0 + (f1 - f0) * (1 - math.exp(-t / 0.012))
            ph += 2 * math.pi * f / SR
            bub.append(math.sin(ph) * math.exp(-t / 0.014) * min(1.0, i / 48))
        mix(out, bub, 0.6 if k == 0 else 0.4, offset=off)
    # ping: dois parciais brilhantes
    ping = partials(0.3, [2350, 5480, 7900], [0.11, 0.05, 0.025], [1.0, 0.45, 0.2], rng)
    mix(out, apply_env(ping, env_exp(0.3, 1.0, attack=0.001)), 0.5, offset=0.004)
    # estalinho de contato
    s = band(noise(0.02, rng), 1500, 6000)
    mix(out, apply_env(s, env_exp(0.02, 0.004, attack=0.0008)), 1.2)
    return fade_out(normalize(dc_block(out), -1.0))


def shield_break():
    rng = random.Random(11)
    out = []
    # estouro: ruído largo + baque grave
    pop = band(noise(0.25, rng), 1200, 9000)
    mix(out, apply_env(pop, env_exp(0.25, 0.045, attack=0.001)), 1.6)
    crack = band(noise(0.06, rng), 700, 3000)
    mix(out, apply_env(crack, env_exp(0.06, 0.012, attack=0.001)), 2.0)
    thump = saturate(apply_env(sine_glide(0.3, 160, 60, 0.04), env_exp(0.3, 0.08, attack=0.002)), 3.0)
    mix(out, thump, 0.9)
    glass = partials(0.5, [3100, 4370, 5930, 7250], [0.16, 0.12, 0.09, 0.06], [0.6, 0.5, 0.35, 0.25], rng)
    mix(out, glass, 0.35, offset=0.01)
    # zumbido de tonto: dois tons quase iguais (batimento), vibrato e trêmolo
    dur = 1.1
    n = n_samples(dur)
    buzz = []
    ph1 = ph2 = 0.0
    for i in range(n):
        t = i / SR
        vib = 1.0 + 0.02 * math.sin(2 * math.pi * 6.0 * t)
        ph1 += 2 * math.pi * 880 * vib / SR
        ph2 += 2 * math.pi * 893 * vib / SR
        v = math.sin(ph1) + math.sin(ph2) + 0.3 * math.sin(2 * ph1)
        trem = 0.6 + 0.4 * math.sin(2 * math.pi * 9.0 * t)
        env = min(1.0, t / 0.08) * math.exp(-t / 0.45)
        buzz.append(v * trem * env)
    mix(out, buzz, 0.16, offset=0.12)
    return fade_out(normalize(dc_block(out), -1.0))


def agogo(freq, dur=0.11, bright=1.0, rng=None):
    """Toque de agogô: parciais inarmônicos de sino pequeno + ataque de batida."""
    rng = rng or random.Random(int(freq))
    ps = partials(dur, [freq, freq * 2.76, freq * 5.40, freq * 8.93],
                  [dur / 3.0, dur / 5.0, dur / 9.0, dur / 14.0],
                  [1.0, 0.55 * bright, 0.25 * bright, 0.12 * bright], rng)
    click = band(noise(0.006, rng), 2500, 9000)
    click = apply_env(click, env_exp(0.006, 0.0012, attack=0.0003))
    out = []
    mix(out, apply_env(ps, env_exp(dur, 1.0, attack=0.0008)), 1.0)
    mix(out, click, 0.6)
    return out


def menu_move():
    return fade_out(normalize(agogo(1760, 0.07, 0.8), -3.0))


def menu_confirm():
    out = []
    mix(out, agogo(1320, 0.10), 0.85)              # boca grave...
    mix(out, agogo(1760, 0.14), 1.0, offset=0.075)  # ...e boca aguda
    return fade_out(normalize(dc_block(out), -1.0))


def menu_back():
    out = []
    mix(out, agogo(1760, 0.08), 0.8)
    mix(out, agogo(1175, 0.12), 1.0, offset=0.065)
    return fade_out(normalize(dc_block(out), -2.0))


# --------------------------------------------------------------------------
# Assinaturas por personagem (tocadas 4 dB abaixo do golpe forte/especial)
# --------------------------------------------------------------------------

def berimbau():
    """Juba: corda de aço percutida com a baqueta + 'wah' da cabaça abrindo."""
    rng = random.Random(21)
    dur = 0.55
    f = 196.0
    # corda: Karplus-Strong curto, brilhante, com leve subida de tom (dobrão)
    period = SR / f
    buf = [rng.uniform(-1, 1) for _ in range(int(period))]
    out = []
    idx = 0
    prev = 0.0
    for i in range(n_samples(dur)):
        v = buf[idx]
        nv = 0.996 * (0.75 * v + 0.25 * prev)
        prev = v
        buf[idx] = nv
        out.append(v)
        idx = (idx + 1) % len(buf)
    out = saturate(out, 1.6)
    # cabaça abrindo e fechando: passa-faixa ressonante 500 -> 1800 -> 700 Hz
    half = len(out) // 2
    w = bp_sweep(out[:half], 500, 1800, 3.0, 0.7) + bp_sweep(out[half:], 1800, 700, 3.0, 1.0)
    res = []
    mix(res, w, 2.5)
    mix(res, out, 0.25)
    tap = band(noise(0.01, rng), 2000, 8000)  # baqueta batendo no arame
    mix(res, apply_env(tap, env_exp(0.01, 0.002, attack=0.0003)), 0.8)
    res = apply_env(res, env_exp(len(res) / SR, 0.25, attack=0.001))
    return fade_out(normalize(dc_block(res), -1.0), 0.03)


def apito():
    """Tucão: apito de várzea (tom ~2,9 kHz com trinado da bolinha + sopro)."""
    rng = random.Random(33)
    dur = 0.42
    out = []
    ph = 0.0
    breath = band(noise(dur, rng), 2000, 6000, order=1)
    for i in range(n_samples(dur)):
        t = i / SR
        trill = 0.5 + 0.5 * math.sin(2 * math.pi * 34.0 * t)  # bolinha rolando
        f = 2850 + 260 * trill + 80 * math.sin(2 * math.pi * 5 * t)
        ph += 2 * math.pi * f / SR
        env = min(1.0, t / 0.015) * (1.0 if t < dur - 0.08 else max(0.0, (dur - t) / 0.08))
        am = 0.75 + 0.25 * trill
        out.append((math.sin(ph) + 0.12 * math.sin(2 * ph)) * env * am + 0.08 * breath[i] * env)
    return fade_out(normalize(dc_block(out), -1.0))


def pandeiro():
    """Canga: tapa no couro + chacoalhar das platinelas."""
    rng = random.Random(45)
    out = []
    skin = saturate(apply_env(sine_glide(0.25, 240, 150, 0.03), env_exp(0.25, 0.06, attack=0.001)), 2.0)
    mix(out, skin, 0.7)
    slap = band(noise(0.04, rng), 700, 3000)
    mix(out, apply_env(slap, env_exp(0.04, 0.008, attack=0.0008)), 1.2)
    # platinelas: vários toques metálicos rápidos (chiado com parciais)
    for k, off in enumerate([0.0, 0.006, 0.013, 0.021, 0.03, 0.05, 0.075]):
        jing = partials(0.12, [6200 + 400 * k, 8100, 9800, 11800], [0.05, 0.04, 0.03, 0.02],
                        [1.0, 0.8, 0.6, 0.4], rng)
        hiss = band(noise(0.12, rng), 5000, 14000)
        j = [a * 0.5 + b * 0.8 for a, b in zip(jing, hiss)]
        j = apply_env(j, env_exp(0.12, 0.03, attack=0.0005))
        mix(out, j, 0.5 * (0.85 ** k), offset=off)
    return fade_out(normalize(dc_block(out), -1.0))


# --------------------------------------------------------------------------

def catalog():
    sounds = {}
    for kind in ("leve", "medio", "forte", "ko"):
        for v in (1, 2, 3):
            sounds["golpe_%s_%d" % (kind, v)] = lambda k=kind, v=v: hit(k, v)
    sounds["escudo_bolha"] = shield_hit
    sounds["escudo_quebra"] = shield_break
    sounds["menu_mover"] = menu_move
    sounds["menu_confirmar"] = menu_confirm
    sounds["menu_voltar"] = menu_back
    sounds["assinatura_berimbau"] = berimbau
    sounds["assinatura_apito"] = apito
    sounds["assinatura_pandeiro"] = pandeiro
    return sounds


def main():
    ap = argparse.ArgumentParser(description=__doc__.split("\n")[0])
    ap.add_argument("--ffmpeg", default=os.environ.get("FFMPEG", FFMPEG_DEFAULT))
    ap.add_argument("--wav-dir", default=os.path.join(os.environ.get("TMPDIR", ROOT), "sj_sintese"))
    ap.add_argument("--so-wav", action="store_true", help="não converte para .ogg")
    ap.add_argument("nomes", nargs="*", help="só estes sons (padrão: todos)")
    args = ap.parse_args()
    os.makedirs(args.wav_dir, exist_ok=True)
    for name, fn in catalog().items():
        if args.nomes and name not in args.nomes:
            continue
        xs = fn()
        wav = os.path.join(args.wav_dir, name + ".wav")
        write_wav(wav, xs)
        msg = "%-22s %5.0f ms" % (name, 1000 * len(xs) / SR)
        if not args.so_wav:
            ogg = os.path.join(OUT_DIR, name + ".ogg")
            subprocess.run([args.ffmpeg, "-y", "-loglevel", "error", "-i", wav, "-c:a", "libvorbis",
                            "-q:a", "6", "-ar", str(SR), "-ac", "1", ogg], check=True)
            msg += " -> " + os.path.relpath(ogg, ROOT)
        print(msg)


if __name__ == "__main__":
    main()
