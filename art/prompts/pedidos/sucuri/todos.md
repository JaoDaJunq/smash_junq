# Mestra Sucuri · todos os pedidos (rodada 7)

Concept escolhido: `art/concepts/sucuri/escolhido.png`. Ficha: `design/personagens/sucuri.md`. Tudo em `art/pixel/sucuri/` (interface em `art/ui/`).

**Ordem:** 0 base → 1 lote 1 → 2 lote 2 → 3 lote 3 → 4 interface.

Anexe em todo pedido: `art/concepts/sucuri/escolhido.png`, `art/pixel/sucuri/base.png`, `art/pixel/sucuri/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: em guarda de jiu-jitsu, mãos abertas à frente, cauda enrolada em espiral no chão sustentando o corpo, de perfil para a direita. Personagem com cerca de 50 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Guarda balançando (loop)
Quadros:
1) guarda, cauda enrolada · 2) corpo sobe um pouco ondulando · 3) inclina à frente · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `andar.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Deslizando (loop)
Quadros:
Ela NÃO tem pernas: desliza com a cauda em ondas. 1) onda da cauda atrás · 2) onda no meio · 3) onda à frente · 4) cauda esticada · 5) nova onda atrás · 6) onda no meio. Tronco firme em guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `correr.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Deslizando rápido (loop)
Quadros:
Sem pernas: tronco inclinado para a frente, cauda em ondas mais longas e rápidas. 1) a 6) ciclo de ondas

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Pulo de mola
Quadros:
1) cauda enrolada como mola · 2) mola soltando · 3) subindo, cauda esticada para baixo · 4) topo, cauda em S · 5) caindo · 6) pousa enrolando a cauda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) braços cruzados na frente do rosto, cauda enrolada em volta · 2) mesma pose. ESQUIVA: 3) se jogando de lado · 4) rolando enrolada como uma roda · 5) desenrolando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `dor.png` (4 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `jab.png` (3 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 3 quadros.
Animação: Ataque básico 1: palma de mão
Quadros:
1) mão recolhida · 2) palma aberta à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 3 quadros.
Animação: Ataque básico 2: outra palma
Quadros:
1) outra mão recolhida · 2) palma à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Ataque básico 3: chicotada curta de cauda
Quadros:
1) gira o tronco · 2) ponta da cauda vem por trás · 3) impacto: ponta da cauda estalando à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Bote (cabeçada esticando o corpo)
Quadros:
1) recua o tronco · 2) avançando · 3) impacto: corpo esticado bem à frente, cabeça na frente · 4) recolhendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Agarrão: enrola o adversário com a cauda
Quadros:
1) estica as mãos · 2) segurando algo invisível · 3) cauda subindo em volta do invisível · 4) apertando com a cauda · 5) girando e soltando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Cauda em pé
Quadros:
1) cauda abaixa · 2) ponta subindo · 3) impacto: ponta da cauda esticada acima da cabeça · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Rasteira de cauda
Quadros:
1) tronco abaixa · 2) cauda varrendo · 3) impacto: cauda esticada rente ao chão à frente · 4) recolhendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Giro enrolada no ar
Quadros:
1) enrolando · 2) girando · 3) impacto: enrolada como roda, cauda para fora · 4) desenrolando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Bote no ar
Quadros:
1) recua · 2) avançando · 3) impacto: corpo esticado à frente, boca aberta · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Chicotada de cauda para trás
Quadros:
1) olhando para trás · 2) cauda vindo · 3) impacto: cauda estalando para TRÁS (esquerda) · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Mordida para cima
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: cabeça para cima, boca aberta · 4) descendo · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Cai enrolada como mola
Quadros:
1) enrolando · 2) mola apontando para baixo · 3) impacto: mola esticada para baixo · 4) quicando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Hipnose (olhar fixo)
Quadros:
1) mãos se juntando · 2) mãos em frente ao rosto · 3) inclinando à frente · 4) impacto: olhar fixo à frente, mãos abertas ao lado do rosto, corpo ondulando · 5) mantendo · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Laço de cauda (estica e puxa)
Quadros:
1) gira o tronco · 2) cauda lançada à frente · 3) impacto: cauda esticada longe à frente, ponta enrolada em laço · 4) puxando de volta · 5) cauda voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Mola (enrola e sobe)
Quadros:
1) enrolando bem apertado · 2) mola comprimida · 3) impacto: soltando, corpo esticado para cima · 4) subindo esticada · 5) topo · 6) enrolando de novo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Abraço de sucuri (espiral armadilha)
Quadros:
1) começa a enrolar · 2) espiral subindo pelo corpo · 3) espiral fechada, só a cabeça para fora · 4) impacto: espiral apertando, braços abertos para agarrar · 5) mantendo · 6) desenrolando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 2 quadros.
Animação: Pendurada pela ponta da cauda
Quadros:
1) a ponta da cauda enrolada no alto do quadro (à direita), corpo de cabeça para baixo, braços cruzados · 2) balançando de leve. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Enrolada cochilando (loop)
Quadros:
1) enrolada em espiral, cabeça apoiada na cauda, olhos fechados · 2) corpo sobe respirando · 3) desce · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) ajeita a faixa · 2) mãos em meditação, cauda enrolada · 3) pose final: sorriso de olhos fechados segurando uma xícara de chá

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

## Lote 3 · intermediários (`<animacao>_meio.png`)

Para cada folha abaixo: os quadros INTERMEDIÁRIOS da folha principal (anexe-a). Cada quadro é a pose exatamente no meio entre dois quadros vizinhos (1 entre o 1º e o 2º, 2 entre o 2º e o 3º...; nos loops parado/andar/correr/tonto, o último fica entre o último e o primeiro). Mesmo lugar e mesma escala da folha principal. EXATAMENTE este número de quadros:

- `parado_meio.png`: 4
- `andar_meio.png`: 6
- `correr_meio.png`: 6
- `pulo_meio.png`: 5
- `golpe_frente_meio.png`: 4
- `golpe_cima_meio.png`: 4
- `golpe_baixo_meio.png`: 4
- `aereo_neutro_meio.png`: 4
- `aereo_frente_meio.png`: 4
- `aereo_tras_meio.png`: 4
- `aereo_cima_meio.png`: 4
- `aereo_baixo_meio.png`: 4
- `especial_neutro_meio.png`: 5
- `especial_lado_meio.png`: 5
- `especial_cima_meio.png`: 5
- `especial_baixo_meio.png`: 5
- `dor_meio.png`: 3
- `tonto_meio.png`: 4

Mesmas regras de imagem das outras folhas:

```text
Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

## Interface (`art/ui/`)

### `retrato_sucuri.png`

```text
Retrato em pixel art (busto) do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura. Virado em 3/4 olhando para a direita, sorriso calmo de olhos semicerrados. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_sucuri.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, IGUAL ao concept anexado. Pose: em guarda de jiu-jitsu, uma mão à frente, cauda enrolada em espiral elegante, sorriso calmo. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
