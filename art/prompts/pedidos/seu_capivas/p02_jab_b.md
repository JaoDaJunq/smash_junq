# Seu Capivas · jab_b (playtest 01, rodada 2)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

## Anexar (nesta ordem)

1. `art/conceitos/seu_capivas/folha_v1.png`
2. `art/pixel/seu_capivas/parado.png`
3. `art/pixel/seu_capivas/jab.png`

## Saída (não sobrescreve nada do jogo)

- `art/pixel/seu_capivas/candidatos/jab_b_v1.png` (3 quadros, células 1 a 3 (células 4 a 6 vazias))

## Prompt

```text
Folha de animação do Seu Capivas (capivara tiozão de clube, grandalhão e redondo, cabeça baixa encaixada num cangote largo, olhos semicerrados, laranjinha na cabeça, toalha azul no ombro, barrigão, bermuda florida azul, pochete, chinelo de dedo), 3 quadros.
Animação: ATAQUE BÁSICO 2 (tapa de sumô com a OUTRA mão). É o segundo golpe da sequência de três; o primeiro é o tapa da folha "jab" anexada. Este usa a mão de TRÁS, com o barrigão girando junto.
Quadros:
1) preparo: mão de trás espalmada recolhida junto à barriga
2) tapa de sumô esticado à frente com a mão de trás, palma aberta, barriga girada
3) volta para a guarda

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
