# Dona Canga · todos os pedidos (rodada 7)

Concept escolhido: `art/concepts/arara_canga/escolhido.png`. Ficha: `design/personagens/arara_canga.md`. Tudo em `art/pixel/arara_canga/` (interface em `art/ui/`).

**Ordem:** 0 base → 1 lote 1 → 2 lote 2 → 3 lote 3 → 4 interface.

Anexe em todo pedido: `art/concepts/arara_canga/escolhido.png`, `art/pixel/arara_canga/base.png`, `art/pixel/arara_canga/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: baiana parada em guarda, asas meio abertas, saia rodada aberta, queixo erguido e orgulhosa, de perfil para a direita. Personagem com cerca de 54 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 4 quadros.
Animação: Requebrado parado (loop)
Quadros:
1) saia parada, asas meio abertas · 2) quadril para um lado, saia balançando · 3) quadril para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `andar.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
Animação: Andar sambando (loop)
Quadros:
1) contato, saia balançando · 2) peso desce · 3) passagem · 4) contato da outra perna · 5) peso desce · 6) passagem. Asas acompanhando, saia girando um pouco

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `correr.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `dor.png` (4 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 4 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `jab.png` (3 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 3 quadros.
Animação: Ataque básico 1: tapa com a asa da frente
Quadros:
1) asa recolhida · 2) asa esticada à frente batendo · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 3 quadros.
Animação: Ataque básico 2: tapa com a outra asa
Quadros:
1) asa de trás recolhida · 2) asa de trás batendo à frente, corpo girado · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 4 quadros.
Animação: Ataque básico 3: umbigada (empurrão com a barriga)
Quadros:
1) recua o corpo · 2) jogando a barriga para a frente · 3) impacto: barriga e saia projetadas à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Giro de baiana (bate com a saia e as asas)
Quadros:
1) começa a girar · 2) de costas, saia abrindo · 3) impacto: saia aberta em roda e asa esticada à frente · 4) terminando o giro · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 4 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
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

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Explosão de alegria (abre as asas para cima)
Quadros:
1) encolhe · 2) abrindo · 3) impacto: asas abertas acima da cabeça · 4) baixando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Miudinho (sapateado rápido)
Quadros:
1) pé à frente · 2) pisando · 3) impacto: sapateando com o salto à frente, rente ao chão · 4) outro pé · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Giro de passista no ar
Quadros:
1) encolhida · 2) girando · 3) impacto: saia e asas abertas em roda · 4) terminando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Bicada no ar
Quadros:
1) cabeça para trás · 2) avançando · 3) impacto: bico esticado à frente · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Rabada no ar
Quadros:
1) olhando para trás · 2) girando o quadril · 3) impacto: cauda longa batendo para TRÁS (esquerda) · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Bico para cima
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: bico apontado para cima · 4) descendo · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 5 quadros.
Animação: Salto plataforma (cai como pilão)
Quadros:
1) encolhida · 2) esticando as pernas para baixo · 3) impacto: os dois saltos plataforma juntos para baixo · 4) quicando · 5) encolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
Animação: Pandeiro arremessado
Quadros:
1) pega o pandeiro na mão · 2) braço para trás · 3) preparando · 4) impacto: braço esticado soltando o pandeiro (o pandeiro JÁ NÃO aparece) · 5) braço passando · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
Animação: Desfile girando
Quadros:
1) começa o giro · 2) girando de lado · 3) impacto: saia em roda, asa à frente · 4) de costas · 5) girando · 6) para

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
Animação: Voo de alegoria (bate as asas e sobe)
Quadros:
1) agacha, asas para baixo · 2) asas subindo · 3) impacto: asas no alto, corpo subindo · 4) asas para baixo · 5) asas no alto · 6) planando, asas abertas

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 6 quadros.
Animação: Paradinha da bateria (bate o salto e para)
Quadros:
1) levanta o pé · 2) pé no alto, asas abertas · 3) prepara · 4) impacto: bate o salto no chão com força, corpo firme, mão para cima pedindo silêncio · 5) pose congelada · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 2 quadros.
Animação: Pendurada na borda pelo BICO
Quadros:
1) pendurada pelo bico no alto do quadro (o bico no topo, à direita), corpo e saia soltos para baixo · 2) saia balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 4 quadros.
Animação: Sentada se abanando (loop)
Quadros:
1) sentada, saia espalhada, abanando com a asa · 2) asa para cima · 3) asa para baixo · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) samba no pé · 2) mão no turbante, beijinho · 3) pose final: asas e saia abertas, cantando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

### `pandeiro.png` (4 quadros)

```text
Folha de animação, 4 quadros.
Animação: Projétil: pandeiro girando (sprite separado, sem personagem)
Quadros:
pandeiro de couro com platinelas douradas visto girando no ar: 1) de frente · 2) inclinado · 3) de lado (fino) · 4) inclinado do outro lado. Pandeiro com uns 20 pixels de largura, centralizado na célula

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
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
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

## Interface (`art/ui/`)

### `retrato_arara_canga.png`

```text
Retrato em pixel art (busto) do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada. Virado em 3/4 olhando para a direita, sorriso orgulhoso cantando. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_arara_canga.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, IGUAL ao concept anexado. Pose: girando a saia rodada, uma asa aberta para cima e a outra na cintura, cantando. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
