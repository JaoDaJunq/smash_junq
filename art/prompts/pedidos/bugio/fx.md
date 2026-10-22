# Berrante · pedidos de EFEITO (fx)

> Plano e regras de jogo: `design/revisao/novos_personagens.md`. Um chat de imagem por folha; anexar `art/pixel/juba/fx_folhas.png` (estilo) e `art/pixel/bugio/parado.png` ou o concept `art/concepts/bugio/escolhido.png` (cores e tamanho).
> Paleta do personagem: pelo ruivo #B5432A, barba #7A2A1A, rosto #2A1A14, fone preto e dourado #E8B83A, camisa creme #F2E6C8 com folhas verdes #4A8A3A e laranja #E8822A; ondas de som creme #F5F0E6 com borda laranja #E8822A. Contorno #2A0F12.
> Portão: conferir a folha em tamanho real (quadros de 64x64), no máximo 2 tentativas por folha; depois `importar_pixel.gd -- bugio`.

## Pedidos

### 01 · `fx_berro` (efeito novo)

Salvar em `art/pixel/bugio/fx_berro.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/bugio/parado.png` (ou `art/concepts/bugio/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Neutro "Berro" no impacto, saindo da boca (`front`), px 2/2.5/3 conforme o volume. O especial para cima usa a mesma folha girada 90 graus, embaixo dele (`below`). 4 quadros, 0.4 s.

```text
EFEITO de som: BERRO DE RADIALISTA. Três arcos de som grossos em forma de parêntese ')' creme #F5F0E6 com borda laranja #E8822A, saindo para a DIREITA, cada um maior que o anterior, com 2 folhas verdes #4A8A3A sopradas entre eles. 1) 1 arco pequeno colado na borda esquerda · 2) 2 arcos · 3) 3 arcos grandes e folhas voando · 4) arcos se desfazendo em tracinhos. Uns 52 pixels de comprimento, 40 de altura. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 02 · `fx_susto` (efeito novo)

Salvar em `art/pixel/bugio/fx_susto.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/bugio/parado.png` (ou `art/concepts/bugio/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Especial para baixo "Teste do som": em cima da cabeça de cada um que pulou de susto (`target_head`). 3 quadros, 0.4 s.

```text
EFEITO de susto em volta da cabeça: 3 gotas de suor azuis #5AB0E8 voando para os lados e 4 tracinhos curtos de susto vinho #2A0F12 irradiando para cima, em leque. 1) tracinhos curtos · 2) tracinhos longos + gotas saltando · 3) gotas caindo, tracinhos sumindo. Uns 32 pixels de largura. Sem ponto de exclamação nem letras. 3 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 03 · `fx_rouco` (efeito novo)

Salvar em `art/pixel/bugio/fx_rouco.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/bugio/parado.png` (ou `art/concepts/bugio/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Mecânica "Volume": quando fica rouco e a cada berro rouco, perto da boca (`nose`). 4 quadros, 0.5 s.

```text
EFEITO: PIGARRO / ROUQUIDÃO. Nuvenzinha cinza #A8A0A0/#787070 saindo para a direita em 2 bolotas tortas, com 2 bolinhas pretas de 'cof' e uma risquinha em zigue-zague apagada. Parece uma tossida de desenho animado, pequena e sem força. 1) bolota pequena · 2) duas bolotas · 3) bolotas murchando · 4) sumindo. Uns 26 pixels. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 04 · `fx_microfonia` (efeito novo)

Salvar em `art/pixel/bugio/fx_microfonia.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/bugio/parado.png` (ou `art/concepts/bugio/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Berro MÁXIMO (volume cheio) na boca (`front`, px 3) e ponta do fio do microfone acertando (`target`). 4 quadros, 0.35 s.

```text
EFEITO: MICROFONIA. Estouro de som estridente: 2 raios em zigue-zague amarelos #F7C531 com borda laranja #E8822A cruzados num X, uma estrela de impacto branca-creme #F5F0E6 no centro e 4 arcos curtos ')' em volta. 1) estrela pequena · 2) raios em X abrindo · 3) tudo grande, arcos em volta · 4) restos sumindo. Uns 44 pixels. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```
