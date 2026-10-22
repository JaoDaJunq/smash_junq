# Tucão · pedidos de EFEITO (fx)

> Plano e regras de jogo: `design/revisao/novos_personagens.md`. Um chat de imagem por folha; anexar `art/pixel/juba/fx_folhas.png` (estilo) e `art/pixel/tucano/parado.png` ou o concept `art/concepts/tucano/escolhido.png` (cores e tamanho).
> Paleta do personagem: penas pretas #1A1A1A, peito creme #F5F0E6, bico laranja #F08A1A, anel azul #3FA0E0, avental vermelho #D23A2A e branco, pipoca creme #FAF6EE/#E8DCB0 com miolo #F7C531. Contorno #2A0F12.
> Portão: conferir a folha em tamanho real (quadros de 64x64), no máximo 2 tentativas por folha; depois `importar_pixel.gd -- tucano`.

## Já existem (não pedir de novo)

- `fx_pipoca_estouro` ✅ existe (hit da pipoca; também a chuva do Gol)
- `fx_grama_peixinho` ✅ existe (lado no chão)
- `fx_bico_entalado` ✅ existe (baixo no chão)

## Pedidos

### 01 · `pipoca` (projétil do neutro · REFAZER (a anterior veio grande))

Salvar em `art/pixel/tucano/pipoca.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/tucano/parado.png` (ou `art/concepts/tucano/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Neutro: 3 pipocas em arco. O jogo também ajusta a escala (`set_sprite_fit`, 20 px na tela), mas a folha tem que vir pequena.

```text
PROJÉTIL MINÚSCULO: UMA pipoca estourada branca-creme #FAF6EE com sombra #E8DCB0 e miolo amarelo #F7C531, contorno 1 px #2A0F12. TAMANHO: a pipoca ocupa SÓ 10x10 pixels do quadro de 64x64 (na célula ampliada de 512 px ela mede uns 80 px; todo o resto da célula é magenta). Formato de florzinha com 4-5 gomos arredondados. 1) pipoca de pé · 2) a mesma pipoca girada 90 graus · 3) girada 180 graus · 4) girada 270 graus. Mesmo tamanho nos 4 quadros. NÃO desenhe pipoca grande, saquinho, nem várias pipocas. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 02 · `fx_trave_tranco` (efeito novo)

Salvar em `art/pixel/tucano/fx_trave_tranco.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/tucano/parado.png` (ou `art/concepts/tucano/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Duas utilidades: (1) evento `armor`, quando o bico blindado aguenta uma pancada (px 1.5, no peito, `center`); (2) peixinho batendo na trave/parede (px 2, `head`). 4 quadros, 0.3 s.

```text
EFEITO de pancada seca: TRANCO NO BICO. Estrela de impacto laranja #F08A1A/#FFC060 de 6 pontas no centro, com 2 lasquinhas pretas #1A1A1A e 3 estrelinhas amarelas #F7C531 girando em volta (como quem bateu a cabeça na trave), mais 2 tracinhos curtos de 'tóim' saindo para cima. 1) estrela pequena · 2) estrela grande + lascas · 3) estrelinhas girando em volta · 4) estrelinhas sumindo. Uns 34 pixels. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```
