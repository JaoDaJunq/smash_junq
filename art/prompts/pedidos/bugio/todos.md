# Berrante · todos os pedidos (rodada 10)

Concept escolhido: `art/concepts/bugio/escolhido.png`. Ficha: `design/personagens/bugio.md`. Tudo em `art/pixel/bugio/` (interface em `art/ui/`).

**Ordem:** 0 base + parado (PARE e espere o ok) → 1 lote 1 → 2 lote 2 → 4 interface. O lote 3 (intermediários) NÃO é pedido nesta rodada.

Anexe em todo pedido: `art/concepts/bugio/escolhido.png`, `art/pixel/bugio/base.png`, `art/pixel/bugio/parado.png (depois de pronto)`. O Juba (`art/pixel/juba/parado.png`) serve só de referência de escala e pixel.

## 0 · Base `base.png`

```text
Sprite base do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: em pé de peito estufado, uma mão segurando o microfone perto da boca e a outra com o dedo erguido, rabo enrolado atrás, de perfil para a direita. Personagem com cerca de 54 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

## Lote 1

### `parado.png` (4 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 4 quadros.
Animação: Peito estufado (loop)
Quadros:
1) guarda, microfone na mão · 2) respira, peito sobe · 3) inclina à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `andar.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
Animação: Andar de peito estufado (loop)
Quadros:
1) a 6) passos largos, braços longos balançando, rabo acompanhando

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `correr.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `pulo.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `transicoes_a.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `transicoes_b.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `defesa_esquiva.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `dor.png` (4 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 4 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `jab.png` (3 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 3 quadros.
Animação: Ataque básico 1: tapão
Quadros:
1) mão recolhida · 2) tapão à frente · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `jab_b.png` (3 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 3 quadros.
Animação: Ataque básico 2: outro tapão
Quadros:
1) outra mão recolhida · 2) tapão · 3) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `jab_c.png` (4 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 4 quadros.
Animação: Ataque básico 3: microfonada
Quadros:
1) microfone para trás · 2) avançando · 3) impacto: bate com o microfone à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `golpe_frente.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Braçada longa
Quadros:
1) braço para trás · 2) girando o tronco · 3) impacto: braço longo esticado à frente · 4) voltando · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

## Lote 2

### `tonto.png` (4 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 4 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `agarrar.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `golpe_cima.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
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
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `golpe_baixo.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Pisão de gorila
Quadros:
1) ergue o pé · 2) descendo · 3) impacto: pisão à frente, corpo agachado · 4) recolhendo · 5) levanta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `aereo_neutro.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Giro de braços
Quadros:
1) encolhido · 2) girando · 3) impacto: braços longos abertos em roda · 4) terminando · 5) encolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `aereo_frente.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Tapão duplo no ar
Quadros:
1) mãos para trás · 2) avançando · 3) impacto: as duas mãos à frente · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `aereo_tras.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Rabada para trás
Quadros:
1) olhando para trás · 2) virando · 3) impacto: rabo batendo para TRÁS (esquerda) · 4) voltando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `aereo_cima.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Berro para cima
Quadros:
1) cabeça baixa · 2) erguendo · 3) impacto: boca enorme aberta berrando para cima · 4) fechando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `aereo_baixo.png` (5 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 5 quadros.
Animação: Pisão no ar
Quadros:
1) encolhido · 2) pés para baixo · 3) impacto: os dois pés juntos para baixo · 4) quicando · 5) recolhido

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `especial_neutro.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
Animação: Berro em onda
Quadros:
1) puxa o ar, peito enorme · 2) microfone na boca · 3) abrindo a boca · 4) impacto: berrando com a boca enorme aberta à frente, papo inchado (sem onda desenhada) · 5) fechando · 6) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `especial_lado.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
Animação: Investida com megafone
Quadros:
1) puxa o megafone · 2) agacha · 3) impulso · 4) impacto: corpo esticado à frente, megafone na frente · 5) freando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `especial_cima.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
Animação: Berro foguete
Quadros:
1) agacha, megafone apontado para baixo · 2) berrando · 3) impacto: subindo com o megafone para baixo · 4) subindo · 5) topo · 6) abrindo os braços

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `especial_baixo.png` (6 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 6 quadros.
Animação: Teste do som
Quadros:
1) bate no microfone · 2) aproxima da boca · 3) puxa o ar · 4) impacto: berro curto de olhos fechados, corpo tremendo · 5) relaxa · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `rouco.png` (4 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 4 quadros.
Animação: Rouco (loop)
Quadros:
1) mão na garganta, cara de sofrimento · 2) tossindo · 3) boca aberta sem som · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `pendurado.png` (2 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 2 quadros.
Animação: Pendurado pelo rabo
Quadros:
1) pendurado pelo rabo e por uma mão no alto do quadro (à direita) · 2) balançando. Sem desenhar a borda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `descanso.png` (4 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 4 quadros.
Animação: Ouvindo o fone (loop)
Quadros:
1) mãos no fone · 2) balançando a cabeça · 3) cantarolando · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

### `vitoria.png` (3 quadros)

```text
Folha de animação do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, 3 quadros.
Animação: Comemoração (3 poses)
Quadros:
1) berrando com o microfone para cima · 2) batendo no peito · 3) pose final: dedo erguido, sorriso enorme

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (16x16 na base, 8x8 nas folhas); NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta do Berrante (use só estas cores):
contorno #2A0F12
pelo: luz #E0603A, base #B5432A, sombra #7A2A1A
rosto, mãos e pés: base #4A2A1E, sombra #2A1A14
camisa: creme #F5EBC8, folhas #6BA04A / #E8A030
suspensório: #5A3A1E
calça: luz #8A8A4A, base #6B6B34, sombra #4A4A22
fone: #1A1A1A, dourado #D9B860
óculos: #1A1A1A, lente #8A2A1A
boca: #C0303A, dentes #FAF6EE
```

## Interface (`art/ui/`)

### `retrato_bugio.png`

```text
Retrato em pixel art (busto) do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços. Virado em 3/4 olhando para a direita, berrando de felicidade no microfone, óculos escuros. Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.
```

### `apresentacao_bugio.png`

```text
Arte de apresentação (splash art cartoon de jogo de luta) do Berrante: bugio-ruivo humanizado, RADIALISTA grandalhão (concept escolhido anexado): pelo ruivo-avermelhado volumoso, barba ruiva cheia e papo inchado na garganta, rosto e mãos marrom-escuros, braços longos, rabo comprido enrolado em espiral; fone de ouvido preto e dourado, óculos escuros, camisa creme estampada de folhas verdes e laranja, suspensório marrom, calça verde-oliva dobrada, pés descalços, IGUAL ao concept anexado. Pose: anunciando no microfone com o dedo erguido, peito estufado, rabo enrolado em espiral. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. Mesmo estilo de art/ui/apresentacao_juba.png.
```
