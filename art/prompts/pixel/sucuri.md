# sucuri · paleta e regras de pixel art

Pedidos completos: `art/prompts/pedidos/sucuri/todos.md`.

```text
Paleta da Mestra Sucuri (use só estas cores):
contorno #2A0F12
escamas: luz #9AA84A, base #6B7A2E, sombra #4A561E
manchas: #1E2412
barriga: luz #F4E6A8, base #E8D48A, sombra #BFA860
kimono: luz #5C7A52, base #3F5A3A, sombra #2A3E28
faixa: #1A1A1A
olhos: #F08A24, pupila #1A1008
palitinhos do coque: #C98A4A
```

```text
Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés ou a cauda apoiada) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 50 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).
```
