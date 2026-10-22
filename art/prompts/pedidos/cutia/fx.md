# Cutia Ligeira · pedidos de EFEITO (fx)

> Plano e regras de jogo: `design/revisao/novos_personagens.md`. Um chat de imagem por folha; anexar `art/pixel/juba/fx_folhas.png` (estilo) e `art/pixel/cutia/parado.png` ou o concept `art/concepts/cutia/escolhido.png` (cores e tamanho).
> Paleta do personagem: pelo dourado-alaranjado #D98A3A, avental verde #3A8A4A, lenço verde de folhas, saquinho de papel #E8C890/#C9A060, castanhas marrons #7A3A1A/#B0602A, terra #7A4A22/#A8722E. Contorno #2A0F12.
> Portão: conferir a folha em tamanho real (quadros de 64x64), no máximo 2 tentativas por folha; depois `importar_pixel.gd -- cutia`.

## Já existem (não pedir de novo)

- `fx_cova` ✅ existe (cavando, baixo)
- `fx_estouro_castanha` ✅ existe (armadilha estoura)
- `castanha_enterrada.png` ✅ existe (objeto; falta importar e usar no código)
- `ourico` (rodada11/08) ❌ cancelado: o neutro continua sendo o saquinho

## Pedidos

### 01 · `fx_poeira_carrinho` (efeito novo)

Salvar em `art/pixel/cutia/fx_poeira_carrinho.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/cutia/parado.png` (ou `art/concepts/cutia/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Lado "Carrinhada": a cada 4 quadros ativos, atrás dos pés (`feet_behind`), só no chão. 4 quadros, 0.35 s.

```text
EFEITO de chão: POEIRA DE FEIRA atrás de um carrinho correndo para a DIREITA. Nuvenzinhas de poeira bege #D8C090/#B09868 baixas e achatadas saindo para a ESQUERDA, com 2 folhas de alface verde #6AB04A voando e 1 castanha marrom #7A3A1A pulando. Apoiado na base do quadro. 1) 2 nuvenzinhas pequenas · 2) nuvens maiores + folhas saltando · 3) nuvens se abrindo, folhas no alto · 4) restos sumindo. Uns 40 pixels de largura, até 20 de altura. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```

### 02 · `fx_saquinho_rasga` (efeito novo)

Salvar em `art/pixel/cutia/fx_saquinho_rasga.png`. Anexar: `art/pixel/juba/fx_folhas.png`, `art/pixel/cutia/parado.png` (ou `art/concepts/cutia/escolhido.png` se ainda não houver sprite) para o tamanho e as cores.

Uso no jogo: Neutro: saquinho acertando alguém (`proj_hit`, no alvo) ou parando no chão sem acertar (aí planta uma castanha). 4 quadros, 0.35 s.

```text
EFEITO: SAQUINHO DE PAPEL RASGANDO. Um saquinho de papel pardo #E8C890/#C9A060 cheio de castanhas marrons #7A3A1A/#B0602A estoura: o papel abre em 3 pedaços e 4 castanhas pulam para cima e para os lados. 1) saquinho inchando com um rasgo · 2) papel abrindo, castanhas saltando · 3) castanhas no alto, pedaços de papel voando · 4) pedacinhos caindo. Uns 36 pixels. 4 quadros.

Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png como referência de efeito). Sem texto, letras ou números.
```
