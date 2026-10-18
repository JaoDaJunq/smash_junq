# Juba · pendurado (playtest 01, rodada 2)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

## Anexar (nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg`
2. `art/pixel/juba/parado.png`
3. `art/pixel/juba/borda.png`

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/pendurado_v1.png` (2 quadros, células 1 a 2 (células 3 a 6 vazias))

## Prompt

```text
Folha de animação do Juba (mico-leão-dourado capoeirista, juba enorme laranja-dourada, faixa verde na testa, calça de abadá branca com cordão verde e amarelo, sem camisa, cauda longa enrolada na ponta, mãos e pés marrons), 2 quadros.
Animação: PENDURADO NA BORDA (pose parada, estilo Brawlhalla): segura a quina da plataforma com UMA mão só, o braço esticado para cima; o resto do corpo pendurado solto abaixo, de lado, olhando para a DIREITA. A mão que segura fica no MESMO pixel nos dois quadros: ponta dos dedos na linha 6 do quadro de 64x64, na coluna 40. A plataforma NÃO aparece.
Quadros:
1) pendurado por uma mão, pernas soltas, outra mão relaxada ao lado do corpo, cauda pendendo
2) igual ao 1, com o corpo balançado 1 pixel e a cauda mexendo (respiração)

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando ele está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção da folha aprovada e do quadro "parado" anexados. Compare lado a lado: mesma altura, mesmo tamanho de cabeça, mesma grossura de contorno. Só a pose muda.
- Cada quadro tem SÓ o personagem e o que ele segura na mão. Proibido: chão, plataforma, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas, brilhos, estrelinhas, gotas, fumaça ou auras (o jogo faz os efeitos); nada preso a algo fora do quadro (cipó, corda).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```
