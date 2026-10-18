# Arena · Caatinga ao meio-dia (rodada 3)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

Arena nova para o jogo de luta 2D (vista de lado, câmera fixa, palco principal flutuando no meio e duas plataformas pequenas no alto). Anexe como referência de estilo `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (os lutadores; NÃO desenhe eles). Gere as 3 imagens abaixo e salve em `art/arenas/caatinga/candidatos/`.

## 1 · `art/arenas/caatinga/candidatos/fundo_longe.png` (céu e horizonte, camada mais distante)

```text
Fundo de cenário em pixel art para jogo de luta 2D, vista lateral: Caatinga ao meio-dia. sol forte e céu azul limpo, chão de terra rachada, mandacarus e xique-xiques, serras de pedra ao longe, casinha de taipa e uma cerca de madeira torta, galhos secos. Só o céu e o horizonte distante; a metade de baixo da imagem tem o horizonte e a paisagem longe, sem chão perto da câmera.
Paleta: céu azul #4FB3E8 #9AD8F2, sol #FFE9A0, terra #D9894A #B5652E #7A3E1C, pedra #B8A48A #8A7660, verde do cacto #4E8A4A #2E5A30.
Regras desta imagem:
- Imagem 1536x1024, pixel art de verdade: cada pixel do desenho vira um quadrado de 4x4 (desenho de 384x256 ampliado 4x). Sem anti-aliasing, sem borrado, sem degradê suave (degradê só em faixas de cor chapadas).
- Mesmo estilo dos personagens do jogo (pixel art com contorno escuro, 2 tons de sombra), mas o fundo é mais claro e menos saturado que os personagens, para eles se destacarem.
- Sem personagens do jogo, sem texto, sem logotipo, sem moldura, sem interface.
- A imagem tem que poder repetir na horizontal: a borda esquerda continua na borda direita.
```

## 2 · `art/arenas/caatinga/candidatos/fundo_perto.png` (camada do meio, com transparência)

```text
Camada de meio de cenário em pixel art, mesma arena: Caatinga ao meio-dia. Elementos mais perto da câmera que o horizonte (árvores, plantas, pedras, bichos ao longe da arena "Caatinga ao meio-dia"), ocupando só o terço de baixo da imagem; todo o resto é fundo magenta chapado #FF00FF (vira transparente no jogo). Nada encosta no topo.
Paleta: céu azul #4FB3E8 #9AD8F2, sol #FFE9A0, terra #D9894A #B5652E #7A3E1C, pedra #B8A48A #8A7660, verde do cacto #4E8A4A #2E5A30.
Regras desta imagem:
- Imagem 1536x1024, pixel art de verdade: cada pixel do desenho vira um quadrado de 4x4 (desenho de 384x256 ampliado 4x). Sem anti-aliasing, sem borrado, sem degradê suave (degradê só em faixas de cor chapadas).
- Mesmo estilo dos personagens do jogo (pixel art com contorno escuro, 2 tons de sombra), mas o fundo é mais claro e menos saturado que os personagens, para eles se destacarem.
- Sem personagens do jogo, sem texto, sem logotipo, sem moldura, sem interface.
- A imagem tem que poder repetir na horizontal: a borda esquerda continua na borda direita.
- O fundo magenta #FF00FF é uma cor só, sem sombra, e não aparece dentro do desenho.
```

## 3 · `art/arenas/caatinga/candidatos/palco.png` (peças do palco, grade 3x2)

```text
Peças de cenário em pixel art para montar o palco de um jogo de luta 2D: Caatinga ao meio-dia. Grade de 6 blocos:
1) ponta esquerda do palco principal: laje de pedra e terra rachada com mandacaru pequeno na lateral, raízes secas; o lado esquerdo termina numa quina limpa (os lutadores se penduram nela)
2) meio do palco principal: mesmo material, emenda perfeita com o 1 e o 3 e consigo mesmo na horizontal (repete várias vezes)
3) ponta direita do palco principal: espelho do 1, quina limpa à direita
4) parte de baixo do palco (corpo de terra/pedra pendurado embaixo do meio, com raízes), emenda na horizontal com ela mesma e encaixa embaixo do bloco 2
5) plataforma pequena, metade esquerda: tábua de madeira de cerca apoiada em duas estacas; fina (no máximo 20 pixels de altura)
6) plataforma pequena, metade direita: continua o 5
Paleta: céu azul #4FB3E8 #9AD8F2, sol #FFE9A0, terra #D9894A #B5652E #7A3E1C, pedra #B8A48A #8A7660, verde do cacto #4E8A4A #2E5A30.
Regras desta imagem:
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM bloco de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8).
- Fundo magenta chapado #FF00FF onde não há desenho.
- Pixel art com contorno de 1 pixel escuro, 2 tons de sombra, sem anti-aliasing, sem borrado.
- A superfície onde os lutadores pisam é uma linha reta na horizontal, exatamente na linha 8 do bloco de 64 (o que fica acima dela é só grama, flor ou detalhe baixo, no máximo 8 pixels).
- Sem personagens, sem texto, sem efeitos.
```

## Conferência (Hermes)
- Fundo repete na horizontal sem emenda visível; tamanho 1536x1024.
- `fundo_perto`: só o terço de baixo desenhado, resto magenta.
- `palco`: superfície reta na linha 8 dos blocos 1, 2, 3, 5 e 6; blocos 2 e 4 repetem sem emenda.
