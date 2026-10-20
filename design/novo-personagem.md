# Novo personagem · tudo o que precisa

Este documento é o roteiro para colocar um lutador novo no jogo sem retrabalho. Ele foi tirado do que o **Juba** e o **Seu Capivas** usam hoje no jogo.

- Troque `<id>` pelo nome do personagem em minúsculas, sem acento e com `_` no lugar de espaço. Exemplos: `mestre_muriqui`, `arara_canga`.
- Para conferir o que já está pronto e o que falta: `python game/tools/checar_personagem.py <id>`.

## Etapas e aprovações

| # | Etapa | Quem faz | O que o João aprova |
|---|---|---|---|
| 1 | **Ficha** do personagem: conceito, golpes e paleta (modelo em `design/personagens/_modelo.md`) | Hermes | A ficha inteira |
| 1b | **4 concept arts**: 4 direções de roupa e atitude do mesmo bicho, em `art/concepts/<id>/` | Codex | **Qual concept vamos seguir** |
| 2 | **Sprite base**: uma pose de referência, seguindo o concept escolhido | Codex | O visual do personagem em pixel art |
| 3 | **Lote 1**: dá para jogar | Codex → Hermes integra | Playtest rápido |
| 4 | **Lote 2**: golpes completos | Codex → Hermes integra | Playtest |
| 5 | **Lote 3**: quadros intermediários (fluidez) | Codex → Hermes integra | Playtest |
| 6 | **Interface**: retrato e arte de apresentação | Codex → Hermes integra | Print das telas |
| 7 | **Código**, balanceamento e testes | Hermes | Partida contra a CPU |

Só se passa para a etapa seguinte depois que a anterior for aprovada. Nenhum sprite é pedido antes da escolha do concept: ele é a referência de todos os pedidos dali em diante. O sprite base é o que mais economiza tempo: se ele estiver errado, todo o resto sai errado.

## 1 · Ficha: `design/personagens/<id>.md`

A ficha precisa ter:
- nome;
- bicho;
- grupo e tipo (veja `design/elenco.md`);
- profissão ou papel;
- personalidade;
- acessório de assinatura;
- 3 cores, com os códigos hex;
- altura em pixels (o Juba tem cerca de 52, o Capivas cerca de 56);
- a ideia de cada golpe;
- o projétil ou efeito próprio, se houver;
- as poses da comemoração.

**Regra de ouro:** o personagem tem que ser tão característico quanto o Juba e o Capivas. Isso quer dizer uma profissão, um jeito de lutar que vem dela, uma silhueta que se reconhece de longe e humor.

## 1b · Concept arts: `art/concepts/<id>/conceito_<n>_<direcao>.png`
Quatro folhas de 1536×1024, uma por direção, em fundo bege liso e sem texto. Cada folha traz:
- o personagem de corpo inteiro, em pose de apresentação;
- o personagem de perfil, em movimento;
- 3 rostos com expressões diferentes.

O estilo é o das artes de apresentação (cartoon de jogo de luta). Muda só a roupa e a atitude, e o bicho continua o mesmo nos 4. O pedido vai em `art/prompts/pedidos/<id>/c01_concepts.md`.

## 2 a 5 · Sprites: `art/pixel/<id>/`

**Padrão de todas as folhas:**

| Item | Valor |
|---|---|
| Tamanho da folha | 1536×1024 |
| Grade | 3 colunas × 2 linhas, com até 6 quadros |
| Quadro | 64×64 pixels, ampliado 8× (512×512 por célula) |
| Fundo | magenta `#FF00FF` |
| Direção | de perfil, olhando para a **direita** |
| Pés | sempre na mesma linha, 4 px acima da borda de baixo |
| Contorno | 1 px, vinho-escuro |
| Proibido | chão, poeira, rastro, brilho, aura ou qualquer pedaço de cenário (os efeitos são feitos pelo jogo) |

Mais regras e as mensagens de correção para o Codex estão em `art/prompts/pixel/README.md`. Cada pedido anexa o `base.png` aprovado e o `parado.png` aprovado.

### Etapa 2 · Base (1 imagem)
| Arquivo | Conteúdo |
|---|---|
| `base.png` | **1024×1024**, um quadro só, ampliado 16×, na pose parada de referência |

### Etapa 3 · Lote 1: jogável (12 folhas, 61 quadros)
| Arquivo | Quadros | O que tem em cada quadro |
|---|---:|---|
| `parado.png` | 4 | Respirando em guarda (fica em loop) |
| `andar.png` | 6 | Ciclo de passos (loop) |
| `correr.png` | 6 | Ciclo de corrida (loop) |
| `pulo.png` | 6 | 1 agachando · 2 impulso · 3 subindo · 4 topo · 5 caindo · 6 pouso |
| `transicoes_a.png` | 6 | 1-3 **virar** de lado · 4-6 **arrancar** para correr |
| `transicoes_b.png` | 6 | 1-3 **frear** · 4-6 **pouso** do pulo |
| `jab.png` | 3 | 1º soco: preparo · impacto · volta |
| `jab_b.png` | 3 | 2º soco, com a outra mão: preparo · impacto · volta |
| `jab_c.png` | 3 a 5 | 3º golpe, o mais forte, que fecha a sequência |
| `golpe_frente.png` | 5 | Golpe forte para a frente: 1-2 preparo · **3 impacto** · 4-5 volta |
| `defesa_esquiva.png` | 6 | 1-2 **escudo** (defendendo) · 3-6 **esquiva** rolando |
| `dor.png` | 4 | 1-2 levando o golpe · 3-4 lançado no ar, girando |

### Etapa 4 · Lote 2: golpes completos (16 folhas, 78 quadros)
| Arquivo | Quadros | O que tem em cada quadro |
|---|---:|---|
| `golpe_cima.png` | 5 | Golpe para cima, com impacto no 3º quadro |
| `golpe_baixo.png` | 5 | Golpe baixo ou rasteira, com impacto no 3º quadro |
| `aereo_neutro.png` | 5 | Golpe no ar, sem direção |
| `aereo_frente.png` | 5 | No ar, para a frente |
| `aereo_tras.png` | 5 | No ar, para trás (ainda olhando para a direita, golpeando para trás) |
| `aereo_cima.png` | 5 | No ar, para cima |
| `aereo_baixo.png` | 5 | No ar, para baixo |
| `especial_neutro.png` | 6 | Especial neutro: 1-3 preparo · **4 impacto ou soltar o projétil** · 5-6 volta |
| `especial_lado.png` | 6 | Especial para o lado |
| `especial_cima.png` | 6 | Especial para cima (é o golpe de recuperação, para voltar ao palco) |
| `especial_baixo.png` | 6 | Especial para baixo |
| `agarrar.png` | 6 | 1 esticando a mão · 2 segurando · 3-6 arremesso |
| `tonto.png` | 4 | Tonto depois de ter o escudo quebrado (loop) |
| `pendurado.png` | 2 | Pendurado na borda com **uma mão** só, respirando |
| `descanso.png` | 4 | Sentado descansando na plataforma de volta (loop) |
| `vitoria.png` | **3 a 4** | Comemoração enxuta, sem quadros intermediários |

**Se houver projétil ou efeito próprio** (como a castanha ou as folhas do Juba), cada um ganha **uma folha separada** no mesmo padrão: `<objeto>.png`, com 4 a 6 quadros.

### Etapa 5 · Lote 3: fluidez (17 folhas, cerca de 80 quadros)
Os quadros intermediários vão em `<animacao>_meio.png`. Cada um desenha a pose **entre** dois quadros da folha principal: entre o 1 e o 2, entre o 2 e o 3, e assim por diante. Nas animações em loop, entra também o quadro entre o último e o primeiro.

| Arquivo | Quadros |
|---|---:|
| `parado_meio`, `andar_meio`, `correr_meio` | 4 · 6 · 6 |
| `pulo_meio` | 5 |
| `golpe_frente_meio`, `golpe_cima_meio`, `golpe_baixo_meio` | 4 cada |
| `aereo_neutro_meio`, `aereo_frente_meio`, `aereo_tras_meio`, `aereo_cima_meio`, `aereo_baixo_meio` | 4 cada |
| `especial_neutro_meio`, `especial_lado_meio`, `especial_cima_meio`, `especial_baixo_meio` | 5 cada |
| `dor_meio`, `tonto_meio` | 3 · 4 |

**Total de sprites por personagem:** 1 base e 28 folhas com cerca de 139 quadros. Com a fluidez, são mais 17 folhas e cerca de 80 quadros.

**Não pedir mais:** `borda.png` (foi substituída pelo `pendurado`) e comemorações de 6 poses.

## 6 · Interface: `art/ui/`
| Arquivo | Tamanho | Uso no jogo |
|---|---|---|
| `retrato_<id>.png` | 1024×1024, busto em pixel art (128 px ampliados 8×), fundo magenta | Fotinho na grade de personagens |
| `apresentacao_<id>.png` | 1024×1536, corpo inteiro em cartoon "comercial", fundo magenta | Arte de divulgação (menu e telas) |

Para importar: `python game/tools/importar_ui.py`. O retrato vai para `game/assets/characters/<id>/retrato_pixel.png` e a arte de apresentação para `game/assets/ui/`.

## 7 · Código (Hermes)
| Arquivo | O que ganha |
|---|---|
| `game/scenes/characters/<id>.tscn` | O lutador: peso, velocidades, pulo, colisão e pasta dos sprites |
| `game/scripts/characters/<id>.gd` | A lógica dos especiais (projétil, investida, contra-ataque...) |
| `game/data/movesets/<id>.tres` | Dano, tempo e alcance de cada golpe |
| `game/scripts/match/game_state.gd` | Entrada em `CHARACTERS`: id, nome, descrição, peso e barrinhas |
| `game/scripts/ui/roster.gd` | Troca o "?" do personagem na grade pelo índice dele |
| `game/tools/importar_pixel.gd` | Ajustes da folha, só se precisar (quadro de impacto fora do padrão, quadros a pular) |
| `game/tests/<id>_smoke.gd` | Teste dos especiais e da arte importada |
| `assets/manifest.csv` | Uma linha para cada imagem nova |

Para importar os sprites: `godot --headless --path game --script res://tools/importar_pixel.gd -- <id>`. O resultado vai para `game/assets/characters/<id>/pixel/`.

## Pedidos ao Codex
- **Ficha de arte (paleta e regras):** `art/prompts/pixel/<id>.md`.
- **Pedidos de cada lote:** `art/prompts/pedidos/<id>/l<lote>_<folha>.md`.
- **Candidatos recusados:** `art/pixel/<id>/candidatos/` (nunca entram no jogo).

## Economia do gerador de imagens (regra do João, 20/10/2026)
O gerador tem limite de ~220 imagens a cada 24 h (plano Plus). O que mais gasta é refazer em massa.
- **Portão da base:** o Codex entrega só `base.png` + `parado.png` e **para**. O Hermes confere (limpeza, escala, igual ao concept) e só depois manda seguir com o resto. Base ruim nunca vira 50 folhas ruins.
- No máximo **2 tentativas** por folha: defeito de grade, escala ou sujeira o Hermes corrige com ferramenta (`normalizar_folha.py`, `limpar_bordas.py`).
- Refação só das folhas que a revisão reprovou, nunca do lote inteiro.
- No máximo **2 chats do Codex** gerando ao mesmo tempo.
- Bateu o limite: o Codex **para e avisa**. Nunca monta imagem à mão para completar arquivo.
