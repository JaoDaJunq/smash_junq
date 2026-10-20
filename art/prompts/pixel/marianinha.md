# marianinha · paleta e regras de pixel art

Pedidos completos: `art/prompts/pedidos/marianinha/todos.md`.

```text
Paleta da Marianinha (use só estas cores):
contorno #2A0F12
cabeça: luz #FFD24A, base #F5A623, sombra #D97A12
barriga e bochechas: branco #F8F4EC, sombra #DCD4C4
asas e costas: luz #7ED957, base #4CAF50, sombra #2E7A34
collant e laço: luz #FF8CB8, base #E8508A, sombra #B03068, brilho #FFD6E7
munhequeiras: #FFFFFF
bico, pernas e pés: base #C9A9A6, sombra #9C7F7C
olhos: #6A3A14, brilho #FFFFFF
```

```text
Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 38 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).
```
