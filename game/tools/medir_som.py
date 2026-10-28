#!/usr/bin/env python
"""Mede, com o ffmpeg, a energia na faixa 1-4 kHz (onde o alto-falante de celular
e notebook ainda toca) dos sons de golpe e das músicas de luta.

Uso (da raiz do repositório):
    python game/tools/medir_som.py [--ffmpeg CAMINHO] [--janela 0.15] ARQUIVO...

Para cada arquivo imprime (todos em dBFS, volumedetect do ffmpeg):
  total_med   = mean_volume do sinal inteiro (na janela)
  banda_med   = mean_volume depois do filtro 1-4 kHz
  banda-total = quanto da energia está em 1-4 kHz (com o mesmo volume total)
  pico_ms     = tempo até o pico (ataque)
Filtro da banda: highpass=f=1000 (2x) + lowpass=f=4000 (2x), 12 dB/oitava cada.
Golpes são medidos só na janela inicial (--janela s), onde o som acontece;
músicas (arquivos com mais de 5 s) inteiras.
"""
import argparse
import array
import os
import re
import subprocess
import sys

FFMPEG_DEFAULT = "C:/Users/jpach/AppData/Local/hermes/tools/ffmpeg-9.0.1-win32-x64/bin/ffmpeg.exe"
BAND = "highpass=f=1000,highpass=f=1000,lowpass=f=4000,lowpass=f=4000"


def volumedetect(ff, path, filt, trim):
    chain = ("atrim=0:%g," % trim if trim else "") + (filt + "," if filt else "") + "volumedetect"
    r = subprocess.run([ff, "-hide_banner", "-nostats", "-i", path, "-af", chain, "-f", "null", "-"],
                       capture_output=True, text=True, errors="replace")
    mean = re.search(r"mean_volume: (-?[\d.]+|-inf) dB", r.stderr)
    mx = re.search(r"max_volume: (-?[\d.]+|-inf) dB", r.stderr)
    return float(mean.group(1)), float(mx.group(1))


def pcm(ff, path):
    r = subprocess.run([ff, "-hide_banner", "-loglevel", "error", "-i", path, "-ac", "1", "-ar", "48000",
                        "-f", "s16le", "-"], capture_output=True)
    a = array.array("h")
    a.frombytes(r.stdout[: len(r.stdout) // 2 * 2])
    if sys.byteorder != "little":
        a.byteswap()
    return a


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("--ffmpeg", default=os.environ.get("FFMPEG", FFMPEG_DEFAULT))
    ap.add_argument("--janela", type=float, default=0.15)
    ap.add_argument("arquivos", nargs="+")
    args = ap.parse_args()
    print("%-34s %9s %9s %11s %8s" % ("arquivo", "total_med", "banda_med", "banda-total", "pico_ms"))
    for f in args.arquivos:
        a = pcm(args.ffmpeg, f)
        dur = len(a) / 48000.0
        trim = args.janela if dur < 5.0 else 0.0
        tm, _ = volumedetect(args.ffmpeg, f, "", trim)
        bm, _ = volumedetect(args.ffmpeg, f, BAND, trim)
        pk = "-"
        if dur < 5.0 and len(a):
            i = max(range(len(a)), key=lambda k: abs(a[k]))
            pk = "%.1f" % (1000.0 * i / 48000.0)
        print("%-34s %9.1f %9.1f %11.1f %8s" % (os.path.basename(f), tm, bm, bm - tm, pk))


if __name__ == "__main__":
    main()
