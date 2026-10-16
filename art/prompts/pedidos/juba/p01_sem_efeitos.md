# Juba · folhas refeitas sem efeitos desenhados

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

A auditoria do playtest 01 achou efeitos desenhados no sprite do Juba: rastros curvos nos chutes, rastro circular no parafuso, estrelinhas do tonto, poeira da freada e a castanha voando dentro do quadro do arremesso (ela agora é um sprite separado, pedido `p01_castanha.md`). O especial para cima com cipó é substituído (pedido `p01_especial_cima_sumico.md`) e a `borda` tem pedido próprio.

## Anexar (sempre, nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg` (folha aprovada)
2. `art/pixel/juba/parado.png` (quadro aprovado: régua de escala e traço)
3. a folha atual indicada em cada prompt (`art/pixel/juba/<animacao>.png` e, quando houver, `art/pixel/juba/<animacao>_meio.png`)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/golpe_frente_v2.png` (5 quadros)
- `art/pixel/juba/candidatos/golpe_frente_meio_v2.png` (4 intermediários)
- `art/pixel/juba/candidatos/golpe_cima_v2.png` (5 quadros)
- `art/pixel/juba/candidatos/golpe_baixo_v2.png` (5 quadros)
- `art/pixel/juba/candidatos/aereo_neutro_v2.png` (5 quadros)
- `art/pixel/juba/candidatos/especial_neutro_v2.png` (6 quadros)
- `art/pixel/juba/candidatos/especial_neutro_meio_v2.png` (5 intermediários)
- `art/pixel/juba/candidatos/tonto_pulo_duplo_v2.png` (6 quadros)
- `art/pixel/juba/candidatos/transicoes_b_v2.png` (6 quadros)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

Uma imagem por arquivo de saída, com a quantidade de quadros indicada. Gere na ordem dos prompts; cada `_meio_v2` depois da sua folha principal.

## golpe_frente · folha principal (`golpe_frente_v2.png`)

```text
Anexei a folha "golpe_frente" do Juba que está no jogo (`art/pixel/juba/golpe_frente.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 5 quadros na mesma grade.
Animação: Martelo (chute lateral alto)
Quadros: 1) preparo, joelho sobe · 2) perna girando · 3) impacto: perna esticada na altura da cabeça · 4) perna voltando · 5) guarda
Mude só isto: apague o rastro curvo laranja na frente da perna (quadro 3). Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## golpe_frente · intermediários (`golpe_frente_meio_v2.png`)

```text
Anexei a folha de intermediários "golpe_frente_meio" do Juba que está no jogo (`art/pixel/juba/golpe_frente_meio.png`) e a folha "golpe_frente" NOVA que você acabou de gerar. Redesenhe a MESMA folha de intermediários, quadro por quadro (4 quadros, mesma grade): cada um continua sendo a metade do caminho entre os dois quadros vizinhos da folha nova.
Mude só isto: apague os efeitos desenhados: rastro curvo (intermediário 3-4). Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## golpe_cima · folha principal (`golpe_cima_v2.png`)

```text
Anexei a folha "golpe_cima" do Juba que está no jogo (`art/pixel/juba/golpe_cima.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 5 quadros na mesma grade.
Animação: Meia-lua de frente
Quadros: 1) preparo · 2) perna subindo pela frente · 3) impacto: perna no alto, acima da cabeça · 4) perna descendo · 5) guarda
Mude só isto: apague o rastro curvo laranja da meia-lua (quadros 3 e 4). Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## golpe_baixo · folha principal (`golpe_baixo_v2.png`)

```text
Anexei a folha "golpe_baixo" do Juba que está no jogo (`art/pixel/juba/golpe_baixo.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 5 quadros na mesma grade.
Animação: Rasteira
Quadros: 1) agachando, mão no chão · 2) perna começa a varrer · 3) impacto: perna esticada rente ao chão · 4) recolhendo · 5) levantando
Mude só isto: apague o rastro amarelo embaixo da perna (quadro 3). Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## aereo_neutro · folha principal (`aereo_neutro_v2.png`)

```text
Anexei a folha "aereo_neutro" do Juba que está no jogo (`art/pixel/juba/aereo_neutro.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 5 quadros na mesma grade.
Animação: Parafuso no ar
Quadros: 1) encolhido · 2) girando, pernas abrindo · 3) impacto: pernas abertas no giro · 4) terminando o giro · 5) encolhido
Mude só isto: apague o rastro circular laranja e branco em volta do giro (quadro 3). Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## especial_neutro · folha principal (`especial_neutro_v2.png`)

```text
Anexei a folha "especial_neutro" do Juba que está no jogo (`art/pixel/juba/especial_neutro.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 6 quadros na mesma grade.
Animação: Arremesso de castanha
Quadros: 1) pega a castanha · 2) braço para trás · 3) arremesso por cima do ombro · 4) braço esticado à frente, mão aberta, a castanha já saiu · 5) braço à frente · 6) guarda
Mude só isto: apague a castanha voando na frente da mão (quadro 4): depois que sai da mão, a castanha é um sprite separado do jogo. Nos quadros 1 a 3 ela continua na mão. Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## especial_neutro · intermediários (`especial_neutro_meio_v2.png`)

```text
Anexei a folha de intermediários "especial_neutro_meio" do Juba que está no jogo (`art/pixel/juba/especial_neutro_meio.png`) e a folha "especial_neutro" NOVA que você acabou de gerar. Redesenhe a MESMA folha de intermediários, quadro por quadro (5 quadros, mesma grade): cada um continua sendo a metade do caminho entre os dois quadros vizinhos da folha nova.
Mude só isto: apague os efeitos desenhados: castanha voando (intermediário 4-5). Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## tonto_pulo_duplo · folha principal (`tonto_pulo_duplo_v2.png`)

```text
Anexei a folha "tonto_pulo_duplo" do Juba que está no jogo (`art/pixel/juba/tonto_pulo_duplo.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 6 quadros na mesma grade.
Animação: Tonto (quadros 1 e 2) e pulo duplo (quadros 3 a 6)
Quadros: 1) tonto, olhos girando · 2) tonto balançando · 3) pulo duplo: cambalhota começa · 4) de cabeça para baixo · 5) terminando · 6) abrindo
Mude só isto: apague as estrelinhas amarelas em volta da cabeça (quadros 1 e 2); o tonto aparece só no rosto e na postura. Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## transicoes_b · folha principal (`transicoes_b_v2.png`)

```text
Anexei a folha "transicoes_b" do Juba que está no jogo (`art/pixel/juba/transicoes_b.png`). Redesenhe a MESMA folha, quadro por quadro: mesmas poses, mesmas posições na célula, mesmo tamanho e mesmas cores, 6 quadros na mesma grade.
Animação: Freada (quadros 1 a 3) e pouso (quadros 4 a 6)
Quadros: 1) pés derrapando à frente, corpo inclinado para trás · 2) ainda derrapando, braços abertos para se equilibrar · 3) voltando à guarda · 4) tocando o chão, joelhos começando a dobrar · 5) agachado absorvendo o impacto, juba caída para a frente · 6) levantando para a guarda
Mude só isto: apague a poeira bege nos pés (quadros 1 e 2). Onde o efeito cobria o personagem, complete o desenho dele. Fora isso, nada muda.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## Conferência (Claude Code, antes de integrar)

- [ ] Quantidade de quadros e ordem certas; células que sobram vazias.
- [ ] Cada pose lado a lado com o `parado.png`: mesma altura, cabeça, contorno e cores.
- [ ] Sem chão, plataforma, cenário, rastro, poeira, linha de velocidade ou brilho.
- [ ] Checagem de ilhas em todas as folhas dos dois personagens depois de importar: `godot --headless --path game --script res://tools/checar_ilhas.gd`.
- [ ] Comparar cada quadro com a folha atual: só os efeitos sumiram, as poses são as mesmas.
