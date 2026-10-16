# Seu Capivas · borda sem plataforma

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Igual ao Juba: a folha `borda` atual tem a plataforma (faixa azul-escura) desenhada em todos os quadros, e há tracinhos de esforço embaixo dos pés nos quadros pendurados (tira 1, 2 e 7).

## Anexar (sempre, nesta ordem)

1. `art/conceitos/seu_capivas/folha_v1.png` (folha aprovada)
2. `art/pixel/seu_capivas/parado.png` (quadro aprovado: régua de escala e traço)
3. `art/pixel/seu_capivas/borda.png` (folha atual: copiar as poses, sem a plataforma)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/seu_capivas/candidatos/borda_v2.png` (6 quadros)
- `art/pixel/seu_capivas/candidatos/borda_meio_v2.png` (5 intermediários)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

- `borda_v2.png`: 6 quadros, células 1 a 6.
- `borda_meio_v2.png`: 5 quadros, células 1 a 5 (célula 6 vazia).

## Prompt 1 · folha principal (`borda_v2.png`)

```text
Folha de animação do Seu Capivas (capivara tiozão de clube, grandalhão e redondo, cabeça baixa encaixada num cangote largo, olhos semicerrados, laranjinha na cabeça, toalha azul no ombro, barrigão, bermuda florida azul, pochete, chinelo de dedo), 6 quadros.
Animação: BORDA (pendurado na beirada e subindo). Use as MESMAS poses e posições da folha "borda" anexada, mas SEM a plataforma e sem tracinhos: as mãos seguram uma quina que não aparece (o jogo desenha a plataforma). Nos quadros 1 a 3 as mãos ficam no mesmo lugar da célula.
Quadros:
1) pendurado com esforço pelas mãos, olhos arregalados
2) balançando
3) puxando o corpo
4) barriga apoiada numa quina invisível na altura das mãos, corpo dobrado
5) de pé
6) volta, tranquilo

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

## Prompt 2 · intermediários (`borda_meio_v2.png`), depois do 1

```text
Anexei a folha "borda" NOVA do Seu Capivas (a que você acabou de gerar), a folha aprovada e o quadro "parado".
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
- [ ] Nenhuma faixa de plataforma, nem um pixel dela.
- [ ] Mãos dos quadros 1 a 3 no mesmo lugar.
