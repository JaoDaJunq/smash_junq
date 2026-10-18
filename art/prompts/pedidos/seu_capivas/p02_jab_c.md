# Seu Capivas · jab_c (playtest 01, rodada 2)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

## Anexar (nesta ordem)

1. `art/conceitos/seu_capivas/folha_v1.png`
2. `art/pixel/seu_capivas/parado.png`
3. `art/pixel/seu_capivas/jab.png`

## Saída (não sobrescreve nada do jogo)

- `art/pixel/seu_capivas/candidatos/jab_c_v1.png` (5 quadros, células 1 a 5 (células 6 a 6 vazias))

## Prompt

```text
Folha de animação do Seu Capivas (capivara tiozão de clube, grandalhão e redondo, cabeça baixa encaixada num cangote largo, olhos semicerrados, laranjinha na cabeça, toalha azul no ombro, barrigão, bermuda florida azul, pochete, chinelo de dedo), 5 quadros.
Animação: ATAQUE BÁSICO 3 (finalização da sequência): empurrão de sumô com AS DUAS mãos espalmadas ao mesmo tempo, dando um passinho à frente. Mais forte que os tapas.
Quadros:
1) preparo: as duas mãos espalmadas recolhidas ao lado da barriga, peso para trás
2) passinho à frente, mãos começando a avançar
3) impacto: as duas palmas esticadas à frente na altura do peito, barriga empurrando junto
4) recolhendo as mãos
5) volta para a guarda

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
