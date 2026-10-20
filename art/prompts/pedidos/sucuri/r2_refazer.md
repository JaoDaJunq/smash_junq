# Mestra Sucuri · refação das folhas quebradas (rodada 7b)

No jogo, estas folhas aparecem quebradas (corpo cortado pela borda da célula, pedaços de cauda soltos, troca de ângulo/tamanho entre quadros). As antigas foram movidas para `art/pixel/sucuri/candidatos/v1/` junto com os `_meio` delas.

Anexe SEMPRE: `art/concepts/sucuri/escolhido.png`, `art/pixel/sucuri/base.png` e `art/pixel/sucuri/parado.png` (depois de refeito, o NOVO). Refaça primeiro o `parado.png`.

## `parado.png` (4 quadros)

Problema da versão anterior: os quadros mudavam de tamanho e de ângulo (alguns de 3/4), o que fazia ela piscar parada.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Guarda balançando (loop)
Quadros:
1) guarda, cauda enrolada · 2) corpo sobe um pouco ondulando · 3) inclina à frente · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `especial_lado.png` (6 quadros)

Problema da versão anterior: a cauda atravessava 2 células: o corpo saía cortado ao meio e um pedaço de cauda aparecia solto. Agora: pose COMPACTA de arremesso (tronco girado, cauda saindo para a frente só até a borda da área livre, com a ponta em laço). O jogo desenha o resto da cauda esticada (folha `laco_cauda.png`).

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Laço de cauda (estica e puxa)
Quadros:
1) gira o tronco · 2) cauda lançada à frente · 3) impacto: cauda esticada longe à frente, ponta enrolada em laço · 4) puxando de volta · 5) cauda voltando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `jab_c.png` (4 quadros)

Problema da versão anterior: a chicotada passava da célula e vinham pedaços soltos da vizinha; a ponta da cauda estala à frente sem sair da área livre.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Ataque básico 3: chicotada curta de cauda
Quadros:
1) gira o tronco · 2) ponta da cauda vem por trás · 3) impacto: ponta da cauda estalando à frente · 4) volta

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `dor.png` (4 quadros)

Problema da versão anterior: vinham pedaços soltos da célula vizinha e o corpo cortado.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 4 quadros.
Animação: Levando golpe
Quadros:
1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `aereo_frente.png` (5 quadros)

Problema da versão anterior: o corpo esticado saía cortado na borda esquerda e a cauda vinha separada.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Bote no ar
Quadros:
1) recua · 2) avançando · 3) impacto: corpo esticado à frente, boca aberta · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `aereo_tras.png` (5 quadros)

Problema da versão anterior: a cauda para trás saía cortada na borda esquerda.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Chicotada de cauda para trás
Quadros:
1) olhando para trás · 2) cauda vindo · 3) impacto: cauda estalando para TRÁS (esquerda) · 4) voltando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `golpe_frente.png` (5 quadros)

Problema da versão anterior: o bote esticado saía cortado na borda esquerda e mudava de tamanho.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Bote (cabeçada esticando o corpo)
Quadros:
1) recua o tronco · 2) avançando · 3) impacto: corpo esticado bem à frente, cabeça na frente · 4) recolhendo · 5) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `defesa_esquiva.png` (6 quadros)

Problema da versão anterior: o rolamento saía cortado e mudava muito de tamanho.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Escudo e esquiva
Quadros:
ESCUDO: 1) braços cruzados na frente do rosto, cauda enrolada em volta · 2) mesma pose. ESQUIVA: 3) se jogando de lado · 4) rolando enrolada como uma roda · 5) desenrolando · 6) guarda

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `transicoes_a.png` (6 quadros)

Problema da versão anterior: o arrancar (quadros 4-6) saía cortado na borda esquerda.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 6 quadros.
Animação: Virar e arrancar (duas animações na mesma folha)
Quadros:
VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `aereo_baixo.png` (5 quadros)

Problema da versão anterior: a mola saía cortada no alto e na direita.

```text
Folha de animação do Mestra Sucuri: sucuri-verde humanizada, mestra de jiu-jitsu calma e sorridente (concept escolhido anexado): tronco em pé com dois braços e, no lugar das pernas, uma CAUDA grossa enrolada no chão; escamas verde-oliva com manchas pretas arredondadas, barriga amarelo-creme com placas, cabeça pequena de cobra com olhos laranja, coque com dois palitinhos; kimono verde-musgo BEM FECHADO no peito (gola cruzada alta, sem decote), faixa PRETA amarrada na cintura, 5 quadros.
Animação: Cai enrolada como mola
Quadros:
1) enrolando · 2) mola apontando para baixo · 3) impacto: mola esticada para baixo · 4) quicando · 5) recolhida

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## `laco_cauda.png` (novo, 2 quadros)

```text
Sprite separado (sem personagem) de um PEDAÇO DE CAUDA de sucuri visto de lado, para o jogo repetir e esticar: escamas verde-oliva com manchas pretas arredondadas e barriga amarelo-creme por baixo, contorno 1 px #2A0F12. Quadro 1: trecho reto de cauda com 40 px de largura e 10 px de altura, que emenda perfeitamente consigo mesmo à esquerda e à direita (repetível). Quadro 2: a PONTA da cauda enrolada em laço (argola), com uns 20x20 px. Cada quadro centralizado na sua célula. Mesmas regras de grade, fundo magenta e paleta abaixo; sem texto.

Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

## Intermediários

Depois das folhas acima, refaça os `_meio` de `parado`, `golpe_frente`, `aereo_frente`, `aereo_tras` e `aereo_baixo` como em `todos.md` (lote 3), com a regra de caber no quadro. Se o gerador atingir o limite, **PARE e avise**: nunca monte quadros à mão.
