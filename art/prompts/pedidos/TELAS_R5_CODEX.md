# Rodada 5 · telas fora da partida (menu, seleção de personagem, mapa do Brasil)

**Para:** Codex (gpt-6-luna, esforço alto) · **Avalia e integra:** Hermes

O criador achou os menus "simples e feinhos, sem a vibe do jogo". O jogo é um torneio de capoeira e várzea entre bichos brasileiros, em ilhas de biomas flutuando no céu do entardecer. Os lutadores são pixel art; os fundos das arenas são pintura digital suave. Anexe como referência `art/pixel/juba/parado.png`, `art/pixel/seu_capivas/parado.png` e `art/arenas/pantanal/v2/fundo.png`.

Salve tudo em `art/ui/`. Confira cada imagem antes de salvar, até 3 tentativas. Não rode git.

## 1 · `art/ui/menu_fundo.png` — fundo do menu inicial

```text
Ilustração pintada (mesmo estilo dos fundos das arenas anexados, NÃO pixel art), 1536x1024: céu de entardecer dourado, rosa e lilás com nuvens grandes; várias ilhas flutuantes de biomas brasileiros espalhadas em profundidade (uma de mata atlântica com cachoeira, uma de pantanal com lagoa, uma de caatinga com mandacarus, uma de cerrado com ipês floridos), pequenas ao longe e uma maior embaixo, no centro, com um campinho de várzea de terra (traves de madeira, bandeirinhas de festa coloridas penduradas). A metade de cima, no centro, é só céu limpo (ali entra o logotipo); o terço de baixo à esquerda e à direita também mais limpo (ali ficam os lutadores e os botões). Sem personagens, sem bichos, sem pássaros, sem texto.
```

## 2 · `art/ui/logo.png` — logotipo

```text
Logotipo em pixel art do jogo de luta "SMASH JUNQ" (exatamente essas letras: S M A S H, espaço, J U N Q). Imagem 1536x1024 com fundo magenta chapado #FF00FF. Letras grossas e chanfradas em dourado/laranja com brilho no topo e contorno vinho-escuro grosso de 2 pixels, um pouco inclinadas para cima à direita, com cara de faixa de campeonato de bairro: atrás das letras, uma faixa de tecido verde e amarela com pontas cortadas em V e uma fita de cordão de capoeira. Pixel art de verdade: cada pixel do desenho é um quadrado de 8x8 na imagem, sem anti-aliasing, sem borrado, sem sombra projetada no fundo. Letras legíveis e bem escritas, nada além do logotipo.
```

## 3 · `art/ui/mapa_brasil.png` — mapa para escolher a arena

```text
Mapa do Brasil em pixel art, vista de cima, com o contorno do país correto e reconhecível, ocupando quase toda a altura de uma imagem 1536x1024, centralizado, fundo magenta chapado #FF00FF fora do país. Dentro, os biomas pintados em cores de pixel art com textura leve: Amazônia verde-escuro com rios, Cerrado ocre/amarelado, Caatinga bege-alaranjado, Pantanal verde-azulado com manchas de água, Mata Atlântica verde-vivo na faixa do litoral, Pampa verde-claro no sul. Contorno escuro de 2 pixels no país, faixa de areia clara no litoral. Sem nomes, sem texto, sem divisas de estados, sem marcadores, sem bússola. Pixel art: cada pixel do desenho é um quadrado de 8x8, sem anti-aliasing.
```

## 4 · `art/ui/retrato_juba.png` e 5 · `art/ui/retrato_seu_capivas.png` — fotinhos da seleção

Duas imagens separadas, uma por personagem, cada uma usando o `parado.png` do personagem como referência de rosto, cores e roupa.

```text
Retrato em pixel art (busto: cabeça, ombros e peito) do personagem anexado, MESMO personagem, mesmas cores, roupa e acessórios, virado em 3/4 olhando para a direita, expressão marcante da personalidade dele (Juba: sorriso provocador e confiante; Seu Capivas: tiozão tranquilo e satisfeito, meio sorriso). Imagem 1024x1024, fundo magenta chapado #FF00FF, o busto ocupando o quadro inteiro de baixo até perto do topo, cortado reto embaixo. Pixel art de 128x128 pixels ampliado 8x (cada pixel é um quadrado de 8x8), contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem fundo, sem texto, sem efeitos.
```

## Conferência (Hermes)
- Logo: letras certas e legíveis.
- Mapa: contorno do Brasil reconhecível, biomas no lugar certo.
- Retratos: mesmo personagem do jogo, fundo magenta limpo.
- Prints dentro do jogo das três telas antes de mostrar ao criador.
