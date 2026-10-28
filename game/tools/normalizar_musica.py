#!/usr/bin/env python
"""Normaliza uma música com o loudnorm do ffmpeg em 2 passadas (EBU R128).

Alvo: -14 LUFS integrado, pico verdadeiro < -1 dBTP, mesma duração (sem cortar
nem esticar: o loop e o bpm/beat_count do .import continuam valendo).

Uso (da raiz do repositório):
    python game/tools/normalizar_musica.py ORIGEM.ogg DESTINO.ogg [--ffmpeg CAMINHO]
"""
import argparse
import json
import os
import re
import subprocess

FFMPEG_DEFAULT = "C:/Users/jpach/AppData/Local/hermes/tools/ffmpeg-9.0.1-win32-x64/bin/ffmpeg.exe"
TARGET = "I=-14:TP=-1.5:LRA=11"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("origem")
    ap.add_argument("destino")
    ap.add_argument("--ffmpeg", default=os.environ.get("FFMPEG", FFMPEG_DEFAULT))
    a = ap.parse_args()
    r = subprocess.run([a.ffmpeg, "-hide_banner", "-nostats", "-i", a.origem, "-af",
                        "loudnorm=%s:print_format=json" % TARGET, "-f", "null", "-"],
                       capture_output=True, text=True, errors="replace")
    m = json.loads(re.search(r"\{[^{}]*\"input_i\"[^{}]*\}", r.stderr).group(0))
    second = ("loudnorm=%s:measured_I=%s:measured_TP=%s:measured_LRA=%s:measured_thresh=%s:offset=%s:linear=true"
              % (TARGET, m["input_i"], m["input_tp"], m["input_lra"], m["input_thresh"], m["target_offset"]))
    subprocess.run([a.ffmpeg, "-y", "-loglevel", "error", "-i", a.origem, "-af", second + ",aresample=44100",
                    "-c:a", "libvorbis", "-q:a", "7", a.destino], check=True)
    print("1a passada: %s LUFS, %s dBTP -> %s" % (m["input_i"], m["input_tp"], a.destino))


if __name__ == "__main__":
    main()
