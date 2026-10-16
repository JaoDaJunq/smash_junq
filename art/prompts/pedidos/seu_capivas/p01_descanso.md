# Seu Capivas · descanso (novo)

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Pose nova para a plataforma de volta (depois de um KO), igual à do Juba: sentado, em loop suave.

## Anexar (sempre, nesta ordem)

1. `art/conceitos/seu_capivas/folha_v1.png` (folha aprovada)
2. `art/pixel/seu_capivas/parado.png` (quadro aprovado: régua de escala e traço)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/seu_capivas/candidatos/descanso_v1.png` (4 quadros)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

4 quadros, células 1 a 4; células 5 e 6 vazias.

## Prompt

```text
Folha de animação do Seu Capivas (capivara tiozão de clube, grandalhão e redondo, cabeça baixa encaixada num cangote largo, olhos semicerrados, laranjinha na cabeça, toalha azul no ombro, barrigão, bermuda florida azul, pochete, chinelo de dedo), 4 quadros, células 5 e 6 vazias.
Animação: DESCANSO (loop suave). Ele está sentado esperando na plataforma de volta, que o jogo desenha: NÃO desenhe plataforma nem chão. Sentado de perfil para a direita, bem relaxado, pernas curtas esticadas para a frente, mãos na barriga, toalha no ombro, olhos semicerrados zen, bumbum na linha dos pés (4 pixels acima da borda de baixo da célula).
Diferenças pequenas entre os quadros (1 a 2 pixels), mesma silhueta, para o loop ficar suave:
1) respirando, barriga baixa
2) barriga e ombros sobem 1 pixel
3) igual ao 2, olhos fechados (cochilando)
4) barriga descendo, olhos semicerrados

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
- [ ] Os 4 quadros quase iguais (loop sem pulo); sentado na linha dos pés.

## Nota para a integração

Entra no jogo no estado de plataforma de volta (`S.RESPAWN` em `pixel_sprite.gd`).
