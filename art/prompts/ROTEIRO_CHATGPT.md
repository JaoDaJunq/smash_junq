# Roteiro de arte no ChatGPT — Smash Junq

Passo a passo para gerar a arte dos personagens no **ChatGPT** (gerador de imagens que já vem na sua conta, sem custo extra). Copie os blocos na ordem. Cada bloco é uma mensagem.

**Regras que valem para tudo:**
- Faça **uma conversa por personagem** e não misture: o ChatGPT mantém melhor o estilo dentro da mesma conversa.
- Sempre que pedir uma imagem nova de um personagem já aprovado, **anexe a folha aprovada** na mensagem.
- Baixe as imagens em PNG e salve com o nome indicado em cada passo, dentro do repositório. Depois é só mandar um commit ou me avisar.
- Se uma imagem sair com texto escrito, logotipo, fundo bagunçado ou roupa diferente, peça para refazer citando o problema: "refaça sem texto", "mesma roupa da imagem anterior".

---

## Passo 0 — Guia de estilo (mande primeiro em cada conversa)

```text
Vamos criar arte para um jogo de luta 2D chamado Smash Junq. Guarde este guia de estilo e use em TODAS as imagens desta conversa:

- Personagens: animais brasileiros humanizados (andam em pé, usam roupas, lutam), clima de animação tipo Kung Fu Panda / Zootopia, mas 100% originais.
- Estilo: cartoon 2D vetorial, contorno grosso cor vinho bem escuro (não preto puro), sombreamento em 2 tons (cel shading) e um brilho pequeno. Sem degradê realista, sem textura de pintura.
- Proporção: cabeça grande (cerca de 1/3 da altura), mãos e pés grandes, olhos expressivos de pupila grande.
- Tom: divertido e caótico, expressões exageradas.
- Imagens sempre com fundo cinza claro liso, sem texto, sem logotipo, sem marca d'água.
- Formato paisagem (horizontal).

Responda só "Entendido" e espere o próximo pedido.
```

---

## Passo 1 — Folha do personagem

### Juba (conversa 1)

```text
Crie a folha de personagem (model sheet) do JUBA:
- Mico-leão-dourado humanizado, lutador de capoeira, exibido e provocador.
- Juba laranja-dourada enorme e volumosa, corpo pequeno e magro, cauda longa e fina.
- Roupa: calça de abadá branca com cordão colorido amarrado na cintura, faixa verde na testa, sem camisa, pés descalços.
- Cores: dourado-alaranjado, branco, verde-folha.
- Mostre o mesmo personagem em 3 vistas lado a lado, corpo inteiro, em pose neutra: de frente, de perfil (virado para a direita) e 3/4.
- Embaixo, 4 rostos com expressões: confiante, bravo, levando golpe, gargalhando.
- Siga o guia de estilo.
```

Salve como: `art/conceitos/juba/folha_v1.png`

### Seu Capivas (conversa 2)

```text
Crie a folha de personagem (model sheet) do SEU CAPIVAS:
- Capivara humanizada, tiozão de clube, zen e bonachão, mas brutal quando apanha.
- Corpo redondo, pesado e baixo, pernas curtas, olhos semicerrados tranquilos, uma laranjinha equilibrada no topo da cabeça.
- Roupa: bermuda florida, chinelo de dedo, pochete na cintura, toalha jogada no ombro, sem camisa.
- Cores: marrom-caramelo, laranja, azul-piscina.
- Mostre o mesmo personagem em 3 vistas lado a lado, corpo inteiro, em pose neutra: de frente, de perfil (virado para a direita) e 3/4.
- Embaixo, 4 rostos com expressões: zen, furioso, levando golpe, satisfeito com a vitória.
- Siga o guia de estilo.
```

Salve como: `art/conceitos/seu_capivas/folha_v1.png`

**Peça 2 ou 3 variações** se a primeira não agradar ("faça outra versão, com a juba ainda maior", "deixe a barriga mais redonda"). Salve como `folha_v2.png`, `folha_v3.png`. Depois me diga qual foi a escolhida.

---

## Passo 2 — Poses de luta (depois da folha aprovada)

Anexe a folha aprovada e mande:

```text
Usando exatamente este personagem (mesmas cores, roupa e proporções da imagem anexada), desenhe 6 poses de luta lado a lado, corpo inteiro, todas viradas para a direita:
1. parado em guarda (respirando, pronto para lutar)
2. correndo
3. no meio de um pulo
4. golpe forte para frente
5. levando um golpe (sendo jogado para trás)
6. comemorando a vitória
Siga o guia de estilo.
```

- Juba: no golpe forte, um chute de capoeira (martelo); na vitória, ginga mostrando a língua.
- Seu Capivas: no golpe forte, uma barrigada; na vitória, tomando água de coco de canudinho, impassível.

Salve como: `art/conceitos/<personagem>/poses_v1.png`

---

## Passo 3 — Partes para animar (o passo mais importante para o jogo)

O jogo anima o personagem por partes, como um boneco articulado. Anexe a folha aprovada e mande:

```text
Usando exatamente este personagem (anexado), desenhe ele "desmontado" em partes separadas para animação de recorte (cutout animation), na vista de PERFIL virada para a direita, em pose neutra.
Cada parte separada da outra, com espaço vazio entre elas, sem sobreposição:
cabeça (com a juba/orelhas), tronco, braço de cima, antebraço com mão (esquerdo e direito), coxa, canela com pé (esquerda e direita), cauda.
Nas articulações, desenhe um pequeno pedaço extra arredondado para encaixar (por exemplo, o ombro continua um pouco dentro do tronco).
Fundo transparente (PNG). Mesmo estilo, cores e contorno.
```

Salve como: `art/conceitos/<personagem>/partes_v1.png`

Se o fundo não vier transparente, peça: "refaça com fundo transparente de verdade (PNG com canal alfa)".

---

## Passo 4 — Retrato para a tela de seleção

```text
Usando este personagem (anexado), faça um retrato do busto para a tela de escolha de lutador: pose confiante e expressiva, olhando para o jogador, iluminação de entardecer (tons de laranja e roxo vindo de trás). Fundo transparente. Mesmo estilo.
```

Salve como: `art/conceitos/<personagem>/retrato_v1.png`

---

## Como avaliar antes de aprovar

Confira cada imagem:

- [ ] Dá para reconhecer o personagem só pela silhueta (sombra preta)?
- [ ] Cores, roupa e acessórios iguais aos da folha aprovada?
- [ ] Contorno grosso escuro e só 2 tons de sombra?
- [ ] Cabeça grande, mãos e pés grandes?
- [ ] Sem texto, logotipo ou marca d'água?
- [ ] Nada que lembre personagem de filme, desenho ou jogo famoso?

Me mande as imagens (ou o commit) e eu faço a avaliação técnica: legibilidade no tamanho real do jogo, contraste com a arena, se as partes encaixam no esqueleto, e o que pedir para corrigir.
