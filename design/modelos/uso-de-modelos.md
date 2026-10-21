# Uso de modelos mais baratos (proposta · 21/10/2026)

Motivo: o Hermes no Claude Opus 5.5 está gastando muito token, porque faz tudo
sozinho: código, testes, revisão, prints, commits e conversa.

## Quem é quem
| Papel | Modelo | Custo | Quando usar |
|---|---|---|---|
| **Coordenador** (conversa com o João, decide, revisa) | Claude Opus 5.5 (Hermes) | $$$$ | Só decisões, revisão final do que vai para o João, problemas difíceis |
| **Programador** | **Claude Sonnet** (médio) | $$ | Código, testes, ferramentas, integração de personagem, primeira revisão de arte |
| **Rotina** | **Claude Haiku** (médio) | $ | Rodar scripts, importar, resumir saídas, commits, conferências mecânicas |
| **Imagens** | Codex GPT-6-Luna (alto) | (limite diário) | Igual hoje |

## Etapas do Hermes e para onde vão
| Etapa (hoje tudo no Opus) | Vai para | Por quê |
|---|---|---|
| Conversar com o João, propor golpes e personagens, aprovar | Opus | Precisa de gosto e contexto |
| Escrever fichas e pedidos de arte (livros de prompt) | Programador | É texto com modelo pronto (`_modelo.md`, `todos.md`) |
| Código de personagem novo (script, moveset, cena, teste) | Programador | Segue o padrão dos personagens que já existem |
| Corrigir bug com causa já encontrada | Programador | Instrução fechada |
| Descobrir a causa de um bug estranho | Opus | Exige investigação |
| Importar sprites, rodar `checar_personagem`, `auditar_tiras`, `manifest_add`, testes, commit e push | Rotina | Comandos fixos (receita na skill `game-sprite-review`) |
| Prints dentro do jogo (`golpes_shots`, `arena_shots`) e grades | Rotina | Comandos fixos |
| **Olhar os prints e decidir se está bom** | Opus | É onde os modelos menores erram, e o João cobra |
| Acompanhar os chats do Codex (está gerando? travou? retomar) | Rotina | Ler log e reagir |

## Como o Hermes delega
- O Hermes escreve uma **instrução curta e fechada** (o que fazer, arquivos, como testar, o que NÃO mexer) e chama o modelo barato:
  - Claude: `claude -p --model <sonnet|haiku> --effort medium --permission-mode acceptEdits "<instrução>"`
  - Codex: `codex exec -m <gpt-reserve|gpt-6-luna> -c model_reasoning_effort='"medium"' -s workspace-write "<instrução>"`
- Ao terminar, o Hermes confere **só o resultado** (diff, saída dos testes e prints) e não refaz o trabalho.
- Regra: se o modelo barato errar 2 vezes a mesma tarefa, ela sobe para o Opus.

## Economia esperada
Hoje cerca de 80% dos tokens do Opus vão para ler arquivos, rodar comandos e escrever código.
Com a divisão, o Opus fica com conversa, decisão e revisão visual: **estimativa de 60 a 75% menos Opus.**

## Resultado do teste de desempenho
(ver `teste-desempenho.md` para as tarefas e critérios)

Rodado em 21/10/2026, 3 tarefas reais, cada modelo numa cópia isolada do projeto.
T1 foi corrigida por script: o teste passa? Ele FALHA quando o efeito é removido? Mexeu em outros arquivos?

| Modelo | T1 código+teste | T2 revisão de arte | T3 resumo de rotina | Total | Custo (T1+T2+T3) |
|---|---|---|---|---|---|
| Claude Sonnet | 10 | 9 | 10 | **29/30** | US$ 0,31 |
| Claude Haiku | 10 | 9 | 9 | **28/30** | US$ 0,03 |
| GPT-6-Luna (Codex) | 10 | 7 (reprovou a folha boa) | 8 | 25/30 | cota do Codex |
| GPT-Reserve (Codex) | 10 | **2 (aprovou a folha quebrada)** | 8 | 20/30 | cota do Codex |

O que o teste mostrou:
- Código simples com teste: os 4 acertaram, e os testes deles pegam o erro de verdade.
- Revisão de arte é o ponto fraco: o GPT-Reserve aprovou a folha quebrada da Sucuri, e o Luna reprovou a da Canga, que estava boa.
- O Haiku ficou quase igual ao Sonnet e custou 10 vezes menos.
- Os do Codex gastam a **mesma cota das imagens**: usar o Codex para código tira imagem do dia. Por isso, o código vai para o Claude.

Decisão proposta:
1. Código: **Sonnet**. Se a tarefa for pequena e bem descrita, **Haiku**.
2. Rotina (importar, rodar testes, resumir, commit): **Haiku**.
3. Revisão de arte: **Sonnet faz a primeira olhada**, e o **Opus dá a palavra final** em tudo que vai para o João.
4. Codex continua só para imagens.

Limites do teste: as tarefas são pequenas. Um personagem inteiro ou um bug difícil podem não sair tão bem. Por isso vale a regra de que, depois de 2 erros na mesma tarefa, ela sobe para o Opus.

