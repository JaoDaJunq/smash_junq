# Juba · descanso (novo)

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Pose nova para a plataforma de volta (depois de um KO), que hoje usa um quadro do pulo. Sentado, em loop suave.

## Anexar (sempre, nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg` (folha aprovada)
2. `art/pixel/juba/parado.png` (quadro aprovado: régua de escala e traço)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/descanso_v1.png` (4 quadros)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

4 quadros, células 1 a 4; células 5 e 6 vazias.

## Prompt

```text
Folha de animação do Juba (mico-leão-dourado capoeirista, juba enorme laranja-dourada, faixa verde na testa, calça de abadá branca com cordão verde e amarelo, sem camisa, cauda longa enrolada na ponta, mãos e pés marrons), 4 quadros, células 5 e 6 vazias.
Animação: DESCANSO (loop suave). Ele está sentado esperando na plataforma de volta, que o jogo desenha: NÃO desenhe plataforma nem chão. Sentado de perfil para a direita, pernas cruzadas, bumbum na linha dos pés (4 pixels acima da borda de baixo da célula), cauda enrolada ao lado, antebraços apoiados nos joelhos, sorriso de canto tranquilo.
Diferenças pequenas entre os quadros (1 a 2 pixels), mesma silhueta, para o loop ficar suave:
1) respirando, peito baixo
2) peito e juba sobem 1 pixel
3) igual ao 2, olhos fechados (piscada)
4) peito descendo, olhos abertos

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

## Conferência (Claude Code, antes de integrar)

- [ ] Quantidade de quadros e ordem certas; células que sobram vazias.
- [ ] Cada pose lado a lado com o `parado.png`: mesma altura, cabeça, contorno e cores.
- [ ] Sem chão, plataforma, cenário, rastro, poeira, linha de velocidade ou brilho.
- [ ] Checagem de ilhas em todas as folhas dos dois personagens depois de importar: `godot --headless --path game --script res://tools/checar_ilhas.gd`.
- [ ] Os 4 quadros quase iguais (loop sem pulo); sentado na linha dos pés.

## Nota para a integração

Entra no jogo no estado de plataforma de volta (`S.RESPAWN` em `pixel_sprite.gd`, que hoje mostra o quadro 3 do `pulo`).
