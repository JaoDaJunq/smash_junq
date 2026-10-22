# Seu Preguiçoso · todos os pedidos (rodada 10)

Concept escolhido: `art/concepts/preguica/escolhido.png`. Ficha: `design/personagens/preguica.md`. Tudo em `art/pixel/preguica/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (PARE e espere o ok) → 1 lote 1 → 2 lote 2 → 4 interface. O lote 3 (intermediários) NÃO é pedido nesta rodada.

Anexe em todo pedido: `art/concepts/preguica/escolhido.png`, `art/pixel/preguica/base.png`, `art/pixel/preguica/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: em pé curvado e lento, prancheta debaixo do braço, garras à mostra, olhos meio fechados, de perfil para a direita. Personagem com cerca de 52 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 4 quadros.
Animação: Cochilando em pé (loop)
Quadros:
1) guarda, olhos meio fechados · 2) cabeça cai um pouco · 3) acorda num susto leve · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `andar.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Andar lentíssimo (loop)
Quadros:
1) a 6) passos arrastados e curvados, braços compridos pendendo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `correr.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `dor.png` (4 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `jab.png` (3 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 3 quadros.
Animação: Ataque básico 1: garrada lenta
Quadros:
1) braço recolhido · 2) garras à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 3 quadros.
Animação: Ataque básico 2: outra garrada
Quadros:
1) outro braço recolhido · 2) garras à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 4 quadros.
Animação: Ataque básico 3: pranchetada
Quadros:
1) prancheta para trás · 2) avançando · 3) impacto: bate com a prancheta à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Braçada de três garras
Quadros:
1) braço erguido atrás · 2) descendo devagar · 3) impacto: braço comprido esticado à frente, garras abertas · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Espreguiçada para cima
Quadros:
1) encolhe · 2) braços subindo · 3) impacto: espreguiçando com os braços e garras bem para cima · 4) baixando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Garrada rasteira
Quadros:
1) agacha · 2) braço varrendo · 3) impacto: garras rente ao chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Giro preguiçoso
Quadros:
1) encolhido · 2) girando · 3) impacto: braços abertos com garras · 4) terminando · 5) encolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Garrada no ar
Quadros:
1) braço para trás · 2) vindo · 3) impacto: garras à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Cotovelada para trás
Quadros:
1) olhando para trás · 2) braço recolhido · 3) impacto: cotovelo para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Garras para cima
Quadros:
1) braços baixos · 2) subindo · 3) impacto: garras esticadas para cima · 4) baixando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 5 quadros.
Animação: Barrigada para baixo
Quadros:
1) encolhido · 2) virando de barriga para baixo · 3) impacto: barriga e braços abertos para baixo · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Bolha de moleza
Quadros:
1) boceja enorme · 2) braços abrindo devagar · 3) mãos à frente · 4) impacto: braços abertos à frente, olhos fechados (a bolha NÃO aparece) · 5) baixando · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Abraço lento
Quadros:
1) braços abertos para trás · 2) inclinando à frente · 3) braços vindo · 4) impacto: braços compridos fechando à frente num abraço · 5) puxando para si · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Pendura no galho
Quadros:
1) olha para cima · 2) estica um braço para o alto · 3) impacto: pendurado por uma garra acima da cabeça, subindo · 4) outra garra subindo · 5) topo · 6) solta e abre os braços

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 6 quadros.
Animação: Cochilo
Quadros:
1) boceja · 2) senta no chão · 3) deita de lado · 4) impacto: dormindo de olhos fechados, sorrindo · 5) acordando · 6) levanta em guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 2 quadros.
Animação: Pendurado pelas garras (é o forte dele)
Quadros:
1) pendurado de ponta-cabeça pelas garras dos pés no alto do quadro (à direita) · 2) balançando calmo. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 4 quadros.
Animação: Tomando café (loop)
Quadros:
1) garrafa térmica na mão · 2) bebendo devagar · 3) suspirando · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) bocejo enorme · 2) carimbando a prancheta · 3) pose final: dorme em pé sorrindo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 52 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Preguiçoso (use só estas cores):
contorno #2A0F12
pelo: luz #B0A080, base #8A7A62, sombra #5E5040
rosto: creme #D9C9A8
máscara e focinho: #3A2E22
garras: #EDE0C0, sombra #BFAE88
camisa: luz #F0E2C0, base #E0CCA0, sombra #B8A478
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
botina e prancheta: #7A4A22, sombra #4A2A12
crachá: #FAF6EE, cordão #3A5A8A
olhos: #1A1008
```

## Interface (`art/ui/`)

### `retrato_preguica.png`

```text
Retrato em pixel art (busto) do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta. Virado em 3/4 olhando para a direita, bocejando de olhos meio fechados, sorriso preguiçoso. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_preguica.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Seu Preguiçoso: bicho-preguiça-de-três-dedos humanizado, FISCAL da prefeitura gordinho e sonolento (concept escolhido anexado): pelo marrom-acinzentado desgrenhado, máscara escura em volta dos olhos, focinho escuro pequeno, olhos sempre meio fechados, braços compridos com três garras grandes creme; camisa bege de manga curta com bolso, crachá no pescoço, cinto, calça verde-oliva, botina marrom, prancheta, IGUAL ao concept anexado. Pose: anotando na prancheta bem devagar e bocejando, uma garra erguida, crachá no pescoço. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
