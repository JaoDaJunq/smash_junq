# Tucão · todos os pedidos (rodada 10)

Concept escolhido: `art/concepts/tucano/escolhido.png`. Ficha: `design/personagens/tucano.md`. Tudo em `art/pixel/tucano/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (PARE e espere o ok) → 1 lote 1 → 2 lote 2 → 4 interface. O lote 3 (intermediários) NÃO é pedido nesta rodada.

Anexe em todo pedido: `art/concepts/tucano/escolhido.png`, `art/pixel/tucano/base.png`, `art/pixel/tucano/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: em guarda de peito estufado, bico apontado à frente, asas meio abertas como punhos, de perfil para a direita. Personagem com cerca de 50 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 4 quadros.
Animação: Guarda balançando o bico (loop)
Quadros:
1) guarda, bico à frente · 2) sobe um pouco · 3) bico inclina · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `andar.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Andar gingado de pipoqueiro (loop)
Quadros:
1) a 6) passos de pé de pato, barriga balançando, asas acompanhando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `correr.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `dor.png` (4 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `jab.png` (3 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 3 quadros.
Animação: Ataque básico 1: tapa de asa
Quadros:
1) asa recolhida · 2) tapa à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 3 quadros.
Animação: Ataque básico 2: outro tapa
Quadros:
1) outra asa recolhida · 2) tapa · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 4 quadros.
Animação: Ataque básico 3: bicada
Quadros:
1) bico para trás · 2) avançando · 3) impacto: bico esticado à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Bicada forte
Quadros:
1) cabeça para trás · 2) corpo avança · 3) impacto: bico enorme esticado à frente, corpo inclinado · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Bicada para cima
Quadros:
1) agacha · 2) cabeça subindo · 3) impacto: bico apontado para o alto · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Rasteira de pé de pato
Quadros:
1) agacha · 2) pé varrendo · 3) impacto: pé esticado rente ao chão · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Giro de asas
Quadros:
1) encolhido · 2) girando · 3) impacto: asas abertas em roda · 4) terminando · 5) encolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Bicada no ar
Quadros:
1) bico para trás · 2) avançando · 3) impacto: bico à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Rabada para trás
Quadros:
1) olhando para trás · 2) virando · 3) impacto: penas do rabo batendo para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Bico para cima no ar
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: bico apontado para cima · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 5 quadros.
Animação: Bico para baixo no ar
Quadros:
1) encolhido · 2) virando o bico para baixo · 3) impacto: bico apontado para baixo · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Punhado de pipoca
Quadros:
1) enfia a asa no avental · 2) puxa um punhado · 3) braço para trás · 4) impacto: arremessando à frente, asa aberta (a pipoca NÃO aparece) · 5) voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Bicada investida
Quadros:
1) agacha, bico para trás · 2) impulso · 3) impacto: corpo todo esticado na horizontal, bico à frente · 4) deslizando · 5) freando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Voo de bico
Quadros:
1) agacha · 2) asas batendo · 3) impacto: subindo de bico para cima, asas abertas · 4) subindo · 5) topo · 6) asas abertas planando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 6 quadros.
Animação: Bicada pilão
Quadros:
1) salta um pouco · 2) virando de bico para baixo · 3) descendo · 4) impacto: bico cravado no chão, corpo de ponta-cabeça · 5) puxando o bico · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 2 quadros.
Animação: Pendurado pelo bico
Quadros:
1) pendurado pela ponta do bico no alto do quadro (à direita) · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 4 quadros.
Animação: Comendo pipoca (loop)
Quadros:
1) saquinho na asa · 2) joga uma pipoca para o alto · 3) pega com o bico · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) bico aberto gritando gol, asas para cima · 2) jogando pipoca para o alto · 3) pose final: tira o chapéu de papel e agradece

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

### `pipoca.png` (2 quadros)

```text
Folha de animação, 2 quadros.
Animação: Projétil: pipoca (sprite separado, sem personagem)
Quadros:
uma pipoca branca-creme estourada com contorno, de uns 10 pixels, centralizada: 1) normal · 2) girada

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Tucão (use só estas cores):
contorno #2A0F12
penas: luz #3A3A40, base #1E1E22, sombra #0E0E10
peito: creme #F5F0E6, sombra #D4CCBA
bico: luz #FFB04A, base #F08A1A, sombra #B85E10, ponta #1E1E22
pele do olho: #3FA0E0
pernas e pés: luz #5A7AC8, base #3A5AA8
avental: vermelho #D7262E, branco #FAF6EE
chapéu e camisa: #FAF6EE, sombra #D9D2C2
olhos: #8A4A1A, pupila #1A1008
```

## Interface (`art/ui/`)

### `retrato_tucano.png`

```text
Retrato em pixel art (busto) do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco. Virado em 3/4 olhando para a direita, bico aberto num sorriso enorme, olho brilhando. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_tucano.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Tucão: tucano-toco humanizado, PIPOQUEIRO de estádio barrigudo (concept escolhido anexado): penas pretas, peito branco-creme, bico ENORME laranja com ponta preta, pele azul em volta do olho, asas pretas que fazem de braços, pernas e pés azuis; chapéu de papel branco, camisa branca, avental listrado vermelho e branco, IGUAL ao concept anexado. Pose: jogando pipoca para o alto e pegando com o bico, uma asa erguida, avental listrado. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
