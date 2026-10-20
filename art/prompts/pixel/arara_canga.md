# arara_canga · paleta e regras de pixel art

Pedidos completos: `art/prompts/pedidos/arara_canga/todos.md`.

```text
Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008
```

```text
Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).
```
