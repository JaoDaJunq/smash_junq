# Pixel art — como pedir ao ChatGPT

> **Teste em andamento (15/10/2026).** Trocamos os bonecos de recorte por sprites em pixel art, quadro a quadro, para ver se os personagens ficam mais firmes e expressivos. O trabalho de recorte ficou guardado no ramo `wip/capivas-recorte-v2` e pode voltar se o teste não agradar.

## Por que pixel art resolve o "quebrado"

No recorte, o corpo é montado com peças que giram nas juntas. Se a peça não foi desenhada pensando nisso, aparecem emendas, buracos e pescoços estranhos. Em pixel art **cada quadro é um desenho inteiro**: não tem junta. Em troca, é preciso desenhar mais quadros, e por isso o pedido é organizado por animação.

## Padrão técnico (vale para todo pedido)

| Item | Padrão |
|---|---|
| Tela de cada quadro | **64 × 64 pixels** |
| Ampliação na imagem | **8×** (cada pixel vira um quadrado de 8 × 8). Um quadro ocupa 512 × 512 |
| Folha de animação | **1536 × 1024**, grade de **3 colunas × 2 linhas** (até 6 quadros), lida da esquerda para a direita, de cima para baixo |
| Sprite base (pose de referência) | **1024 × 1024**, um quadro só, ampliado 16× |
| Fundo | **magenta chapado #FF00FF**, sem degradê nem sombra (eu troco por transparente) |
| Vista | **perfil olhando para a DIREITA** em todos os quadros |
| Pés | sempre na **mesma linha**, 4 pixels acima da borda de baixo do quadro |
| Tamanho do personagem | Juba ≈ **52 px** de altura; Seu Capivas ≈ **56 px** com a laranjinha, mais largo |
| Contorno | 1 pixel, cor vinho bem escura (não preto puro) |
| Cores | só as da paleta do personagem (no arquivo dele) |
| Proibido | anti-aliasing, borrado, degradê suave, brilho, texto, números, linhas de grade, moldura |

No jogo, o sprite aparece **ampliado 2×** (64 px viram 128), do tamanho atual dos lutadores.

## Ordem de trabalho

1. **Abra uma conversa nova para cada personagem** e mande primeiro a **mensagem de regras** abaixo.
2. Peça o **sprite base** (arquivo do personagem, passo 1). Me mande para aprovar: é ele que define o visual.
3. Com o sprite base aprovado, peça as animações do **Lote 1** (dá para jogar só com ele). Em todo pedido, anexe o sprite base.
4. Depois venha o **Lote 2** (golpes aéreos, especiais, defesa, borda e vitória).

Arquivos dos personagens: [juba.md](juba.md) · [seu_capivas.md](seu_capivas.md)

## Mensagem de regras (a primeira de cada conversa)

```text
Vamos fazer os sprites de um jogo de luta 2D em PIXEL ART de verdade. Regras que valem para TODAS as imagens desta conversa:
- Pixel art com grade nítida: cada quadro é uma tela de 64x64 pixels, ampliada 8x (cada pixel vira um quadrado de 8x8 na imagem). Sem anti-aliasing, sem borrado, sem degradê suave, sem brilho.
- Fundo magenta chapado #FF00FF, sem sombra no chão.
- Personagem sempre de perfil olhando para a DIREITA.
- Folhas de animação: imagem de 1536x1024 com grade de 3 colunas x 2 linhas (cada célula 512x512 = um quadro de 64x64). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo magenta.
- O personagem tem exatamente o mesmo tamanho, as mesmas cores e o mesmo desenho em todos os quadros; só a pose muda. Os pés ficam sempre na mesma altura, 4 pixels acima da borda de baixo da célula.
- Contorno de 1 pixel cor vinho bem escura. Usar só a paleta que eu passar.
- Sem texto, números, linhas de grade ou moldura.
Responda só "ok" e espere o primeiro pedido.
```

## Se o ChatGPT errar

| Problema | O que mandar |
|---|---|
| Ficou borrado ou "pintado" | `Isso não é pixel art de verdade: refaça com pixels quadrados nítidos de 8x8, sem anti-aliasing e sem degradê.` |
| Personagem muda entre os quadros | `Mantenha o personagem idêntico ao sprite base anexado em todos os quadros: mesmo tamanho, cores e roupa; só a pose muda.` |
| Fundo não é magenta liso | `O fundo tem que ser magenta chapado #FF00FF, uma cor só, sem sombra.` |
| Quadros fora da grade | `Respeite a grade de 3 colunas x 2 linhas de 512x512; um quadro inteiro dentro de cada célula, sem invadir a vizinha.` |
| Virado para a esquerda | `Todos os quadros de perfil olhando para a DIREITA.` |
| Pés em alturas diferentes | `Os pés ficam na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.` |

## Onde salvar

```text
art/pixel/juba/base.png
art/pixel/juba/<animacao>.png         (ex.: parado.png, andar.png, golpe_frente.png)
art/pixel/seu_capivas/base.png
art/pixel/seu_capivas/<animacao>.png
```

Pode subir tudo junto num commit (de preferência direto na `main`) e me avisar.

## O que eu faço depois

1. Troco o magenta por transparente, reduzo cada quadro para 64 × 64 pixels exatos e prendo as cores na paleta (corrige pixels "sujos" da IA).
2. Alinho os quadros pela linha dos pés e monto as animações no jogo (AnimatedSprite2D), com os quadros de golpe sincronizados com os quadros de ataque do moveset. As áreas de acerto continuam as mesmas.
3. Mantenho o que já funciona: rastro dos golpes, amassar e esticar, flash de dano e efeitos.
