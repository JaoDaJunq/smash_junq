# Preguinho · todos os pedidos (rodada 11)

Concept escolhido: `art/concepts/macaco_prego/escolhido.png`. Ficha: `design/proposta-rodada11.md`. Tudo em `art/pixel/macaco_prego/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (feito na etapa A) → 1 lote 1 → 2 lote 2 → 3 efeitos → 4 interface. Sem intermediários (_meio).

Anexe em todo pedido: `art/concepts/macaco_prego/escolhido.png`, `art/pixel/macaco_prego/base.png`, `art/pixel/macaco_prego/parado.png`, `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (escala e limpeza).

## Lote 1

### `andar.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Andar (loop)
Quadros:
1) a 6) passos no jeito do personagem (passo malandro balançando o martelo, cauda enrolada)

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `correr.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Correr (loop)
Quadros:
1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Pulo, queda e pouso
Quadros:
1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Frear e pouso (duas animações na mesma folha)
Quadros:
FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido atrás da caixa de ferramentas erguida · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `dor.png` (4 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `jab.png` (3 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 3 quadros.
Animação: Soco
Quadros:
1) punho recolhido · 2) soco à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 3 quadros.
Animação: Outro soco
Quadros:
1) outro punho · 2) soco · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 4 quadros.
Animação: Martelada leve
Quadros:
1) martelo para trás · 2) vindo · 3) impacto: martelo batendo à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Martelada forte
Quadros:
1) martelo erguido atrás da cabeça · 2) descendo · 3) impacto: martelo batendo à frente com as duas mãos · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 4 quadros.
Animação: Tonto depois do escudo quebrar (loop)
Quadros:
1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Agarrão e arremesso
Quadros:
1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 2 quadros.
Animação: Pendurado na borda por UMA mão
Quadros:
1) pendurado por uma mão no alto do quadro (à direita), corpo pendendo · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Martelo para cima
Quadros:
1) agacha · 2) erguendo · 3) impacto: martelo para o alto · 4) descendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Martelada no chão
Quadros:
1) agacha · 2) martelo descendo · 3) impacto: martelo batendo no chão à frente · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Giro na cauda
Quadros:
1) encolhido · 2) girando · 3) impacto: girando com a cauda aberta e martelo para fora · 4) terminando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Martelada no ar
Quadros:
1) martelo para trás · 2) vindo · 3) impacto: martelo à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Chute para trás
Quadros:
1) olhando para trás · 2) perna recolhida · 3) impacto: chute para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Chave para cima
Quadros:
1) chave inglesa na mão · 2) subindo · 3) impacto: chave inglesa para o alto · 4) descendo · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 5 quadros.
Animação: Martelada para baixo
Quadros:
1) martelo erguido · 2) virando · 3) impacto: martelo para baixo · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Troca de ferramenta
Quadros:
1) mão no cinto · 2) puxando · 3) impacto: erguendo a ferramenta nova orgulhoso (mão vazia fechada, o jogo desenha a ferramenta) · 4) girando · 5) conferindo · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Coco quebrado
Quadros:
1) coquinho na mão para trás · 2) girando o braço · 3) impacto: arremessando em arco, braço esticado, mão vazia (o coco NÃO aparece) · 4) acompanhando · 5) voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Escada dobrável (recuperação)
Quadros:
1) no ar, mãos para cima · 2) abrindo algo · 3) impacto: subindo, uma mão e um pé erguidos (a escada NÃO aparece) · 4) subindo · 5) subindo · 6) chegando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 6 quadros.
Animação: Pregar
Quadros:
1) agacha com o prego · 2) martelo erguido · 3) impacto: martelando no chão · 4) segunda martelada · 5) levantando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 4 quadros.
Animação: Consertando (loop)
Quadros:
1) sentado mexendo na caixa de ferramentas · 2) apertando um parafuso · 3) limpando a testa · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) girando o martelo · 2) entregando uma nota fiscal enorme · 3) pose final: martelo no ombro, sorriso malandro

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de 46 pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):
﻿# Preguinho — paleta e altura

Altura medida no `base.png`: aproximadamente 51 px em escala lógica 64x64 (pedido: ~46 px). A imagem saiu em 1254x1254, não 1024x1024.

Paleta documentada (até 16 cores, incluindo contorno e fundo; tons aproximados da arte gerada):

| Material | Luz | Base | Sombra |
|---|---|---|---|
| Pelo e cauda | #A8663F | #754329 | #42271F |
| Rosto | #FFE0A8 | #F2C983 | #BE8051 |
| Roupa verde | #A7A448 | #788237 | #4C582E |
| Jeans | #518BB8 | #32658F | #1F3F64 |
| Ferramentas/metais | #E1D9C4 | #A8A09A | #595653 |
| Acentos | #FFD045 | #E49A26 | #9F5A1E |
| Contorno | — | #2A0F12 | — |
| Fundo | — | #FF00FF | — |

A folha `parado.png` saiu em 1536x1024. A respiração e as pequenas mudanças de cauda são discretas; visualmente a pose está estável.
```

## Efeitos (folhas separadas, sem o personagem)

### `coquinho.png` (2 quadros)

```text
Projétil: COQUINHO marrom #8A5A2E com fibras #C8945A, redondo, uns 12 pixels: 1) inteiro · 2) quebrado em 2 metades. 2 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `prego.png` (2 quadros)

```text
Objeto: PREGO prateado #C8CCD2/#8A9098 cravado no chão, uns 8 pixels: 1) prego · 2) prego torto. 2 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `escada.png` (2 quadros)

```text
Objeto: ESCADA DOBRÁVEL de alumínio #C8CCD2 com degraus, aberta em pé, uns 50 pixels de altura: 1) aberta · 2) balançando. 2 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `ferramentas.png` (3 quadros)

```text
Objetos: as 3 FERRAMENTAS do Preguinho, uma por quadro, cada uma uns 16 pixels: 1) martelo · 2) chave inglesa · 3) furadeira amarela. 3 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

## Interface (`art/ui/`)

### `retrato_macaco_prego.png`

```text
Retrato em pixel art (busto) do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão. Virado em 3/4 olhando para a direita, sorriso malandro, topete escuro, lápis atrás da orelha. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_macaco_prego.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Preguinho: macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão, IGUAL ao concept anexado. Pose: martelo apoiado no ombro, outra mão no cinto de ferramentas, cauda enrolada, sorriso de quem vai cobrar caro. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
