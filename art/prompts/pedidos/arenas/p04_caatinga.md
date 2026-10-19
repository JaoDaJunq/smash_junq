# Arena Caatinga ao meio-dia · versão 2 (rodada 4)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

A versão 1 foi recusada pelo João: fundo em pixel grosso demais e o palco sumindo no cenário. Agora: **fundo pintado** (não pixel art) e **blocos de terreno grossos e com contraste**, para o jogo montar mapas de formatos diferentes (degraus, ilhas, plataformas que se movem), no estilo Brawlhalla.

Anexe como referência de escala e estilo `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (não desenhe eles). Salve em `art/arenas/caatinga/v2/`.

## 1 · `art/arenas/caatinga/v2/fundo.png` — cenário pintado

```text
Ilustração pintada de cenário para jogo de luta 2D em vista lateral (estilo dos cenários de Brawlhalla e Rayman Legends): Caatinga ao meio-dia. céu azul forte, sol branco, serras de pedra avermelhada ao longe, mandacarus e xique-xiques espalhados, uma casinha de taipa pequena bem ao fundo.
Pintura digital detalhada e suave (NÃO é pixel art), com profundidade: céu, paisagem distante e elementos médios. Cores um pouco dessaturadas e mais escuras que os personagens, com névoa leve na parte de baixo, para os lutadores e o palco se destacarem na frente.
A faixa do meio da imagem (onde fica a luta) é só céu e paisagem distante: nada de chão, pedras grandes ou plantas perto da câmera ali.
Imagem 1536x1024, sem texto, sem logotipo, sem personagens, sem moldura.
```

## 2 · `art/arenas/caatinga/v2/blocos_cima.png` — terreno, parte de cima e meio

```text
Blocos de terreno em pixel art para montar o palco de um jogo de luta 2D: Caatinga ao meio-dia. Terreno: laje de pedra clara com terra rachada e capim seco na superfície; por dentro, rocha alaranjada em camadas; embaixo, pedras soltas e raízes secas. Grade de 6 blocos:
1) canto de cima, esquerdo: superfície na linha 8 do bloco (acima dela só capim/flores baixas), quina esquerda arredondada com contorno; abaixo da superfície, o corpo do terreno até o fim do bloco
2) meio de cima: superfície reta na linha 8, corpo embaixo; repete na horizontal sem emenda
3) canto de cima, direito: espelho do 1
4) lado esquerdo do corpo: parede de terra com contorno à esquerda; repete na vertical
5) miolo do corpo: só a textura de dentro do terreno; repete em todas as direções
6) lado direito do corpo: espelho do 4
Paleta: pedra #E0C9A0 #B8A48A #8A7660, terra #D9894A #B5652E #7A3E1C, capim seco #D9B04A.
Regras desta imagem:
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM bloco de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8): pixel art de verdade, na MESMA escala de pixel dos personagens anexados.
- Fundo magenta chapado #FF00FF onde não há desenho.
- Contorno escuro de 1 pixel na borda de fora do terreno, 2 a 3 tons de sombra, sem anti-aliasing, sem borrado.
- Cores fortes e mais claras na superfície (onde se pisa) que no corpo, para o palco se destacar MUITO do fundo do cenário.
- Os blocos se encaixam como um quebra-cabeça de 9 partes: repetidos lado a lado e um embaixo do outro, não pode aparecer emenda.
- Sem personagens, sem texto, sem efeitos, sem sombra projetada.
```

## 3 · `art/arenas/caatinga/v2/blocos_baixo.png` — terreno, parte de baixo

```text
Continuação dos mesmos blocos de terreno em pixel art: Caatinga ao meio-dia. Terreno: laje de pedra clara com terra rachada e capim seco na superfície; por dentro, rocha alaranjada em camadas; embaixo, pedras soltas e raízes secas. Grade de 6 blocos:
1) canto de baixo, esquerdo: fim do corpo com contorno, arredondado, com raízes/pedras penduradas por baixo
2) baixo do meio: fim do corpo com coisas penduradas por baixo; repete na horizontal sem emenda
3) canto de baixo, direito: espelho do 1
4) enfeite solto 1 (planta típica da arena, sem fundo), pequeno, apoiado na linha 63 do bloco
5) enfeite solto 2 (outra planta/pedra típica), pequeno, apoiado na linha 63
6) enfeite solto 3 (bicho pequeno parado ou flor), apoiado na linha 63
Os blocos 1 a 3 encaixam embaixo dos blocos 4, 5 e 6 de `blocos_cima.png` (anexe essa imagem).
Paleta: pedra #E0C9A0 #B8A48A #8A7660, terra #D9894A #B5652E #7A3E1C, capim seco #D9B04A.
Regras desta imagem:
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM bloco de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8): pixel art de verdade, na MESMA escala de pixel dos personagens anexados.
- Fundo magenta chapado #FF00FF onde não há desenho.
- Contorno escuro de 1 pixel na borda de fora do terreno, 2 a 3 tons de sombra, sem anti-aliasing, sem borrado.
- Cores fortes e mais claras na superfície (onde se pisa) que no corpo, para o palco se destacar MUITO do fundo do cenário.
- Os blocos se encaixam como um quebra-cabeça de 9 partes: repetidos lado a lado e um embaixo do outro, não pode aparecer emenda.
- Sem personagens, sem texto, sem efeitos, sem sombra projetada.
```

## Conferência (Hermes)
- Fundo pintado, sem chão perto da câmera na faixa do meio.
- Blocos: superfície reta na linha 8; os 9 pedaços encaixam sem emenda; contraste forte com o fundo.
- Prints dentro do jogo de cada arena antes de mostrar ao João.
