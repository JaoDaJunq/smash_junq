# Dona Canga · refação completa (rodada 7b)

A primeira versão ficou poluída ("sopa de pixels": rosto ilegível, contorno pontilhado, muito mais detalhada que o resto do elenco). Ela foi movida para `art/pixel/arara_canga/candidatos/v1/`. **Não use nada dela como referência.**

Referências para anexar SEMPRE: `art/concepts/arara_canga/escolhido.png` (visual) e `art/pixel/juba/parado.png` + `art/pixel/seu_capivas/parado.png` (o NÍVEL DE LIMPEZA e de detalhe que o jogo usa). Depois de pronta, anexe também a nova `art/pixel/arara_canga/base.png` e `parado.png`.

## Etapa A · base + parado (e PARE para revisão)

```text
Sprite base do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: baiana parada em guarda, asas meio abertas, saia rodada aberta, queixo erguido e orgulhosa, de perfil para a direita. Personagem com cerca de 54 pixels de altura; base 4 pixels acima da borda de baixo. Fundo magenta chapado #FF00FF. Sem anti-aliasing, contorno de 1 pixel #2A0F12, só as cores da paleta, sem chão, sem efeitos, sem texto.
Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008

LIMPEZA (obrigatório): pixel art simples e legível como o Juba e o Seu Capivas anexados. Formas grandes de cor chapada, no máximo 2 tons por material (luz e base, sombra só onde precisa), contorno contínuo de 1 px sem falhas e sem pontilhado, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe: um olho grande com pupila, bico curvo grande creme e preto. Silhueta: turbante branco alto + cabeça vermelha + corpo redondo + saia rodada larga em forma de sino (branca com 3 faixas de babado: amarelo, azul, vermelho) + sandálias douradas. Asas fechadas junto ao corpo na base (azul por fora, amarelo por dentro). Personagem com cerca de 54 px de altura e no máximo 46 px de largura.
```

Depois gere `parado.png` (bloco abaixo) com a MESMA base, e **pare**: escreva `ETAPA A PRONTA` e espere o Hermes aprovar antes de continuar.

```text
Folha de animação do Dona Canga: arara-canga (arara-vermelha) humanizada, senhora BAIANA da escola de samba (concept escolhido anexado): corpo redondo e largo, bico curvo grande creme e preto, penas vermelhas, asas amarelas e azuis, cauda longa vermelha e azul; turbante branco com faixas vermelha, amarela e azul; bata de renda branca; saia rodada ENORME branca com babados amarelo, azul e vermelho; faixa de cetim na cintura; muitos colares de contas; argolas douradas; sandália de salto plataforma dourada, 4 quadros.
Animação: Requebrado parado (loop)
Quadros:
1) saia parada, asas meio abertas · 2) quadril para um lado, saia balançando · 3) quadril para o outro · 4) volta ao meio

Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- Mesma escala, paleta, contorno e proporção do sprite base e do quadro "parado" anexados (cerca de 54 pixels de altura). Só a pose muda.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades).

Paleta da Dona Canga (use só estas cores):
contorno #2A0F12
penas vermelhas: luz #F0504A, base #D7262E, sombra #9E1A22
amarelo: luz #FFE07A, base #F7C531, sombra #C8931E
azul: luz #5A9AE8, base #2D6FC4, sombra #1E4A8A
bico: creme #EDE3D0, sombra #C9BCA4, preto #2A2420
renda e turbante: branco #FAF6EE, sombra #D9D2C2
dourado (contas, argolas, sandália): luz #FFE08A, base #E8B83A, sombra #A87A1E
olhos: #F2A23A, pupila #1A1008

REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.
```

## Etapa B · todas as outras folhas (depois da aprovação)

Gere todos os blocos de `art/prompts/pedidos/arara_canga/todos.md` dos lotes 1 e 2 (menos base e parado, já feitos), na ordem, acrescentando a cada um este texto:

```text
REGRA NOVA (a mais importante): o personagem INTEIRO cabe dentro do quadro de 64x64 com pelo menos 4 pixels de folga em todos os lados (na imagem: 32 px de folga dentro da célula de 512). Nada atravessa para a célula vizinha. Golpes de alcance (cauda, asa, saia) são desenhados COMPACTOS: a cauda/asa se estende no máximo até a borda da área livre; o alcance extra o jogo faz sozinho.
Todos os quadros da folha são o MESMO desenho do quadro "parado" anexado (mesmo tamanho de cabeça, mesmo ângulo de perfil, mesma roupa e mesmas cores); não troque para vista de 3/4 nem de frente.

LIMPEZA: mesma limpeza do parado anexado (cores chapadas, contorno contínuo, nenhum pixel solto).
```

## Etapa C · intermediários e interface

Lote 3 (`_meio`) e interface como em `todos.md`. Os intermediários usam EXATAMENTE o mesmo desenho dos quadros principais. Se o gerador de imagens atingir o limite, **PARE e avise**: nunca monte quadros nem artes à mão para completar arquivos.
