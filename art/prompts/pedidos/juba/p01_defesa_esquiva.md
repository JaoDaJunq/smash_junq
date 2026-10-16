# Juba · defesa e rolamento na escala certa

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

Comparei a folha `defesa_esquiva` com o parado aprovado, lado a lado no mesmo zoom. A altura bate (51 px), mas:
- a juba e a cabeça ficaram maiores e mais redondas: o desenho ocupa cerca de 12% mais pixels que o parado com a mesma altura;
- o rosto virou de 3/4 para a câmera, com o olho maior; no parado ele está de perfil;
- a postura ficou mais aberta (58 px de largura contra 54 no parado) e a cauda mais grossa;
- o cordão da calça virou um bloco grosso verde e amarelo;
- o quadro 2 tem linhas de tremor desenhadas em volta do corpo (efeito).

## Anexar (sempre, nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg` (folha aprovada)
2. `art/pixel/juba/parado.png` (quadro aprovado: régua de escala e traço)
3. `art/pixel/juba/defesa_esquiva.png` (folha atual: poses de referência, NÃO o traço)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/defesa_esquiva_v2.png` (6 quadros)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

6 quadros, células 1 a 6. Sem folha de intermediários (no jogo, esta folha não é intercalada).

## Prompt

```text
Folha de animação do Juba (mico-leão-dourado capoeirista, juba enorme laranja-dourada, faixa verde na testa, calça de abadá branca com cordão verde e amarelo, sem camisa, cauda longa enrolada na ponta, mãos e pés marrons), 6 quadros.
Animação: DEFESA E ROLAMENTO. O Juba tem que ser o MESMO do quadro "parado" anexado: mesma cabeça (mesmo tamanho de juba), rosto de perfil para a direita com o olho do mesmo tamanho, mesma largura de corpo, cauda da mesma grossura, cordão fino como no parado. A folha "defesa_esquiva" anexada serve só para as poses; o traço dela está grande demais.
Quadros:
1) guarda baixa: antebraços cruzados na frente do rosto, corpo um pouco agachado, de perfil
2) a mesma guarda, um pixel mais baixa, olhos apertados de esforço (sem linhas de tremor: só a pose)
3) rolamento: abaixando, mãos indo ao chão
4) rolando, encolhido em bola
5) rolando, terminando o giro
6) levanta em guarda de ginga

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
- [ ] Juba do mesmo tamanho do parado (sobreponha os dois: a cabeça não pode ficar maior).
- [ ] Rosto de perfil, como no parado.
