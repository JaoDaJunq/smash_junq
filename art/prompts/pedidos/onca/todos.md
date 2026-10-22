# Dona Onça · todos os pedidos (rodada 10)

Concept escolhido: `art/concepts/onca/escolhido.png`. Ficha: `design/personagens/onca.md`. Tudo em `art/pixel/onca/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (PARE e espere o ok) → 1 lote 1 → 2 lote 2 → 4 interface. O lote 3 (intermediários) NÃO é pedido nesta rodada.

Anexe em todo pedido: `art/concepts/onca/escolhido.png`, `art/pixel/onca/base.png`, `art/pixel/onca/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: parada em guarda de braços meio abertos, patas com garras à mostra, queixo erguido, cara de quem manda, de perfil para a direita. Personagem com cerca de 54 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 4 quadros.
Animação: Guarda de delegada (loop)
Quadros:
1) guarda, ombros largos · 2) respira, sobe um pouco · 3) inclina à frente encarando · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `andar.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Andar pesado e confiante (loop)
Quadros:
1) a 6) passos firmes e lentos, ombros balançando, rabo acompanhando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `correr.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `dor.png` (4 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `jab.png` (3 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 3 quadros.
Animação: Ataque básico 1: patada curta
Quadros:
1) pata recolhida · 2) patada à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 3 quadros.
Animação: Ataque básico 2: outra patada
Quadros:
1) outra pata recolhida · 2) patada · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 4 quadros.
Animação: Ataque básico 3: cabeçada
Quadros:
1) recua a cabeça · 2) avançando · 3) impacto: cabeça à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Patada de varrer
Quadros:
1) pata erguida atrás · 2) avançando · 3) impacto: pata esticada à frente, garras abertas · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Rabada para cima
Quadros:
1) vira um pouco · 2) rabo subindo · 3) impacto: rabo esticado acima da cabeça · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Patada rasteira
Quadros:
1) agacha · 2) pata varrendo · 3) impacto: pata rente ao chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Giro com garras
Quadros:
1) encolhida · 2) girando · 3) impacto: braços abertos com garras · 4) terminando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Bote no ar
Quadros:
1) patas para trás · 2) avançando · 3) impacto: as duas patas à frente · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Coice para trás
Quadros:
1) olhando para trás · 2) perna recolhida · 3) impacto: pé esticado para TRÁS (esquerda) · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Mordida para cima
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: boca aberta mordendo para cima · 4) fechando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 5 quadros.
Animação: Pisão da onça
Quadros:
1) encolhida · 2) pés para baixo · 3) impacto: os dois pés juntos para baixo · 4) quicando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Rugido
Quadros:
1) inspira, peito estufado · 2) cabeça para trás · 3) abrindo a boca · 4) impacto: rugindo com a boca enorme aberta à frente (sem onda desenhada) · 5) fechando · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Patada carregada
Quadros:
1) agacha puxando a pata para trás · 2) carregando, corpo torcido · 3) avança · 4) impacto: patada enorme à frente, corpo esticado · 5) recuperando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Salto da onça
Quadros:
1) agacha bem baixo · 2) impulso · 3) impacto: subindo esticada, garras para cima · 4) subindo · 5) topo · 6) abrindo os braços

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 6 quadros.
Animação: Batida do distintivo
Quadros:
1) tira o distintivo do cinto · 2) ergue acima da cabeça · 3) descendo · 4) impacto: agachada batendo o distintivo no chão · 5) levantando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 2 quadros.
Animação: Pendurada pela garra
Quadros:
1) pendurada por uma pata no alto do quadro (à direita) · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 4 quadros.
Animação: Anotando no caderninho (loop)
Quadros:
1) caderninho na mão · 2) anotando · 3) olha por cima dos óculos · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) braços cruzados, satisfeita · 2) mostra o distintivo à frente · 3) pose final: ajeita os óculos escuros e sorri

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Onça (use só estas cores):
contorno #2A0F12
pelagem: luz #F5C060, base #E5A63A, sombra #B07A22
rosetas: #1E1610
focinho e barriga: creme #F5E6C8, sombra #D4C09A
blazer e calça: luz #4A4E62, base #33364A, sombra #20222F
camisa: #E8E4DA
distintivo: luz #FFE08A, base #E8B83A, sombra #A87A1E
óculos: #1A1A1A, brilho #8AA0C0
olhos: #5FB04A, pupila #1A1008
```

## Interface (`art/ui/`)

### `retrato_onca.png`

```text
Retrato em pixel art (busto) do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho. Virado em 3/4 olhando para a direita, sorriso de canto confiante por cima dos óculos escuros. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_onca.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Dona Onça: onça-pintada humanizada, DELEGADA de bairro grandona e robusta (concept escolhido anexado): pelagem amarela com rosetas pretas, cabeça grande, mandíbula forte, olhos verdes, patas grandes, rabo grosso com ponta preta; blazer escuro fechado, calça escura, distintivo dourado no cinto, óculos escuros, caderninho, IGUAL ao concept anexado. Pose: mostrando o distintivo à frente com uma pata e a outra na cintura, óculos escuros, cara de quem já sabe de tudo. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
