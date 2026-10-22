# Calango · pedidos de EFEITO (fx)

> Plano e regras de jogo: `design/revisao/novos_personagens.md`. Um chat de imagem por folha; anexar `art/pixel/juba/fx_folhas.png` (estilo) e `art/pixel/calango/parado.png` ou o concept `art/concepts/calango/escolhido.png` (cores e tamanho).
> Paleta do personagem: escamas verde-oliva #8A8A3A com pintas creme #E8E0B0, barriga #E8D48A, areia de praia #E8D48A/#C9A860, chapéu de palha #D8B060, lágrima azul #5AB0E8. Contorno #2A0F12.
> Portão: conferir a folha em tamanho real (quadros de 64x64), no máximo 2 tentativas por folha; depois `importar_pixel.gd -- calango`.

## Já existem (não pedir de novo)

- `fx_sol` ✅ existe (tomar sol, cada nível)

## Pedidos

### 01 · `areia` (projétil do neutro (mesmo do pedido rodada11/12))

Salvar em `art/pixel/calango/areia.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/calango/parado.png` (ou `art/concepts/calango/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Neutro "Joga areia": projétil curto (0.25 s) e reto. O jogo ajusta a escala.

```text
PROJÉTIL: PUNHADO DE AREIA de praia amarela #E8D48A com sombra #C9A860, em leque se abrindo para a DIREITA, grãos soltos (blocos de 1-2 pixels), sem contorno nos grãos, contorno só no miolo do punhado. 1) punhado fechado (uns 10 pixels) · 2) leque abrindo (20 pixels) · 3) leque bem aberto e ralo (30 pixels). 3 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 02 · `fx_areia_olho` (efeito novo (mesmo do pedido rodada11/13))

Salvar em `art/pixel/calango/fx_areia_olho.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/calango/parado.png` (ou `art/concepts/calango/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Areia acertando: em cima da cabeça do alvo (`target_head`, segue o alvo), em loop enquanto ele está cego (2.5 s).

```text
EFEITO em volta da cabeça: AREIA NOS OLHOS. Grãozinhos de areia amarela #E8D48A/#C9A860 girando num anel achatado (como estrelinhas de tontura, mas de areia) e 2 lagriminhas azuis #5AB0E8 caindo no meio. Anel de uns 30 pixels de largura e 10 de altura. 1) grãos à esquerda · 2) grãos na frente · 3) grãos à direita · 4) grãos atrás (loop girando), lágrimas descendo um pouco a cada quadro. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 03 · `fx_poeira_corrida` (efeito novo)

Salvar em `art/pixel/calango/fx_poeira_corrida.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/calango/parado.png` (ou `art/concepts/calango/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Lado "Corrida de calango": a cada 3 quadros ativos atrás dos pés (`feet_behind`); subindo parede, no ponto da parede (`wall`). 4 quadros, 0.3 s.

```text
EFEITO de chão: JATO DE AREIA DE CORRIDA para alguém correndo para a DIREITA. Esguichos curtos de areia #E8D48A/#C9A860 saindo para a ESQUERDA e para cima, em arco, com grãos soltos, apoiados na base do quadro. 1) esguicho pequeno · 2) esguicho maior em arco · 3) grãos espalhados no ar · 4) grãos caindo e sumindo. Uns 36 pixels de largura, até 22 de altura. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 04 · `fx_rabo_poof` (efeito novo)

Salvar em `art/pixel/calango/fx_rabo_poof.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/calango/parado.png` (ou `art/concepts/calango/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Mecânica "Rabo solto": no instante em que o rabo se solta, atrás dele (`behind`). Cartoon, SEM sangue. 4 quadros, 0.4 s.

```text
EFEITO cartoon: POOF DE FUGA. Nuvenzinha branca #F5F0E6 com sombra #C8C0B0 estourando em 3 bolotas redondas, com 2 estrelinhas amarelas #F7C531 e 3 tracinhos de velocidade saindo para a direita. Nada de sangue, ferida ou corte: é só fumacinha de desenho animado. 1) nuvem pequena · 2) nuvem grande com estrelas · 3) nuvem abrindo em bolotas · 4) bolotas sumindo. Uns 34 pixels. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 05 · `rabo_solto` (objeto de chão · OPCIONAL (substitui `rabo.png`, que tem só 2 quadros e grade fora do padrão))

Salvar em `art/pixel/calango/rabo_solto.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/calango/parado.png` (ou `art/concepts/calango/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Rabo que fica 4 s no chão como isca. O código usa o número de quadros que vier.

```text
OBJETO de chão: RABO DE CALANGO SOLTO se mexendo, desenho animado e fofo (sem sangue, ponta cortada reta e lisa, da cor das escamas). Cauda fina e comprida verde-oliva #8A8A3A com pintas creme #E8E0B0 e barriga #E8D48A, uns 34 pixels de comprimento e 8 de grossura, deitado na base do quadro (4 pixels acima da borda de baixo). 1) curvado em S para cima · 2) reto com a ponta erguida · 3) curvado em S para baixo · 4) ponta dando um pulinho. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```
