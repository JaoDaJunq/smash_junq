# Espeto · todos os pedidos (rodada 11)

Concept escolhido: `art/concepts/ourico/escolhido.png`. Ficha: `design/proposta-rodada11.md`. Tudo em `art/pixel/ourico/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (feito na etapa A) → 1 lote 1 → 2 lote 2 → 3 efeitos → 4 interface. Sem intermediários (_meio).

Anexe em todo pedido: `art/concepts/ourico/escolhido.png`, `art/pixel/ourico/base.png`, `art/pixel/ourico/parado.png`, `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (escala e limpeza).

## Lote 1

### `andar.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
Animação: Andar (loop)
Quadros:
1) a 6) passos no jeito do personagem (passo marrento balançando a cabeça, guitarra nas costas)

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `correr.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) encolhido virando uma bola de espinhos · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `dor.png` (4 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 4 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `jab.png` (3 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 3 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 3 quadros.
Animação: Outro soco
Quadros:
1) outro punho recolhido · 2) soco · 3) volta

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 4 quadros.
Animação: Cabeçada de espinhos
Quadros:
1) cabeça para trás · 2) avançando · 3) impacto: cabeçada à frente, topete de espinhos na frente · 4) volta

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Guitarrada
Quadros:
1) tira a guitarra das costas · 2) erguendo pelo braço da guitarra · 3) impacto: bate com o corpo da guitarra à frente · 4) voltando · 5) guarda

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 4 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 2 quadros.
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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Headbang para cima
Quadros:
1) cabeça baixa · 2) jogando a cabeça · 3) impacto: espinhos da cabeça apontados para cima, olhos fechados de rock · 4) descendo · 5) guarda

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Rasteira de cauda
Quadros:
1) agacha · 2) cauda varrendo · 3) impacto: cauda rente ao chão à frente · 4) recolhendo · 5) levanta

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Bola de espinhos
Quadros:
1) encolhendo · 2) virando bola · 3) impacto: bola de espinhos fechada · 4) abrindo · 5) encolhido

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Guitarrada no ar
Quadros:
1) guitarra para trás · 2) vindo · 3) impacto: guitarra à frente · 4) voltando · 5) recolhido

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Costas de espinhos
Quadros:
1) olhando para trás · 2) virando as costas · 3) impacto: costas espinhentas para TRÁS (esquerda) · 4) voltando · 5) recolhido

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Headbang no ar
Quadros:
1) cabeça baixa · 2) subindo · 3) impacto: espinhos para cima · 4) descendo · 5) recolhido

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 5 quadros.
Animação: Sentada espinhenta
Quadros:
1) encolhido · 2) virando de bunda para baixo · 3) impacto: caindo sentado, espinhos para baixo · 4) quicando · 5) recolhido

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
Animação: Power chord
Quadros:
1) guitarra na posição de tocar · 2) mão erguida · 3) impacto: palhetada forte, corpo jogado para trás, espinhos eriçados (os espinhos voando NÃO aparecem) · 4) segurando o acorde · 5) relaxando · 6) guarda

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
Animação: Stage dive
Quadros:
1) correndo · 2) pulando de costas, braços abertos · 3) impacto: no ar de costas, espinhos à frente · 4) virando bola · 5) bola rolando · 6) levanta

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
Animação: Microfonia (recuperação)
Quadros:
1) segura a guitarra apontada para baixo · 2) tremendo · 3) impacto: impulsionado para cima, guitarra para baixo, espinhos eriçados · 4) subindo · 5) topo · 6) abrindo braços

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 6 quadros.
Animação: Arrepiar
Quadros:
1) encolhendo os ombros · 2) espinhos levantando · 3) impacto: TODOS os espinhos eriçados e maiores, cara brava · 4) mantendo · 5) baixando · 6) guarda

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 4 quadros.
Animação: Afinando a guitarra (loop)
Quadros:
1) sentado com a guitarra no colo · 2) mexendo na tarraxa · 3) ouvindo de olhos fechados · 4) volta

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) solo de guitarra de joelhos · 2) guitarra erguida acima da cabeça · 3) pose final: chifrinho de rock com a mão, língua de fora

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
# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
```

## Efeitos (folhas separadas, sem o personagem)

### `espinho.png` (2 quadros)

```text
Projétil: um ESPINHO creme #E9D9A6 com ponta escura #6B5A3A, reto, de uns 12 pixels de comprimento, apontado para a DIREITA: 1) espinho · 2) espinho levemente girado. 2 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `fx_power_chord.png` (4 quadros)

```text
Efeito: onda de acorde de guitarra em arcos vermelhos #D7262E e amarelos #F2C230 saindo para a DIREITA, sem notas musicais: 1) arco pequeno · 2) dois arcos · 3) três arcos grandes · 4) restos. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

### `fx_arrepio.png` (4 quadros)

```text
Efeito: estrelinhas de dor brancas e amarelas #F2C230 em volta de um ponto (quem bateu nos espinhos): 1) pequena · 2) estoura · 3) grande · 4) some. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.
```

## Interface (`art/ui/`)

### `retrato_ourico.png`

```text
Retrato em pixel art (busto) do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas. Virado em 3/4 olhando para a direita, cara de invocado com sorriso de canto, topete de espinhos. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_ourico.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Espeto: ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas, IGUAL ao concept anexado. Pose: tocando um acorde de pé com a guitarra vermelha, espinhos eriçados, uma perna para a frente. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
