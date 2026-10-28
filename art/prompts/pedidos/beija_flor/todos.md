# Beija · todos os pedidos (rodada 11)

Concept escolhido: `art/concepts/beija_flor/escolhido.png`. Ficha: `design/proposta-rodada11.md`. Tudo em `art/pixel/beija_flor/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (feito na etapa A) → 1 lote 1 → 2 lote 2 → 3 efeitos → 4 interface. Sem intermediários (_meio).

Anexe em todo pedido: `art/concepts/beija_flor/escolhido.png`, `art/pixel/beija_flor/base.png`, `art/pixel/beija_flor/parado.png`, `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (escala e limpeza).

## Lote 1

### `andar.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Andar (loop)
Quadros:
1) a 6) passos no jeito do personagem (saltitando inquieto, asas tremendo, skate debaixo do braço)

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `correr.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido atrás das asas fechadas na frente do corpo · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `dor.png` (4 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `jab.png` (3 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 3 quadros.
Animação: Bicada
Quadros:
1) cabeça recolhida · 2) bicada à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 3 quadros.
Animação: Outra bicada
Quadros:
1) recolhe · 2) bicada · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 4 quadros.
Animação: Rajada de bicadas
Quadros:
1) recolhendo · 2) bicadas rápidas (bico em 2 posições borradas) · 3) impacto: bicada final à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Chute de skate
Quadros:
1) skate na mão para trás · 2) girando · 3) impacto: batendo com o shape do skate à frente · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 2 quadros.
Animação: Pendurado na borda por UMA mão
Quadros:
1) pendurado por uma mão no alto do quadro (à direita), corpo pendendo · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Ollie para cima
Quadros:
1) em cima do skate agachado · 2) pulando · 3) impacto: no alto com o skate erguido acima da cabeça · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Rasteira de rodinha
Quadros:
1) agacha · 2) skate deslizando · 3) impacto: skate rente ao chão à frente · 4) puxando · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Giro com asas
Quadros:
1) asas fechadas · 2) girando · 3) impacto: asas abertas girando · 4) terminando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Bicada mergulho
Quadros:
1) bico para trás · 2) mergulhando · 3) impacto: bico apontado à frente-baixo, corpo esticado · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Asa para trás
Quadros:
1) olhando para trás · 2) asa recolhida · 3) impacto: asa batendo para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Kickflip para cima
Quadros:
1) skate nos pés · 2) chutando · 3) impacto: skate girando acima da cabeça · 4) pegando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 5 quadros.
Animação: Cravada de skate
Quadros:
1) skate nos pés · 2) virando · 3) impacto: pisando para baixo com o skate debaixo dos pés · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Néctar
Quadros:
1) parado no ar batendo asa · 2) bico à frente · 3) impacto: sugando, olhos fechados de prazer · 4) sugando · 5) satisfeito · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Manobra (skate segue sozinho)
Quadros:
1) subindo no skate · 2) remando · 3) impacto: deslizando em cima do skate · 4) pulando do skate (o skate solto NÃO aparece) · 5) no ar sem skate · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Voo de beija-flor (recuperação)
Quadros:
1) asas abertas · 2) asas borradas de tão rápidas · 3) impacto: corpo esticado voando · 4) voando · 5) freando · 6) parado no ar

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 6 quadros.
Animação: Grind
Quadros:
1) em cima do skate · 2) virando de lado · 3) impacto: deslizando de lado com o skate (grind), braços abertos · 4) deslizando · 5) pulando fora · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 4 quadros.
Animação: Sentado no skate (loop)
Quadros:
1) sentado no skate · 2) balançando os pés · 3) olhando o celular imaginário · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) manobra no ar com o skate · 2) pousando no skate · 3) pose final: skate em pé ao lado, sinal de 'joia', piscando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 40 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — beija_flor

Altura medida no candidato: aproximadamente 40 px, alvo ~40 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Penas verdes | #81E531 | #28A936 | #12603A |
| Garganta | #FF8291 | #F23E66 | #A51E45 |
| Boné/jaqueta | #79B8B1 | #3C8584 | #245454 |
| Roupa e skate | #FFD02C | #ECA91C | #8A5B18 |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: detalhe fino, paleta extensa e pose/altura exata não verificadas.
```

## Efeitos (folhas separadas, sem o personagem)

### `skate.png` (2 quadros)

```text
Objeto: o SKATE do Beija (shape colorido como no concept, rodinhas amarelas), visto de lado, uns 20 pixels: 1) skate · 2) skate com rodinhas girando. 2 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `fx_nectar.png` (4 quadros)

```text
Efeito: brilhinhos de néctar dourado #F2C230 e rosa #F28AB8 subindo (cura): 1) poucos · 2) mais · 3) cheio · 4) sumindo. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

## Interface (`art/ui/`)

### `retrato_beija_flor.png`

```text
Retrato em pixel art (busto) do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept. Virado em 3/4 olhando para a direita, sorriso elétrico, boné/capacete de skatista, bico fino. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_beija_flor.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Beija: beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept, IGUAL ao concept anexado. Pose: em pé em cima do skate fazendo pose, asas abertas, sinal de 'joia'. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
