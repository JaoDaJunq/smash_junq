# Dona Onça · pedidos de EFEITO (fx)

> Plano e regras de jogo: `design/revisao/novos_personagens.md`. Um chat de imagem por folha; anexar `art/pixel/juba/fx_folhas.png` (estilo) e `art/pixel/onca/parado.png` ou o concept `art/concepts/onca/escolhido.png` (cores e tamanho).
> Paleta do personagem: pelagem amarela #E5A63A com rosetas pretas #1E1610, blazer escuro #2B2F3A, distintivo dourado #E8B83A/#FFE08A, óculos #1A1A1A. Contorno #2A0F12.
> Portão: conferir a folha em tamanho real (quadros de 64x64), no máximo 2 tentativas por folha; depois `importar_pixel.gd -- onca`.

## Já existem (não pedir de novo)

- `fx_algema` ✅ existe (hit da voz de prisão)

## Pedidos

### 01 · `fx_carimbo` (efeito novo (mesmo do pedido rodada11/05; não pedir duas vezes))

Salvar em `art/pixel/onca/fx_carimbo.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/onca/parado.png` (ou `art/concepts/onca/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Evento `ficha`: cada ficha anotada. Em cima da cabeça do alvo (`target_head`, segue o alvo). 3 quadros, 0.35 s.

```text
EFEITO: CARIMBO DE DELEGACIA. Um carimbo de madeira marrom #8A5A2E com cabo redondo desce e deixa uma ESTRELA DE DISTINTIVO dourada #E8B83A/#FFE08A de 5 pontas. 1) carimbo descendo (estrela ainda não aparece) · 2) carimbo batendo, com 4 tracinhos de pancada · 3) carimbo sumiu, só a estrela dourada com um brilho em cruz. Uns 28 pixels. 3 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 02 · `fx_rugido` (efeito novo (mesmo do pedido rodada11/07))

Salvar em `art/pixel/onca/fx_rugido.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/onca/parado.png` (ou `art/concepts/onca/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Neutro "Parado aí!", no impacto, saindo da boca (`front`). 4 quadros, 0.4 s.

```text
EFEITO de boca: BAFO DE ONÇA (NÃO é anel de som nem onda redonda). Arcos curtos e grossos amarelo-alaranjados #F5C060/#E5A63A saindo em CONE para a DIREITA, com 3 rosetas pretas #1E1610 de onça voando dentro do cone. 1) cone pequeno · 2) cone grande · 3) rosetas espalhando · 4) sumindo. Começa na borda esquerda do desenho e abre para a direita, uns 50 pixels de comprimento. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 03 · `faixa_interditado` (OBJETO de chão novo)

Salvar em `art/pixel/onca/faixa_interditado.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/onca/parado.png` (ou `art/concepts/onca/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Especial para baixo "Interditado!": barreira que fica 6 s no palco. Quadros 1-3 em loop (fita balançando), quadro 4 quando rasga. A base fica na linha de baixo do desenho.

```text
OBJETO de chão: ÁREA INTERDITADA. Dois cones de trânsito laranja #F08A1A com faixa branca, um em cada ponta, e uma FITA ZEBRADA amarela #F7C531 e preta #1E1610 esticada entre eles na altura do meio dos cones. Largura total 56 pixels, altura 22 pixels, apoiado na base do quadro (4 pixels acima da borda de baixo). 1) fita reta · 2) fita ondulando para cima · 3) fita ondulando para baixo · 4) fita rasgada no meio, as duas pontas caídas, cones tortos. Sem letras na fita. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```
