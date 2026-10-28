#!/usr/bin/env python
"""Mede, numa gravação da partida (mp4/avi/wav), quanto os golpes sobressaem da
música na faixa 1-4 kHz (alto-falante de celular).

Envelope: RMS em janelas de 20 ms do sinal filtrado 1-4 kHz (highpass 1000 x2 +
lowpass 4000 x2, ffmpeg). "música" = mediana das janelas (o fundo que toca o
tempo todo); "golpes" = picos locais acima de mediana + 6 dB, separados por
>= 150 ms. Imprime cada pico (tempo e dB acima da música) e a média/mediana.

Uso: python game/tools/medir_gravacao.py evidence/som/partida.mp4 [--de 4.0]
  --de S: ignora os primeiros S segundos (contagem "3, 2, 1, LUTEM!").

Modo exato (--musica): grave a MESMA partida duas vezes com o Movie Maker
(--fixed-fps 60, mesmas sementes; é determinística), uma normal e outra com o
volume de efeitos em 0. Os efeitos = normal - só_música (amostra a amostra).
Para cada golpe (pico do envelope dos efeitos) compara com a música no mesmo
instante (já com o sidechain/abaixada agindo, como no jogo):
    python game/tools/medir_gravacao.py partida.avi --musica partida_so_musica.avi
"""
import argparse
import array
import math
import os
import statistics
import subprocess
import sys

FFMPEG_DEFAULT = "C:/Users/jpach/AppData/Local/hermes/tools/ffmpeg-9.0.1-win32-x64/bin/ffmpeg.exe"
BAND = "highpass=f=1000,highpass=f=1000,lowpass=f=4000,lowpass=f=4000"
SR = 48000
WIN = 0.020


def pcm(ff, path, filt):
    cmd = [ff, "-hide_banner", "-loglevel", "error", "-i", path, "-vn", "-ac", "1", "-ar", str(SR)]
    if filt:
        cmd += ["-af", filt]
    r = subprocess.run(cmd + ["-f", "s16le", "-"], capture_output=True)
    a = array.array("h")
    a.frombytes(r.stdout[: len(r.stdout) // 2 * 2])
    if sys.byteorder != "little":
        a.byteswap()
    return a


def envelope(a):
    n = int(WIN * SR)
    out = []
    for i in range(0, len(a) - n, n):
        s = sum(v * v for v in a[i:i + n]) / n
        out.append(10 * math.log10(s / (32768.0 ** 2) + 1e-12))
    return out


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("arquivo")
    ap.add_argument("--de", type=float, default=4.0)
    ap.add_argument("--musica", help="mesma gravação com efeitos em 0 (modo exato)")
    ap.add_argument("--ffmpeg", default=os.environ.get("FFMPEG", FFMPEG_DEFAULT))
    args = ap.parse_args()
    if args.musica:
        exato(args)
        return
    env = envelope(pcm(args.ffmpeg, args.arquivo, BAND))
    start = int(args.de / WIN)
    body = env[start:]
    floor = statistics.median(body)
    peaks = []
    gap = int(0.15 / WIN)
    for i in range(start + 1, len(env) - 1):
        v = env[i]
        if v >= floor + 6.0 and v >= env[i - 1] and v >= env[i + 1]:
            if peaks and i - peaks[-1][0] < gap:
                if v > peaks[-1][1]:
                    peaks[-1] = (i, v)
                continue
            peaks.append((i, v))
    print("%s: musica (mediana 1-4 kHz, janelas de 20 ms) = %.1f dBFS; %d picos de golpe"
          % (os.path.basename(args.arquivo), floor, len(peaks)))
    for i, v in peaks:
        print("  t=%6.2f s  %.1f dBFS  (+%.1f dB sobre a musica)" % (i * WIN, v, v - floor))
    if peaks:
        d = [v - floor for _, v in peaks]
        print("golpe - musica em 1-4 kHz: media +%.1f dB, mediana +%.1f dB, max +%.1f dB"
              % (statistics.mean(d), statistics.median(d), max(d)))


def exato(args):
    full = pcm(args.ffmpeg, args.arquivo, BAND)
    mus = pcm(args.ffmpeg, args.musica, BAND)
    n = min(len(full), len(mus))
    fx = array.array("h", (max(-32768, min(32767, full[i] - mus[i])) for i in range(n)))
    env_fx = envelope(fx)
    env_mu = envelope(mus[:n])
    start = int(args.de / WIN)
    gap = int(0.15 / WIN)
    peaks = []
    for i in range(start + 1, len(env_fx) - 1):
        v = env_fx[i]
        if v >= -60.0 and v >= env_fx[i - 1] and v >= env_fx[i + 1]:
            if peaks and i - peaks[-1] < gap:
                if v > env_fx[peaks[-1]]:
                    peaks[-1] = i
                continue
            peaks.append(i)
    quiet = sorted(env_fx[start:])[len(env_fx[start:]) // 10]
    print("%s (efeitos = normal - so musica): residuo 10%% mais quieto = %.1f dBFS; musica mediana = %.1f dBFS"
          % (os.path.basename(args.arquivo), quiet, statistics.median(env_mu[start:])))
    d = []
    for i in peaks:
        d.append(env_fx[i] - env_mu[i])
        print("  t=%6.2f s  efeitos %.1f dBFS  musica %.1f dBFS  (%+.1f dB)" % (i * WIN, env_fx[i], env_mu[i], d[-1]))
    if d:
        print("golpe - musica em 1-4 kHz (%d golpes): media %+.1f dB, mediana %+.1f dB, min %+.1f, max %+.1f"
              % (len(d), statistics.mean(d), statistics.median(d), min(d), max(d)))


if __name__ == "__main__":
    main()
