# Cutia Ligeira · todos os pedidos (rodada 10)

Concept escolhido: `art/concepts/cutia/escolhido.png`. Ficha: `design/personagens/cutia.md`. Tudo em `art/pixel/cutia/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (PARE e espere o ok) → 1 lote 1 → 2 lote 2 → 4 interface. O lote 3 (intermediários) NÃO é pedido nesta rodada.

Anexe em todo pedido: `art/concepts/cutia/escolhido.png`, `art/pixel/cutia/base.png`, `art/pixel/cutia/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: em guarda ligeira na ponta dos pés, um saquinho de castanha na mão, sorriso esperto, de perfil para a direita. Personagem com cerca de 40 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 4 quadros.
Animação: Saltitando no lugar (loop)
Quadros:
1) ponta dos pés · 2) agacha um pouco · 3) pulinho · 4) descendo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `andar.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Andar ligeiro (loop)
Quadros:
1) a 6) passinhos rápidos e saltitados, avental balançando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `correr.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido, braços cruzados na frente do rosto · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `dor.png` (4 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `jab.png` (3 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 3 quadros.
Animação: Ataque básico 1: tapinha
Quadros:
1) mão recolhida · 2) tapa rápido à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 3 quadros.
Animação: Ataque básico 2: outro tapinha
Quadros:
1) outra mão recolhida · 2) tapa · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 4 quadros.
Animação: Ataque básico 3: chute ligeiro
Quadros:
1) perna recolhida · 2) chutando · 3) impacto: perna fina esticada à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Coice duplo de cutia
Quadros:
1) apoia as mãos no chão · 2) pernas para trás · 3) impacto: coice com as duas pernas à FRENTE, de costas · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Cambalhota para cima
Quadros:
1) agacha · 2) começa a cambalhota · 3) impacto: pés para o alto · 4) completando · 5) pousa

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Varrida de perna
Quadros:
1) agacha · 2) perna varrendo · 3) impacto: perna rente ao chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Giro no ar
Quadros:
1) encolhida · 2) girando · 3) impacto: pernas abertas em roda · 4) terminando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Chute voador
Quadros:
1) perna para trás · 2) vindo · 3) impacto: perna à frente · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Coice para trás no ar
Quadros:
1) olhando para trás · 2) perna recolhida · 3) impacto: pé esticado para TRÁS (esquerda) · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Cabeçada para cima
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: cabeça para cima, orelhas em pé · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 5 quadros.
Animação: Pisão duplo
Quadros:
1) encolhida · 2) pés para baixo · 3) impacto: os dois pés juntos para baixo · 4) quicando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Saquinho de castanha
Quadros:
1) pega o saquinho do bolso · 2) braço para trás · 3) girando o braço · 4) impacto: arremessando à frente, mão aberta (o saquinho NÃO aparece) · 5) voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Carrinhada (empurra o carrinho de mão)
Quadros:
1) segura um carrinho de mão PEQUENO de madeira com castanhas · 2) agacha empurrando · 3) impacto: correndo inclinada, carrinho à frente · 4) correndo · 5) freando · 6) solta o carrinho (some) e fica em guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Pulo de cutia
Quadros:
1) agacha bem baixo · 2) impulso das pernas compridas · 3) impacto: subindo esticada, pernas juntas · 4) subindo · 5) topo · 6) abrindo os braços

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 6 quadros.
Animação: Enterra castanha
Quadros:
1) agacha · 2) cava com as mãos · 3) põe a castanha no buraco · 4) impacto: bate a terra com as duas mãos · 5) levanta · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 2 quadros.
Animação: Pendurada pelas mãos
Quadros:
1) pendurada pelas duas mãos no alto do quadro (à direita) · 2) balançando as pernas. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 4 quadros.
Animação: Roendo castanha (loop)
Quadros:
1) castanha nas mãos · 2) roendo · 3) roendo rápido · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) pulo de alegria · 2) mostrando um saquinho de castanha · 3) pose final: piscadinha com a castanha na boca

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

### `castanha.png` (2 quadros)

```text
Folha de animação, 2 quadros.
Animação: Projétil: saquinho de castanha (sprite separado, sem personagem)
Quadros:
saquinho de papel pardo com castanhas, de uns 12 pixels, centralizado: 1) em pé · 2) inclinado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 40 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Cutia Ligeira (use só estas cores):
contorno #2A0F12
pelo: luz #F0A850, base #D98A3A, sombra #A8621E
barriga e focinho: creme #F2D8A8, sombra #D4B87E
lenço e avental: luz #9ACD5A, base #3E8A3A, sombra #2A5E28
camisa e calça: #FAF4E4, sombra #D9CDB0
castanhas: #7A3A1A, brilho #B0602A
botas: #7A4A22
olhos: #6A3A14, brilho #FFFFFF
```

## Interface (`art/ui/`)

### `retrato_cutia.png`

```text
Retrato em pixel art (busto) do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom. Virado em 3/4 olhando para a direita, sorriso esperto de dentinhos à mostra. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_cutia.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Cutia Ligeira: CUTIA (roedor sul-americano, NÃO raposa nem doninha) humanizada, moça vendedora de castanha na feira (concept escolhido anexado): corpo compacto com o traseiro arredondado e alto, pernas finas e compridas, focinho CURTO e arredondado de roedor com bigodes, dentinhos da frente, orelhas pequenas redondas, rabo quase inexistente (só um tufinho), pelo dourado-alaranjado, barriga creme; lenço verde estampado de folhas na cabeça, camisa branca, avental verde com bolsos cheios de castanhas, calça creme dobrada, botinha marrom, IGUAL ao concept anexado. Pose: oferecendo um saquinho de castanha à frente, piscando, lenço na cabeça e avental cheio de castanhas. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
