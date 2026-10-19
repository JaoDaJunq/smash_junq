# Maracajá · andar_meio (lote 3)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

## Anexar
1. `art/concepts/maracaja/escolhido.png`
2. `art/pixel/maracaja/base.png`
3. `art/pixel/juba/parado.png (só referência de escala e estilo de pixel, NÃO copie o personagem)`
4. `art/pixel/maracaja/andar.png`

## Saída
- `art/pixel/maracaja/andar_meio.png` (6 quadros)

## Prompt

```text
Folha de animação do Maracajá: jaguatirica humanizada malandra (concept escolhido anexado), magro e comprido, postura um pouco agachada de gato, cauda longa com rosetas, orelhas redondas, pelagem ocre-dourada com rosetas e listras marrom-escuras, barriga e focinho creme, olhos verdes semicerrados; camisa de botão aberta branca com estampa de folhas verdes, corrente dourada fina, faixa branca no antebraço, calça bege dobrada na canela, chinelo de dedo com tira verde-limão, palito no canto da boca, 6 quadros.
Animação: Intermediários de andar
Quadros:
Quadros INTERMEDIÁRIOS da folha "andar" anexada: cada quadro desenha a pose exatamente no meio entre dois quadros vizinhos da folha principal: 1) entre o 1 e o 2 · 2) entre o 2 e o 3 · ... e o último entre o último quadro e o primeiro (é um loop). O personagem não muda de lugar nem de tamanho: só a pose fica no meio do caminho.

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel na cor de contorno da paleta. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está de pé, os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (personagem com cerca de 46 pixels de altura de pé). Só a pose muda.
- Cada quadro tem SÓ o personagem. Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, arranhões desenhados no ar, brilhos ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura.

Paleta do Maracajá (use só estas cores):
contorno #2A0F12
pelo: luz #F2B868, base #D99A4E, sombra #B0732F, sombra funda #7E4E1E
rosetas e listras: #3E2414
barriga, focinho e mãos claras: luz #FBF0D8, base #F3E3C3, sombra #D8C29A
olhos: verde #8FBF2A, pupila #1A1008, branco #FFFFFF
nariz e dentro da orelha: #C46A6A
camisa: base #F4F1E2, sombra #D6D2BA, folhas #7FBF3A, folhas escuras #3F7A2A
calça: base #DAD2BC, sombra #B3A88C
chinelo: sola #6B4A2A, tira #B6DD3C
corrente e palito: #E8C25A
```
