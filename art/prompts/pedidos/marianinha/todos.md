# Marianinha · todos os pedidos (rodada 7)

Concept escolhido: `art/concepts/marianinha/escolhido.png`. Ficha: `design/personagens/marianinha.md`. Tudo em `art/pixel/marianinha/` (interface em `art/ui/`).

**Ordem:** 0 base → 1 lote 1 → 2 lote 2 → 3 lote 3 → 4 interface.

Anexe em todo pedido: `art/concepts/marianinha/escolhido.png`, `art/pixel/marianinha/base.png`, `art/pixel/marianinha/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: ginasta quicando na ponta dos pés, asas meio abertas, sorriso enorme, de perfil para a direita. Personagem com cerca de 38 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 4 quadros.
Animação: Quicando no lugar (loop)
Quadros:
1) na ponta dos pés · 2) agachando um pouco · 3) pulinho, pés saindo do chão · 4) descendo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `andar.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Andar (loop)
Quadros:
1) contato, perna da frente esticada · 2) peso desce · 3) passagem, corpo mais alto · 4) contato da outra perna · 5) peso desce · 6) passagem. Braços ao contrário das pernas

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `correr.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `dor.png` (4 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `jab.png` (3 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 3 quadros.
Animação: Ataque básico 1: bicadinha
Quadros:
1) cabeça para trás · 2) bicada à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 3 quadros.
Animação: Ataque básico 2: outra bicadinha
Quadros:
1) cabeça para trás · 2) bicada mais baixa · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 4 quadros.
Animação: Ataque básico 3: cabeçada de topete
Quadros:
1) encolhe · 2) avançando com a cabeça · 3) impacto: cabeçada à frente, topete eriçado · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Estrelinha
Quadros:
1) braços para cima · 2) mãos no chão, de lado · 3) impacto: pernas esticadas acertando à frente no alto · 4) terminando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Mortal chutando para cima
Quadros:
1) agacha · 2) começa o mortal · 3) impacto: pé esticado para o alto · 4) completando · 5) pousa

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Espacate
Quadros:
1) agacha · 2) abrindo as pernas · 3) impacto: espacate rente ao chão, pernas para os dois lados · 4) fechando · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Parafuso no ar
Quadros:
1) encolhida · 2) girando · 3) impacto: braços e pernas abertos girando · 4) terminando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Chute de tesoura
Quadros:
1) pernas recolhidas · 2) uma perna sobe · 3) impacto: as duas pernas esticadas à frente cruzando · 4) recolhendo · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Rabada no ar
Quadros:
1) olhando para trás · 2) girando · 3) impacto: rabinho e pernas batendo para TRÁS (esquerda) · 4) voltando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Cambalhota para cima
Quadros:
1) encolhida · 2) girando · 3) impacto: pés para cima · 4) completando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 5 quadros.
Animação: Pisão de quique
Quadros:
1) encolhida · 2) esticando as pernas para baixo · 3) impacto: os dois pés juntos para baixo · 4) quicando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Cuspe de semente
Quadros:
1) bochechas cheias · 2) cabeça para trás · 3) preparando · 4) impacto: bico aberto à frente cuspindo (a semente NÃO aparece) · 5) fechando · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Bala de canhão (enrola numa bolinha)
Quadros:
1) agacha · 2) se encolhendo · 3) impacto: bolinha totalmente enrolada · 4) bolinha girando · 5) desenrolando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Trampolim (pulos seguidos)
Quadros:
1) agacha · 2) pulando, braços para cima · 3) impacto: esticada no ar, braços para cima · 4) encolhendo · 5) esticada de novo · 6) braços abertos no topo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 6 quadros.
Animação: Bomba! (mergulho de bunda)
Quadros:
1) encolhendo · 2) abraçando os joelhos · 3) caindo sentada · 4) impacto: sentada no chão, braços para cima · 5) quicando · 6) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 2 quadros.
Animação: Pendurada na borda pelo BICO
Quadros:
1) pendurada pelo bico no alto do quadro (à direita), perninhas balançando · 2) perninhas para o outro lado. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 4 quadros.
Animação: Sentada balançando as pernas (loop)
Quadros:
1) sentada comendo semente · 2) perninha para cima · 3) a outra · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) quicando · 2) aterrissa num pé só, braços para cima · 3) pose final: segurando uma plaquinha de nota com dois traços (sem números escritos), piscando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

### `semente.png` (2 quadros)

```text
Folha de animação, 2 quadros.
Animação: Projétil: semente de girassol (sprite separado, sem personagem)
Quadros:
semente de girassol listrada preta e branca de uns 8 pixels, centralizada: 1) deitada · 2) inclinada (girando)

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
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
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

## Interface (`art/ui/`)

### `retrato_marianinha.png`

```text
Retrato em pixel art (busto) do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa. Virado em 3/4 olhando para a direita, sorriso enorme de olhos brilhando. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_marianinha.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Marianinha: marianinha-de-cabeça-amarela (papagaio pequeno) humanizada, menina ginasta de trampolim (concept escolhido anexado): corpo pequeno e redondo, cabeça grande amarelo-alaranjada com topete, bochechas e barriga brancas, asas e costas verdes, bico cinza-rosado, pernas finas cinza-rosadas, rabinho verde e amarelo curto, olhos grandes castanhos; collant rosa-choque brilhante (de manga cavada, comportado), munhequeiras brancas, laço rosa na nuca, sapatilhas rosa, IGUAL ao concept anexado. Pose: aterrissando num pé só com os braços para cima depois de uma acrobacia, sorrindo. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
