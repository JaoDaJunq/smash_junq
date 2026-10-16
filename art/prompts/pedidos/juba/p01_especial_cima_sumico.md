# Juba · especial para cima: Sumiço do Mico

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Decisão do João: sai o cipó (preso a algo fora do quadro, sem origem no jogo). No código o golpe já é um teletransporte curto em qualquer direção: o Juba prepara, some, reaparece a 260 px na direção escolhida e chuta na chegada. A explosão de folhas (pedido `p01_fx_folhas.md`) cobre o sumiço e a chegada; o sprite não desenha efeito nenhum.

## Anexar (sempre, nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg` (folha aprovada)
2. `art/pixel/juba/parado.png` (quadro aprovado: régua de escala e traço)
3. `art/pixel/juba/especial_lado.png` (referência de giro de capoeira no mesmo traço)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/especial_cima_v2.png` (6 quadros)
- `art/pixel/juba/candidatos/especial_cima_meio_v2.png` (5 intermediários)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

- `especial_cima_v2.png`: 6 quadros, células 1 a 6.
- `especial_cima_meio_v2.png`: 5 quadros, células 1 a 5 (célula 6 vazia).

## Prompt 1 · folha principal (`especial_cima_v2.png`)

```text
Folha de animação do Juba (mico-leão-dourado capoeirista, juba enorme laranja-dourada, faixa verde na testa, calça de abadá branca com cordão verde e amarelo, sem camisa, cauda longa enrolada na ponta, mãos e pés marrons), 6 quadros.
Animação: SUMIÇO DO MICO (especial para cima). Ele faz um aú de capoeira (estrela) girando, some, e reaparece dando uma armada (chute giratório). Sem cipó, sem nada preso fora do quadro, sem folhas, rastro, fumaça ou brilho: só o Juba.
Quadros:
1) prepara: agachado, mãos quase no chão, olhando para a frente
2) aú começando: mãos à frente, pernas subindo abertas
3) aú no meio: de cabeça para baixo, pernas abertas em V para cima, braços esticados
4) aú fechando: corpo encolhido e pequeno, girando (é neste quadro que ele some no jogo)
5) armada: reaparece girando, perna de trás esticada na altura da cabeça, corpo de lado (quadro do golpe)
6) volta à guarda de ginga

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

## Prompt 2 · intermediários (`especial_cima_meio_v2.png`), depois do 1

```text
Anexei a folha "especial_cima" NOVA do Juba (a que você acabou de gerar), a folha aprovada e o quadro "parado".
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
- [ ] Nenhum cipó, corda ou folha no sprite.
- [ ] Quadro 5 lê bem como chute giratório no tamanho do jogo (128 px).

## Nota para a integração

- Quadro de impacto = 5 da folha principal: acrescentar `"juba": {"especial_cima": 4}` em `IMPACTO` de `importar_pixel.gd`.
- Trocar o rastro provisório do teletransporte (`agil.gd`, hoje só aparece sem arte) pela explosão de folhas na saída e na chegada.
- Esconder o sprite entre o quadro 4 e a chegada, para o sumiço ficar limpo.
