# Mourisco · todos os pedidos (rodada 11)

Concept escolhido: `art/concepts/mourisco/escolhido.png`. Ficha: `design/proposta-rodada11.md`. Tudo em `art/pixel/mourisco/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (feito na etapa A) → 1 lote 1 → 2 lote 2 → 3 efeitos → 4 interface. Sem intermediários (_meio).

Anexe em todo pedido: `art/concepts/mourisco/escolhido.png`, `art/pixel/mourisco/base.png`, `art/pixel/mourisco/parado.png`, `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (escala e limpeza).

## Lote 1

### `andar.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Andar (loop)
Quadros:
1) a 6) passos no jeito do personagem (passo atlético na ponta dos pés, braços soltos)

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `correr.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) braços cruzados à frente do rosto como bloqueio de vôlei · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `dor.png` (4 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `jab.png` (3 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 3 quadros.
Animação: Tapa
Quadros:
1) mão recolhida · 2) tapa à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 3 quadros.
Animação: Outro tapa
Quadros:
1) outra mão · 2) tapa · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 4 quadros.
Animação: Manchete
Quadros:
1) braços juntos baixos · 2) subindo · 3) impacto: manchete, braços unidos esticados à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Cortada no chão
Quadros:
1) braço armado atrás da cabeça · 2) vindo · 3) impacto: cortada, mão batendo à frente com força · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 2 quadros.
Animação: Pendurado na borda por UMA mão
Quadros:
1) pendurado por uma mão no alto do quadro (à direita), corpo pendendo · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Levantamento
Quadros:
1) agacha, mãos acima da testa · 2) subindo · 3) impacto: toque de levantamento, mãos para o alto · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Peixinho rasteiro
Quadros:
1) agacha · 2) mergulhando · 3) impacto: deitado esticado rente ao chão, braços à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Giro de bloqueio
Quadros:
1) encolhido · 2) girando · 3) impacto: girando com braços abertos · 4) terminando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Cortada no ar
Quadros:
1) braço armado atrás · 2) vindo · 3) impacto: cortada à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Chute de bicicleta
Quadros:
1) de costas · 2) perna subindo · 3) impacto: chute de bicicleta para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Bloqueio para cima
Quadros:
1) braços baixos · 2) subindo · 3) impacto: bloqueio, os dois braços esticados para o alto · 4) descendo · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 5 quadros.
Animação: Cravada
Quadros:
1) braço armado alto · 2) vindo · 3) impacto: mão batendo para BAIXO · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Saque
Quadros:
1) segurando a bola (mão vazia em concha, a bola NÃO aparece) · 2) jogando para cima · 3) impacto: braço armado olhando para cima · 4) cortando · 5) acompanhando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Manchete refletora
Quadros:
1) braços juntos · 2) posicionando · 3) impacto: manchete forte à frente, corpo firme · 4) segurando · 5) voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Levantada e cortada (recuperação)
Quadros:
1) agachado · 2) saltando · 3) impacto: no alto com o braço armado · 4) cortada para baixo · 5) caindo · 6) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 6 quadros.
Animação: Peixinho
Quadros:
1) correndo · 2) mergulhando · 3) impacto: rasante esticado, braços à frente · 4) deslizando na areia · 5) levantando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 4 quadros.
Animação: Bola no dedo (loop)
Quadros:
1) em pé girando a bola no dedo · 2) girando · 3) olhando a bola · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) gritando com o punho para o alto · 2) pulando · 3) pose final: bola debaixo do braço, polegar para cima

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 50 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — mourisco

Altura medida no candidato: aproximadamente 50 px, alvo ~50 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo liso | #A97858 | #80563F | #51372F |
| Regata | #FFD329 | #F1B914 | #B77908 |
| Shorts e faixa | #44A843 | #187638 | #104326 |
| Bola | #FFF2C4 | #F8CE28 | #155DBD |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: pose base aberta em vez de guarda, excesso de detalhe e quadros de respiração quase idênticos.
```

## Efeitos (folhas separadas, sem o personagem)

### `bola_volei.png` (2 quadros)

```text
Objeto: BOLA DE VÔLEI de praia branca #F4F1E6 com faixas azul #2D6FC4 e amarela #F2C230, redonda, uns 12 pixels: 1) bola · 2) bola girada. 2 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `fx_areia_mergulho.png` (4 quadros)

```text
Efeito: nuvem de areia clara #E8D2A0/#C8A86A saindo do chão para os lados (peixinho): 1) pequena · 2) grande · 3) grãos caindo · 4) restos. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

## Interface (`art/ui/`)

### `retrato_mourisco.png`

```text
Retrato em pixel art (busto) do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa. Virado em 3/4 olhando para a direita, sorriso confiante gritando 'vai!', faixa na testa, orelhas curtas. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_mourisco.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Mourisco: gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa, IGUAL ao concept anexado. Pose: saltando para a cortada com a bola acima da mão, cauda longa atrás. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
