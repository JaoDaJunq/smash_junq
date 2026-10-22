# Seu Preguiçoso · pedidos de EFEITO (fx)

> Plano e regras de jogo: `design/revisao/novos_personagens.md`. Um chat de imagem por folha; anexar `art/pixel/juba/fx_folhas.png` (estilo) e `art/pixel/preguica/parado.png` ou o concept `art/concepts/preguica/escolhido.png` (cores e tamanho).
> Paleta do personagem: pelo cinza-amarronzado #8A7A62, máscara #3A2E22, camisa bege #C9B98A, calça oliva #6A6A3A, garrafa térmica verde #4A7A5A, café #5A3A1E, bolha de moleza azul-lavanda #BFD8F0/#8AB0D8. Contorno #2A0F12.
> Portão: conferir a folha em tamanho real (quadros de 64x64), no máximo 2 tentativas por folha; depois `importar_pixel.gd -- preguica`.

## Pedidos

### 01 · `fx_bolha_moleza` (efeito novo)

Salvar em `art/pixel/preguica/fx_bolha_moleza.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/preguica/parado.png` (ou `art/concepts/preguica/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Neutro "Bolha de moleza": borda da bolha de câmera lenta, em loop enquanto ela existe (4 s). O jogo desenha em px 4-5 (256-320 px na tela), então o desenho tem que ser só o ANEL, com o miolo vazio (magenta).

```text
EFEITO: BOLHA DE CÂMERA LENTA vista de lado. Um ANEL redondo fino (2 pixels de grossura) azul-lavanda #BFD8F0 com sombra #8AB0D8 e contorno #2A0F12, de 56 pixels de diâmetro, centralizado, com o MIOLO VAZIO (fundo magenta dentro). Na borda, 3 brilhinhos brancos e 4 pontinhos azuis flutuando devagar, e um caracolzinho espiral pequeno #8AB0D8 desenhado na borda de cima. 1) anel redondo · 2) anel levemente achatado na horizontal · 3) anel redondo, brilhos em outro lugar · 4) anel levemente achatado na vertical (loop de bolha mole). 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 02 · `fx_galho` (efeito novo)

Salvar em `art/pixel/preguica/fx_galho.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/preguica/parado.png` (ou `art/concepts/preguica/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Especial para cima "Pendura no galho": o galho aparece acima da cabeça (`above`) no impacto e some quando ele solta. 3 quadros, 0.6 s.

```text
OBJETO-EFEITO: GALHO DE ÁRVORE horizontal marrom #6A4A2A/#8A6A3A com 4 folhas verdes #4A8A3A e um cipózinho pendurado, uns 50 pixels de largura e 12 de altura, no meio do quadro. 1) galho surgindo com folhas brotando · 2) galho inteiro, balançando para baixo · 3) galho se desfazendo em 5 folhas caindo. 3 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 03 · `fx_cafe` (efeito novo)

Salvar em `art/pixel/preguica/fx_cafe.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/preguica/parado.png` (ou `art/concepts/preguica/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Especial para baixo "Hora do cafezinho": a cada 18 quadros perto da boca (`head`), enquanto toma café e cura. 4 quadros, 0.5 s.

```text
EFEITO: VAPOR DE CAFÉ QUENTINHO. 3 fios de vapor branco-creme #F5F0E6 com sombra #D8D0C0 subindo em ondinhas, e 2 coraçõezinhos pequenos laranja #E8822A subindo junto (conforto, cura). 1) vapor baixo · 2) vapor subindo em S · 3) vapor alto + corações · 4) sumindo no alto. Uns 24 pixels de largura e 36 de altura. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 04 · `fx_bolha_nariz` (efeito novo)

Salvar em `art/pixel/preguica/fx_bolha_nariz.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/preguica/parado.png` (ou `art/concepts/preguica/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Passivo: cochilando parado (cura devagar), no nariz (`nose`), em loop. Substitui as bolhas de sono da Maracajá para não repetir. 4 quadros, loop.

```text
EFEITO de desenho animado: BOLHA NO NARIZ de quem cochila. Uma bolha redonda transparente azul-clarinha #D8ECF8 com contorno #2A0F12 e um brilho branco, presa na ponta esquerda do desenho (onde fica o nariz), crescendo e diminuindo. 1) bolha pequena (6 px) · 2) média (10 px) · 3) grande (14 px) · 4) média de novo. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```
