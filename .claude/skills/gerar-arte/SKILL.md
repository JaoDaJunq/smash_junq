---
name: gerar-arte
description: Gera arte do Smash Junq (folhas de personagem, conceitos, partes para animação, cenários) com a API de imagens da OpenAI (gpt-image-2), seguindo a bíblia visual. Use quando pedirem para gerar, criar ou desenhar personagens, conceitos, model sheets, partes de personagem, arenas ou qualquer imagem do jogo.
---

# Gerar arte do Smash Junq

Gera imagens com `game/tools/gerar_imagem.gd`, um script do Godot que roda **sem janela** e chama a API de imagens da OpenAI. Cada imagem sai com um `.json` ao lado (prompt e parâmetros) e uma linha em `assets/manifest.csv`.

## Regras

1. **Nunca abrir janelas.** Rodar o Godot sempre com `--headless`.
2. **Ler antes de gerar:** `design/identidade.md` (estilo, cores, personagens, prompts-modelo). Toda geração segue essa bíblia.
3. **Custo:** perguntar ao criador antes de lotes com mais de 6 imagens ou de qualquer imagem em qualidade `high`. Começar explorando em `low` ou `medium`.
4. **Chave:** nunca pedir, ler, imprimir ou gravar a chave. O script lê `OPENAI_API_KEY` do ambiente. Se faltar, explicar ao criador como configurar (abaixo).
5. **Consistência:** depois que uma folha for aprovada, usar essa imagem como `--ref` em todas as gerações seguintes do mesmo personagem.
6. **Aprovação:** imagem gerada é `conceito`. Só vira arte do jogo quando o criador aprovar; atualizar o estado em `assets/manifest.csv`.

## Como gerar

A partir da raiz do repositório:

```bash
godot --headless --path game --script res://tools/gerar_imagem.gd -- \
  --prompt-arquivo art/prompts/juba_folha.txt \
  --saida art/conceitos/juba/folha_v1.png \
  --qualidade medium --tamanho 1536x1024
```

Opções: `--prompt "texto"` (em vez de arquivo), `--qualidade low|medium|high`, `--tamanho 1024x1024|1536x1024|1024x1536`, `--fundo opaque|transparent`, `--ref imagem.png` (pode repetir), `--modelo gpt-image-2`.

- Folhas de personagem: `1536x1024`, fundo opaco.
- Partes para animação (cabeça, braços, cauda separados): `--fundo transparent` e `--ref` da folha aprovada.
- Organização: `art/prompts/` (prompts), `art/conceitos/<personagem>/` (resultados). Versões numeradas: `folha_v1`, `folha_v2`...

Depois de gerar, abrir a imagem com a ferramenta de leitura de arquivos (Read) para avaliar contra a bíblia: silhueta, cores, contorno, proporção, legibilidade. Mostrar ao criador e anotar a decisão.

## Configurar a chave (o criador faz)

1. Criar a chave em https://platform.openai.com/api-keys e colocar créditos (Billing). A assinatura do ChatGPT não vale para a API.
2. No Windows, abrir o PowerShell e rodar `setx OPENAI_API_KEY "sua-chave"` (a chave fica só no seu computador).
3. Fechar e abrir de novo o Claude/terminal para a variável valer.
