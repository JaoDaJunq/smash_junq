---
name: gerar-arte
description: Fluxo de arte do Smash Junq (folhas de personagem, poses, partes para animação, retratos, cenários). Por padrão o criador gera as imagens no ChatGPT com os prompts do roteiro e o Claude prepara prompts, avalia e integra. Use quando pedirem para criar, gerar, desenhar ou avaliar personagens, conceitos, model sheets, partes de personagem, arenas ou qualquer imagem do jogo.
---

# Arte do Smash Junq

## Fluxo padrão (sem custo extra): ChatGPT manual

O criador não quer pagar serviços extras. Ele gera as imagens no ChatGPT da conta dele; o Claude prepara e avalia.

1. **Ler antes:** `design/identidade.md` (bíblia visual) e `art/prompts/ROTEIRO_CHATGPT.md` (roteiro passo a passo).
2. **Preparar prompts:** para pedidos novos, escrever prompts no mesmo formato do roteiro (bloco de texto pronto para colar, em português, citando o guia de estilo e pedindo para anexar a folha aprovada), e acrescentar ao roteiro ou a um arquivo em `art/prompts/`.
3. **Receber imagens:** o criador salva em `art/conceitos/<personagem>/` com o nome indicado (`folha_v1.png`, `poses_v1.png`, `partes_v1.png`, `retrato_v1.png`) e faz commit ou avisa.
4. **Avaliar:** abrir as imagens com a ferramenta de leitura de arquivos (Read) e conferir contra a bíblia: silhueta, cores e roupa iguais à folha aprovada, contorno grosso cor vinho, 2 tons de sombra, proporção (cabeça ~1/3), sem texto ou logotipo, nada parecido com personagem famoso. Avaliar também legibilidade no tamanho do jogo (cerca de 110 px de altura) e contraste com a arena roxa/laranja.
5. **Pedir correções:** escrever a frase exata para o criador mandar ao ChatGPT.
6. **Registrar:** cada imagem usada entra em `assets/manifest.csv` (origem "ChatGPT (gerado pelo criador)", estado `conceito` ou `aprovado`).
7. **Integrar:** só depois da aprovação, recortar partes e montar o esqueleto no Godot (sempre `--headless` nesta máquina; nunca abrir janelas).

## Fluxo opcional: API da OpenAI (pago à parte)

Só se o criador decidir configurar uma chave de API. `game/tools/gerar_imagem.gd` gera direto pela API (`gpt-image-2`), lendo a chave da variável `OPENAI_API_KEY`. Nunca pedir, ler ou gravar a chave. Uso:

```bash
godot --headless --path game --script res://tools/gerar_imagem.gd -- \
  --prompt-arquivo art/prompts/juba_folha.txt --saida art/conceitos/juba/folha_v1.png --qualidade medium --tamanho 1536x1024
```
