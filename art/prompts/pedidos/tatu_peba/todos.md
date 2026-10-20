# Seu Peba · todos os pedidos (rodada 7)

Concept escolhido: `art/concepts/tatu_peba/escolhido.png`. Ficha: `design/personagens/tatu_peba.md`. Tudo em `art/pixel/tatu_peba/` (interface em `art/ui/`).

**Ordem:** 0 base → 1 lote 1 → 2 lote 2 → 3 lote 3 → 4 interface.

Anexe em todo pedido: `art/concepts/tatu_peba/escolhido.png`, `art/pixel/tatu_peba/base.png`, `art/pixel/tatu_peba/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: segurando a sanfona à frente, meio curvado, sorriso de canto, de perfil para a direita. Personagem com cerca de 44 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 4 quadros.
Animação: Parado no balanço do forró (loop)
Quadros:
1) sanfona fechada, curvado · 2) abre um pouco a sanfona, corpo sobe · 3) fecha · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `andar.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Arrasta-pé (loop)
Quadros:
1) a 6) passos de forró arrastando os pés, quadril balançando, sanfona no peito

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `correr.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `dor.png` (4 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `jab.png` (3 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 3 quadros.
Animação: Ataque básico 1: soquinho
Quadros:
1) mão recolhida · 2) soco curto à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 3 quadros.
Animação: Ataque básico 2: outro soquinho
Quadros:
1) outra mão recolhida · 2) soco · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 4 quadros.
Animação: Ataque básico 3: sanfonada
Quadros:
1) puxa a sanfona para trás · 2) avançando · 3) impacto: bate com a sanfona fechada à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Fole esticado (abre a sanfona com tudo)
Quadros:
1) sanfona fechada · 2) começa a abrir · 3) impacto: fole BEM aberto à frente, longo · 4) fechando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Chute de xaxado para cima
Quadros:
1) agacha · 2) perna subindo · 3) impacto: pé esticado para cima · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Arrasta-pé rasteira
Quadros:
1) agacha · 2) pé varrendo · 3) impacto: perna esticada rente ao chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Vira bola no ar
Quadros:
1) encolhendo · 2) enrolando · 3) impacto: bola de carapaça girando · 4) desenrolando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Sanfonada no ar
Quadros:
1) sanfona para trás · 2) vindo · 3) impacto: sanfona batendo à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Casco nas costas (empurrão de costas)
Quadros:
1) olhando para trás · 2) virando as costas · 3) impacto: carapaça das costas empurrando para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Chapéu para cima
Quadros:
1) mão no chapéu · 2) subindo · 3) impacto: braço esticado para cima segurando o chapéu · 4) recolocando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 5 quadros.
Animação: Pisão de xaxado
Quadros:
1) encolhido · 2) pé para baixo · 3) impacto: os dois pés juntos para baixo · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Nota de sanfona (solta uma nota musical)
Quadros:
1) abre a sanfona · 2) aperta as teclas · 3) fole abrindo · 4) impacto: fole todo aberto apontando à frente (a nota NÃO aparece) · 5) fechando · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Rolamento de casco
Quadros:
1) agacha · 2) encolhendo · 3) impacto: bola de carapaça · 4) bola girando · 5) desenrolando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Fole a jato (a sanfona sopra e ele sobe)
Quadros:
1) agacha segurando a sanfona para baixo · 2) apertando o fole · 3) impacto: subindo com a sanfona apontada para baixo, fole fechando · 4) subindo · 5) topo · 6) abrindo os braços

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 6 quadros.
Animação: Toca (cava e some)
Quadros:
1) agacha, garras no chão · 2) cavando, metade do corpo abaixada · 3) só a carapaça e o chapéu aparecendo · 4) impacto: saindo do chão com as garras para cima · 5) pulinho · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 2 quadros.
Animação: Pendurado pela garra
Quadros:
1) pendurado por uma garra no alto do quadro (à direita), sanfona balançando · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 4 quadros.
Animação: Sentado na sanfona tomando café (loop)
Quadros:
1) sentado, xícara na mão · 2) bebendo · 3) suspirando satisfeito · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) tocando a sanfona · 2) passinho de forró · 3) pose final: tira o chapéu e sorri

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

### `nota.png` (2 quadros)

```text
Folha de animação, 2 quadros.
Animação: Projétil: nota musical (sprite separado, sem personagem)
Quadros:
nota musical (colcheia) creme com contorno, de uns 14 pixels, centralizada: 1) reta · 2) inclinada

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
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
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 44 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Seu Peba (use só estas cores):
contorno #2A0F12
carapaça: luz #E8D49A, base #C9A86A, sombra #8E7448
pele: luz #F0BFAA, base #D9A08A, sombra #A87060
couro (chapéu, gibão, alpercata): luz #B07A44, base #8A5A2E, sombra #5A3A1E
camisa e calça: luz #FAF4E4, base #EDE3C8, sombra #C9BC9A
sanfona: vermelho #C0302A, sombra #7E1E1A, fole creme #F0E2BC, teclas #FFFFFF / #1A1A1A, metal #D9B860
olhos: #1A1008
```

## Interface (`art/ui/`)

### `retrato_tatu_peba.png`

```text
Retrato em pixel art (busto) do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças. Virado em 3/4 olhando para a direita, sorriso de canto confiante. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_tatu_peba.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Seu Peba: tatu-peba humanizado, forrozeiro sertanejo e sanfoneiro (concept escolhido anexado): baixinho e quadrado, carapaça de faixas amarelo-palha nas costas e nos braços, pele rosada, focinho comprido, orelhas pequenas, garras grandes, rabo com anéis; chapéu de couro com estrela; colete/gibão de couro marrom com franjas; camisa creme; calça branca dobrada; alpercata de couro; SANFONA (acordeão) vermelha e creme presa ao corpo por alças, IGUAL ao concept anexado. Pose: tocando a sanfona aberta num passo de forró, chapéu de couro inclinado. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
