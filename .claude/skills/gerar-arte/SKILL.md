---
name: gerar-arte
description: Fluxo de arte do Smash Junq (folhas de personagem, poses, partes para animação, retratos, cenários). Por padrão o criador gera as imagens no ChatGPT com os prompts do roteiro e o Claude prepara prompts, avalia e integra. Use quando pedirem para criar, gerar, desenhar ou avaliar personagens, conceitos, model sheets, partes de personagem, arenas ou qualquer imagem do jogo.
---

# Arte do Smash Junq

## Fluxo padrão (sem custo extra): ChatGPT manual

O criador não quer pagar serviços extras. Ele gera as imagens no ChatGPT da conta dele; o Claude prepara e avalia.

**Pelo Hermes:** quando o pedido chega pelo Hermes, quem gera é o Codex (modelo `gpt-6-luna`, esforço alto); o próprio Hermes escreve os pedidos, avalia e integra (papel que antes era do Claude Code), com a geração de imagens dele (login do ChatGPT, sem custo extra). O pedido do passo 2 vai para o Codex, e não para o criador, com o prompt, a folha aprovada para anexar como referência e o caminho exato de saída. Os passos 4 a 7 continuam iguais.

1. **Ler antes:** `design/identidade.md` (bíblia visual) e `art/prompts/ROTEIRO_CHATGPT.md` (roteiro passo a passo).
2. **Preparar prompts:** para pedidos novos, escrever prompts no mesmo formato do roteiro (bloco de texto pronto para colar, em português, citando o guia de estilo e pedindo para anexar a folha aprovada), e acrescentar ao roteiro ou a um arquivo em `art/prompts/`.
3. **Receber imagens:** o criador salva em `art/conceitos/<personagem>/` com o nome indicado (`folha_v1.png`, `poses_v1.png`, `partes_v1.png`, `retrato_v1.png`) e faz commit ou avisa.
4. **Avaliar:** abrir as imagens com a ferramenta de leitura de arquivos (Read) e conferir contra a bíblia: silhueta, cores e roupa iguais à folha aprovada, contorno grosso cor vinho, 2 tons de sombra, proporção (cabeça ~1/3), sem texto ou logotipo, nada parecido com personagem famoso. Avaliar também legibilidade no tamanho do jogo (cerca de 110 px de altura) e contraste com a arena roxa/laranja.
5. **Pedir correções:** escrever a frase exata para o criador mandar ao ChatGPT.
6. **Registrar:** cada imagem usada entra em `assets/manifest.csv` (origem "ChatGPT (gerado pelo criador)", estado `conceito` ou `aprovado`).
7. **Integrar:** só depois da aprovação, recortar partes e montar o esqueleto no Godot (sempre `--headless` nesta máquina; nunca abrir janelas).

## Pixel art: regras de produção (playtest 01)

Regras completas em `design/identidade.md`, seção "Regras de produção do pixel art". Ao **escrever o pedido**:

- Usar o bloco-base de `art/prompts/pixel/README.md` ("Mensagem de regras"), que já proíbe cenário e efeitos.
- Cada quadro tem **só o personagem e o que ele segura**. Nada de chão, plataforma, borda, cenário; nada de linhas de velocidade, rastros, smear, poeira, ondas, brilhos ou auras (efeitos são do jogo); nada preso a algo fora do quadro (cipó, corda) sem origem visível no jogo. Não escrever "com rastro", "poeira" ou "onda" na lista de quadros.
- Se a animação lança um objeto, pedir **o sprite do objeto no mesmo pedido** (arquivo próprio) e registrar no manifest.
- Anexar **sempre** a folha aprovada **e** um quadro já aprovado (ex.: `art/pixel/<personagem>/parado.png`), inclusive nas poses raras (escudo, dor, borda, descanso).
- Pedir **espaço vazio generoso** entre os quadros (nada encosta na borda da célula).
- Saída com nome de **candidato** (ex.: `_v2`) quando substitui algo em uso, para não sobrescrever o que está no jogo antes da avaliação.
- Andar e correr: poucos quadros; a velocidade é ajustada no jogo (`walk_fps`, `run_fps`, `walk_frames` no nó Visual da cena do personagem).

Ao **avaliar e integrar**:

1. Comparar cada pose lado a lado com o parado aprovado (escala, cabeça, contorno, cores).
2. Rodar a checagem de ilhas em **todas** as folhas dos **dois** personagens, não só nas que chegaram (comando abaixo). Ilha nova = sobra do quadro vizinho ou efeito solto: corrigir antes de integrar.
3. Abrir as imagens e procurar cenário e efeitos desenhados.
4. Procurar desenhos provisórios no código (`draw_circle`, `draw_arc`, `draw_rect`, `ColorRect`) que apareçam por cima da arte sem `not has_art` ou fora da depuração.
5. Fechar a etapa só com prints dentro do jogo, no zoom real, de **todos** os golpes e estados (cada ataque, especial, escudo, borda, respawn, KO, vitória), e com aprovação do criador.

```bash
godot --headless --path game --script res://tools/checar_ilhas.gd
```

## Fluxo opcional: API da OpenAI (pago à parte)

Só se o criador decidir configurar uma chave de API. `game/tools/gerar_imagem.gd` gera direto pela API (`gpt-image-2`), lendo a chave da variável `OPENAI_API_KEY`. Nunca pedir, ler ou gravar a chave. Uso:

```bash
godot --headless --path game --script res://tools/gerar_imagem.gd -- \
  --prompt-arquivo art/prompts/juba_folha.txt --saida art/conceitos/juba/folha_v1.png --qualidade medium --tamanho 1536x1024
```
