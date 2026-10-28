# Bandeira · todos os pedidos (rodada 11)

Concept escolhido: `art/concepts/tamandua/escolhido.png`. Ficha: `design/proposta-rodada11.md`. Tudo em `art/pixel/tamandua/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (feito na etapa A) → 1 lote 1 → 2 lote 2 → 3 efeitos → 4 interface. Sem intermediários (_meio).

Anexe em todo pedido: `art/concepts/tamandua/escolhido.png`, `art/pixel/tamandua/base.png`, `art/pixel/tamandua/parado.png`, `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (escala e limpeza).

## Lote 1

### `andar.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Andar (loop)
Quadros:
1) a 6) passos no jeito do personagem (passo calmo e pesado, garras dobradas para dentro, cauda balançando atrás)

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `correr.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido atrás da cauda enorme dobrada para a frente como um escudo de pelos · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `dor.png` (4 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `jab.png` (3 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 3 quadros.
Animação: Garrada
Quadros:
1) garra recolhida · 2) garrada à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 3 quadros.
Animação: Outra garrada
Quadros:
1) outra garra recolhida · 2) garrada · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 4 quadros.
Animação: Focinhada
Quadros:
1) cabeça para trás · 2) avançando · 3) impacto: focinho comprido esticado à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Jato de mangueira
Quadros:
1) puxa o bico da bomba · 2) aponta à frente · 3) impacto: bico apontado à frente, corpo firme (o jato NÃO aparece, o jogo desenha) · 4) segurando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 2 quadros.
Animação: Pendurado na borda por UMA mão
Quadros:
1) pendurado por uma mão no alto do quadro (à direita), corpo pendendo · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Cauda-bandeira para cima
Quadros:
1) vira de lado · 2) cauda subindo · 3) impacto: cauda aberta abanando para o alto · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Focinho varrendo
Quadros:
1) agacha · 2) focinho baixando · 3) impacto: focinho rente ao chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Giro de cauda
Quadros:
1) encolhido · 2) girando · 3) impacto: de lado com a cauda aberta em volta · 4) terminando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Garras no ar
Quadros:
1) garras para trás · 2) vindo · 3) impacto: as duas garras à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Cauda para trás
Quadros:
1) olhando para trás · 2) cauda recolhida · 3) impacto: cauda abanando para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Focinho para cima
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: focinho apontado para o alto · 4) descendo · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 5 quadros.
Animação: Pisão de botina
Quadros:
1) encolhido · 2) perna descendo · 3) impacto: botina pisando para baixo · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Nuvem de veneno
Quadros:
1) pega o bico da bomba · 2) bombeando · 3) impacto: borrifando à frente, bico apontado (a nuvem NÃO aparece) · 4) segurando · 5) baixando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Língua
Quadros:
1) focinho recolhido · 2) boca abrindo · 3) impacto: focinho esticado à frente, bochechas cheias (a língua NÃO aparece, o jogo desenha) · 4) puxando · 5) mastigando satisfeito · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Escalada de garra (recuperação)
Quadros:
1) no ar, garras erguidas · 2) cravando as garras para cima · 3) impacto: braços esticados para o alto · 4) puxando o corpo · 5) subindo · 6) chegando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 6 quadros.
Animação: Abraço de tamanduá
Quadros:
1) braços abertos · 2) avançando devagar · 3) impacto: abraço fechado em algo invisível · 4) apertando com força · 5) soltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 4 quadros.
Animação: Lambendo formigas (loop)
Quadros:
1) agachado ao lado de um formigueiro baixinho · 2) focinho no formigueiro · 3) mastigando feliz · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) borrifando a área com a bomba, satisfeito · 2) conferindo uma prancheta · 3) pose final: polegar para cima, cauda aberta atrás

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 56 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Paleta e escala — tamandua

Altura medida no candidato: aproximadamente 53 px (sem contar cauda/bomba), alvo ~56 px.

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Contorno | — | #2A0F12 | — |
| Pelo creme | #F7D99B | #E8C581 | #A8663F |
| Pelo escuro e cauda | #633B31 | #402522 | #2A0F12 |
| Macacão | #F5E6C6 | #D8C7A6 | #A98D6C |
| Faixa e equipamento | #F4C21A | #E89A05 | #80501D |
| Fundo | — | #FF00FF | — |

Cores estimadas visualmente do conceito aprovado e do candidato. O candidato ainda precisa de revisão: excesso de detalhe, quadro base fora de 1024×1024, poses e respiração não comprovadas ao pixel.
```

## Efeitos (folhas separadas, sem o personagem)

### `fx_nuvem_veneno.png` (4 quadros)

```text
Efeito: nuvem de veneno verde-amarelada #A8C83A/#6E8A1E com bolinhas, que fica parada no lugar (loop): 1) pequena · 2) cheia · 3) cheia mexendo · 4) desmanchando. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `fx_jato.png` (4 quadros)

```text
Efeito: jato de spray de inseticida branco-esverdeado #D8F0C0/#8AB870 saindo para a DIREITA: 1) curto · 2) médio · 3) longo · 4) gotas finais. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

## Interface (`art/ui/`)

### `retrato_tamandua.png`

```text
Retrato em pixel art (busto) do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas. Virado em 3/4 olhando para a direita, olhar calmo de profissional, focinho comprido, boné/capacete de dedetizador. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_tamandua.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Bandeira: tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas, IGUAL ao concept anexado. Pose: segurando o bico da bomba de inseticida apontado para cima, cauda enorme aberta atrás, garras à mostra. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
