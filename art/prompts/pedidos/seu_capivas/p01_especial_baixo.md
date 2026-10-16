# Seu Capivas · especial para baixo (a "sentada") sem efeitos

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Na tira atual do jogo (11 quadros) há poeira e onda de choque laranja desenhadas nos quadros do impacto (tira 4 a 8 = folha principal 3 a 5 e os intermediários entre eles), tracinhos embaixo dos pés no quadro 1, e sobras do quadro vizinho (pedacinhos soltos) nos quadros 2, 9 e 10 da tira. A onda de choque é efeito do jogo.

## Anexar (sempre, nesta ordem)

1. `art/conceitos/seu_capivas/folha_v1.png` (folha aprovada)
2. `art/pixel/seu_capivas/parado.png` (quadro aprovado: régua de escala e traço)
3. `art/pixel/seu_capivas/especial_baixo.png` (folha atual: poses de referência)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/seu_capivas/candidatos/especial_baixo_v2.png` (6 quadros)
- `art/pixel/seu_capivas/candidatos/especial_baixo_meio_v2.png` (5 intermediários)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

- `especial_baixo_v2.png`: 6 quadros, células 1 a 6.
- `especial_baixo_meio_v2.png`: 5 quadros, células 1 a 5 (célula 6 vazia).

## Prompt 1 · folha principal (`especial_baixo_v2.png`)

```text
Folha de animação do Seu Capivas (capivara tiozão de clube, grandalhão e redondo, cabeça baixa encaixada num cangote largo, olhos semicerrados, laranjinha na cabeça, toalha azul no ombro, barrigão, bermuda florida azul, pochete, chinelo de dedo), 6 quadros.
Animação: A SENTADA (especial para baixo). Só o Seu Capivas: sem poeira, sem onda, sem tracinhos, sem chão. O impacto aparece só no corpo (barriga e bochechas amassadas).
Quadros:
1) pulinho: joelhos dobrados, saindo do chão
2) no ar, sentando, bumbum para baixo
3) impacto: sentado com tudo, pernas curtas esticadas para a frente, barriga e bochechas amassadas para baixo
4) ainda sentado, barriga balançando, olhos fechados satisfeito
5) levantando, mãos nos joelhos
6) de pé, tranquilo

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Seu Capivas (use só estas cores):
contorno #3A0A12
pelo: luz #E8904A, base #D9773A, sombra #AA5522, sombra funda #7A3322
focinho e orelhas: #6E3424, #4E2216
laranjinha: #FF8A10, luz #FFB347, folha #6FAE44
toalha: base #7FC6EE, sombra #4FA0D8, listras #FFFFFF
bermuda: azul #12699A, azul escuro #0B4A70, flores #FF7A1A, folhas #77AA44
pochete: #26324A
chinelo: #1E73B8
olhos: branco #FFFFFF, pupila #2A1208
```

## Prompt 2 · intermediários (`especial_baixo_meio_v2.png`), depois do 1

```text
Anexei a folha "especial_baixo" NOVA do Seu Capivas (a que você acabou de gerar), a folha aprovada e o quadro "parado".
Desenhe os QUADROS INTERMEDIÁRIOS dessa animação, para o movimento ficar mais suave:
5 quadros, em ordem, um por célula: o quadro entre o 1 e o 2 da folha anexada, depois entre o 2 e o 3, e assim por diante.
Cada intermediário é exatamente a metade do caminho entre os dois quadros vizinhos: mesma posição dos pés, mesmo tamanho, mesmas cores, mesma roupa. Não redesenhe os quadros originais.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Seu Capivas (use só estas cores):
contorno #3A0A12
pelo: luz #E8904A, base #D9773A, sombra #AA5522, sombra funda #7A3322
focinho e orelhas: #6E3424, #4E2216
laranjinha: #FF8A10, luz #FFB347, folha #6FAE44
toalha: base #7FC6EE, sombra #4FA0D8, listras #FFFFFF
bermuda: azul #12699A, azul escuro #0B4A70, flores #FF7A1A, folhas #77AA44
pochete: #26324A
chinelo: #1E73B8
olhos: branco #FFFFFF, pupila #2A1208
```

## Conferência (Claude Code, antes de integrar)

- [ ] Quantidade de quadros e ordem certas; células que sobram vazias.
- [ ] Cada pose lado a lado com o `parado.png`: mesma altura, cabeça, contorno e cores.
- [ ] Sem chão, plataforma, cenário, rastro, poeira, linha de velocidade ou brilho.
- [ ] Checagem de ilhas em todas as folhas dos dois personagens depois de importar: `godot --headless --path game --script res://tools/checar_ilhas.gd`.
- [ ] Nenhum pixel solto em volta (sobras do quadro vizinho).

## Nota para a integração

O quadro de impacto continua o 3 da folha principal (`IMPACTO` do Seu Capivas em `importar_pixel.gd`: `especial_baixo: 2`).
