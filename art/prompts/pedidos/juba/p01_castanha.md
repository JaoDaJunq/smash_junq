# Juba · projétil: castanha

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Decisão do João: o projétil do especial neutro do Juba é uma castanha. Hoje o jogo desenha uma bolinha provisória (`projectile.gd`). Todo objeto lançado tem sprite próprio (regra do playtest 01).

## Anexar (sempre, nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg` (folha aprovada)
2. `art/pixel/juba/parado.png` (régua de tamanho)
3. `art/pixel/juba/especial_neutro.png` (a castanha na mão, quadros 1 a 3, para combinar)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/castanha_v1.png` (4 quadros)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

4 quadros, células 1 a 4; células 5 e 6 vazias. A castanha fica centralizada na célula.

## Prompt

```text
Sprite de OBJETO em pixel art para um jogo de luta 2D: uma castanha-do-pará com casca, arremessada girando no ar, 4 quadros.
Imagem 1536x1024, grade 3 colunas x 2 linhas, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Fundo magenta chapado #FF00FF. Sem anti-aliasing, sem borrado, sem degradê. Contorno de 1 pixel #3A0A0A. Sem texto, números, grade ou moldura. Células 5 e 6 vazias.
A castanha é PEQUENA: cerca de 12 x 10 pixels, centralizada na célula, na mesma escala do personagem anexado (ela cabe na mão dele). Formato de gomo de castanha-do-pará, casca marrom com rugas.
Cores (use só estas): marrom claro #CC7744, marrom #AA5522, marrom escuro #7A3A1A, brilho #FFC42A (no máximo 2 pixels), contorno #3A0A0A.
Quadros (girando, sem linhas de movimento nem rastro):
1) castanha de pé
2) girada 90 graus
3) girada 180 graus
4) girada 270 graus
```

## Conferência (Claude Code, antes de integrar)

- [ ] Castanha do mesmo tamanho da que está na mão do Juba no `especial_neutro`.
- [ ] Gira em 4 quadros sem mudar de tamanho; sem rastro.
- [ ] Fundo magenta liso.

## Nota para a integração

Trocar o desenho provisório de `projectile.gd` (círculo) pelo sprite girando, só no projétil do Juba. Já tem linha de pedido no `assets/manifest.csv` (`char_juba_pixel_castanha_v1`); atualizar o estado na integração.
