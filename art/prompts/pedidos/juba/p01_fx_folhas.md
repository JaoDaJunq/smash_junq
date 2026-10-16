# Efeito · explosão de folhas do Sumiço do Mico

**Para:** Codex (geração de imagem) · **Origem:** playtest 01 (15/10/2026) · **Avalia e integra:** Claude Code

## Por quê

O Sumiço do Mico precisa de um efeito onde o Juba some e onde ele reaparece. Efeito é sprite separado do personagem (regra do playtest 01). O jogo toca este efeito duas vezes: na saída e na chegada.

## Anexar (sempre, nesta ordem)

1. `art/conceitos/juba/folha_v1.jpg` (folha aprovada, para as cores)
2. `art/pixel/juba/parado.png` (régua de tamanho: o efeito no máximo cobre o Juba inteiro)

## Saída (não sobrescreve nada do jogo)

- `art/pixel/juba/candidatos/fx_folhas_v1.png` (6 quadros)

Crie a pasta se não existir. Não mexa em `art/pixel/<personagem>/*.png` nem em `game/`: esses arquivos estão em uso.

## Formato

Imagem 1536x1024, grade 3 colunas x 2 linhas, células de 512x512, cada uma com um quadro de 64x64 ampliado 8x. Células numeradas 1-2-3 (linha de cima) e 4-5-6 (linha de baixo).

6 quadros, células 1 a 6. O efeito fica centralizado na célula (não tem linha dos pés).

## Prompt

```text
Folha de EFEITO em pixel art para um jogo de luta 2D (não é personagem): explosão de folhas de mata atlântica, 6 quadros.
Imagem 1536x1024, grade 3 colunas x 2 linhas, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Fundo magenta chapado #FF00FF. Sem anti-aliasing, sem borrado, sem degradê, sem brilho suave. Contorno de 1 pixel #3A0A0A em cada folha. Sem texto, números, grade ou moldura. Efeito centralizado na célula, com espaço vazio em volta: nada encosta na borda da célula.
Cores (use só estas): verde-folha #4F8A3A, verde escuro #2F5A24, dourado #FFC42A, laranja-dourado #FF9A1A, contorno #3A0A0A.
Quadros:
1) tufo pequeno de folhas fechado no centro (cerca de 14 pixels)
2) folhas se abrindo em círculo (cerca de 30 pixels)
3) explosão no máximo: 10 a 14 folhas espalhadas em círculo (cerca de 52 pixels), metade verdes e metade douradas
4) folhas se afastando e girando, com espaço entre elas
5) poucas folhas, menores, começando a cair
6) 3 ou 4 folhinhas soltas caindo
```

## Conferência (Claude Code, antes de integrar)

- [ ] 6 quadros na ordem; folhas com contorno, só as 5 cores.
- [ ] Cabe no tamanho do Juba (no quadro 3, no máximo 52 px).
- [ ] Fundo magenta liso.

## Nota para a integração

Entra em `game/assets/fx/` e no `fx_director.gd`. Já tem linha de pedido no `assets/manifest.csv` (`fx_juba_folhas_v1`); atualizar o estado na integração.
