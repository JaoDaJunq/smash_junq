# Calango · todos os pedidos (rodada 10)

Concept escolhido: `art/concepts/calango/escolhido.png`. Ficha: `design/personagens/calango.md`. Tudo em `art/pixel/calango/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (PARE e espere o ok) → 1 lote 1 → 2 lote 2 → 4 interface. O lote 3 (intermediários) NÃO é pedido nesta rodada.

Anexe em todo pedido: `art/concepts/calango/escolhido.png`, `art/pixel/calango/base.png`, `art/pixel/calango/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: em guarda inclinado para a frente, pronto para correr, cauda comprida esticada para trás, chapéu de palha, de perfil para a direita. Personagem com cerca de 46 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 4 quadros.
Animação: Inquieto no lugar (loop)
Quadros:
1) guarda, cauda ondulando · 2) olha para os lados · 3) balança o corpo · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `andar.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Andar malandro (loop)
Quadros:
1) a 6) passos gingados, chinelo arrastando, cauda balançando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `correr.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `dor.png` (4 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `jab.png` (3 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 3 quadros.
Animação: Ataque básico 1: tapa rápido
Quadros:
1) mão recolhida · 2) tapa à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 3 quadros.
Animação: Ataque básico 2: outro tapa
Quadros:
1) outra mão recolhida · 2) tapa · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 4 quadros.
Animação: Ataque básico 3: chinelada
Quadros:
1) tira o chinelo · 2) erguendo · 3) impacto: bate com o chinelo à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Isoporada
Quadros:
1) puxa o isopor para trás · 2) girando · 3) impacto: bate com o isopor à frente · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Rabada para cima
Quadros:
1) vira um pouco · 2) cauda subindo · 3) impacto: cauda comprida em arco acima da cabeça · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Rabada rasteira
Quadros:
1) agacha · 2) cauda varrendo · 3) impacto: cauda rente ao chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Giro de cauda
Quadros:
1) encolhido · 2) girando · 3) impacto: cauda aberta em roda · 4) terminando · 5) encolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Chute voador
Quadros:
1) perna para trás · 2) vindo · 3) impacto: pé à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Chicote de cauda para trás
Quadros:
1) olhando para trás · 2) cauda recolhida · 3) impacto: cauda estalando para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Chapéu para cima
Quadros:
1) mão no chapéu · 2) subindo · 3) impacto: chapéu erguido para cima · 4) recolocando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 5 quadros.
Animação: Pisão de chinelo
Quadros:
1) encolhido · 2) pés para baixo · 3) impacto: os dois pés juntos para baixo · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Joga areia
Quadros:
1) agacha pegando areia · 2) mão cheia · 3) braço para trás · 4) impacto: jogando à frente, mão aberta (a areia NÃO aparece) · 5) voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Corrida de calango
Quadros:
1) agacha · 2) levanta as mãos do chão · 3) impacto: correndo em pé nas pernas de trás, corpo inclinado para trás, cauda esticada · 4) outra passada · 5) freando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Salto de lagartixa
Quadros:
1) agacha colado · 2) impulso · 3) impacto: subindo esticado, braços para cima · 4) subindo girando · 5) topo · 6) abrindo braços e cauda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 6 quadros.
Animação: Tomar sol
Quadros:
1) tira o chapéu · 2) deita de barriga para cima apoiado nos cotovelos · 3) relaxando de olhos fechados · 4) impacto: espreguiça satisfeito · 5) levanta · 6) põe o chapéu e fica em guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `sem_rabo.png` (4 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 4 quadros.
Animação: Correndo sem rabo (loop)
Quadros:
IGUAL à corrida, mas SEM a cauda (só um toquinho), cara assustada olhando para trás: 1) a 4) passadas

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `rabo.png` (2 quadros)

```text
Folha de animação, 2 quadros.
Animação: Rabo solto (sprite separado, só a cauda)
Quadros:
só a cauda solta do Calango no chão, uns 30 pixels: 1) curvada para um lado · 2) para o outro

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 2 quadros.
Animação: Pendurado pelas mãos
Quadros:
1) pendurado pelas duas mãos no alto do quadro (à direita), cauda pendendo · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 4 quadros.
Animação: Chupando picolé (loop)
Quadros:
1) picolé na mão · 2) lambendo · 3) olhos fechados satisfeito · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) oferecendo um picolé gritando · 2) girando o chapéu · 3) pose final: joinha com sorriso malandro

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 46 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Calango (use só estas cores):
contorno #2A0F12
escamas: luz #A8A84A, base #8A8A3A, sombra #5E5E22
pintas: #E8E0B0
barriga: luz #F0E0A0, base #E8D48A, sombra #BFA860
chapéu: luz #E8C878, base #C9A050, sombra #8A6A2E
regata: #FAF6EE, sombra #D9D2C2
bermuda: azul #2D6FC4, flores #F08A1A, folhas #4CAF50
isopor: #FAF6EE, faixa #D7262E
chinelo: #1A1A1A, tira #F08A1A
olhos: #F2B830, pupila #1A1008
```

## Interface (`art/ui/`)

### `retrato_calango.png`

```text
Retrato em pixel art (busto) do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo. Virado em 3/4 olhando para a direita, sorriso malandro de canto, chapéu de palha. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_calango.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Calango: calango (lagarto do sertão) humanizado, VENDEDOR AMBULANTE de praia magrelo e ágil (concept escolhido anexado): escamas verde-oliva com pintas creme, barriga amarelada, cabeça triangular com olhos amarelos espertos, dedos compridos, cauda MUITO comprida e fina com pintas; chapéu de palha largo, regata branca, bermuda azul com flores laranja, chinelo, isopor branco com faixa vermelha a tiracolo, IGUAL ao concept anexado. Pose: oferecendo um picolé à frente com sorriso malandro, isopor a tiracolo, cauda comprida enrolada no chão. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
