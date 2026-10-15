# Smash Junq: regras para os agentes

Jogo de luta em plataformas 2D (estilo Smash) em Godot 4.7.2, com Juba e Seu Capivas como lutadores. O criador é o João. Ele fala em português, sem jargão técnico, e aprova cada etapa antes de avançar.

Este arquivo vale para todos os agentes: o Hermes (que coordena), o Claude Code e o Codex.

## Onde está o estado do projeto

- `README.md`: o que já funciona, como rodar e os testes.
- `docs/arsenal-jogo-ia.md`: a rota de 8 etapas (0 a 7) e o critério para aprovar cada uma.
- `design/backlog.md`: lista oficial de tarefas.
- `design/gdd.md` e `design/identidade.md`: o design do jogo e a bíblia visual.
- `git log`: o que foi feito por último.

Antes de começar qualquer tarefa, rode `git pull` e leia o que for relevante acima.

## Quem faz o quê

| Agente | Papel |
|---|---|
| **Hermes** | Coordena. Recebe os pedidos do João, divide em tarefas, passa cada uma para o agente certo e devolve um resumo curto. Não edita o projeto ele mesmo. |
| **Claude Code** | Planejamento e andamento: backlog, próximos passos, critérios das etapas. Também cuida do código GDScript, dos testes, da integração dos assets no Godot, da avaliação das imagens contra a bíblia visual e da documentação. |
| **Codex** | Gera as imagens do jogo com a geração de imagens dele (login do ChatGPT, sem chave de API). Segue `art/prompts/` e `design/identidade.md`, anexa a folha aprovada do personagem como referência e salva os arquivos nas pastas indicadas no pedido. Também pode revisar código quando pedirem uma segunda opinião. |

Fluxo de arte: o Claude Code escreve o pedido (prompt, arquivo de referência, nome e pasta de saída) → o Codex gera e salva → o Claude Code avalia e integra, ou escreve a correção para o Codex refazer. Detalhes em `.claude/skills/gerar-arte/SKILL.md`.

## Regras

- Um agente por vez em cada conjunto de arquivos. Se duas tarefas mexem nos mesmos arquivos, elas rodam uma depois da outra.
- Commits pequenos e com mensagem clara, ao fim de cada tarefa. `git push` só depois que o João aprovar.
- Só assets próprios ou CC0. Todo asset novo entra em `assets/manifest.csv`.
- Godot sempre com `--headless` (exemplos no README). Se o comando `godot` não existir, avise o João em vez de tentar instalar.
- Respostas ao João em português simples: o que mudou, o que falta e o que ele precisa decidir.
