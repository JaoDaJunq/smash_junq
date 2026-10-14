# GDD — Smash Junq

> **Versão 1.0 · Etapa 1 · aprovado pelo criador em 14/10/2026**  
> Base: [brief aprovado](brief-etapa-0.md). Todas as escolhas deste documento estão aprovadas. Números de jogo (velocidades, dano, força de lançamento, tempos) são valores iniciais e mudam no playtest. Regras marcadas como **provisórias** também podem mudar depois de jogar.

## O jogo em 30 segundos

Dois lutadores numa arena flutuante. Cada golpe aumenta o **dano %** de quem apanha, e quanto maior o dano, mais longe o golpe seguinte o arremessa. Quem sai pelos limites da arena é nocauteado, e o adversário marca um **KO**. O lutador nocauteado volta ao topo da arena, e a luta continua. Vence quem marcar **3 KOs** primeiro. Dá para jogar com um amigo no mesmo PC ou contra a CPU.

## Pilares

1. **Partida rápida e legível.** Do menu à luta em poucos segundos; sempre fica claro quem está em perigo pelo número de dano.
2. **Voltar para a arena é metade da luta.** Ser lançado não é o fim: pulo duplo, agarrar a borda e golpe de recuperação dão uma chance de voltar, e o adversário pode tentar impedir.
3. **Cada personagem joga diferente.** Os especiais mudam como o personagem se aproxima, acerta e se recupera.

## Fluxo da partida

Menu → escolha de modo (2 jogadores / contra a CPU) → escolha de personagem → contagem 3, 2, 1 → luta → tela de resultado → revanche ou voltar ao menu.

- Revanche reinicia a luta com os mesmos personagens em um botão.
- Pausa a qualquer momento, com opção de reiniciar ou sair.

## Regras

| Regra | Definição |
|---|---|
| Vitória | Primeiro a 3 KOs |
| Tempo | Sem limite |
| KO simultâneo | **Provisória:** os dois marcam; se ambos chegarem a 3 juntos, morte súbita (próximo KO decide) |
| Dano | Começa em 0% a cada retorno; sem limite máximo (exibido até 999%) |
| Retorno após KO | Reaparece numa plataforma no alto da arena, invencível por 2 s ou até agir |

## Movimento

- Andar e correr (correr ao inclinar o direcional por inteiro ou tocar duas vezes).
- Pulo e **pulo duplo** no ar. Pulo curto ao soltar o botão rápido.
- **Queda rápida** apertando para baixo no auge do pulo.
- Plataformas flutuantes **atravessáveis**: sobe por baixo, desce apertando para baixo.
- **Agarrar a borda** da plataforma principal automaticamente ao chegar perto dela caindo, com subida ao apertar para cima ou pulo.

## Combate

### Ações

| Ação | Comando | Descrição |
|---|---|---|
| Ataque básico | Ataque | Muda conforme a direção e se está no chão ou no ar (ver tabela abaixo) |
| Especial | Especial | 4 especiais por personagem: neutro, lateral, para cima (recuperação) e para baixo |
| Escudo | Escudo | Bloqueia golpes enquanto segurado; desgasta e, se quebrar, deixa o lutador atordoado |
| Esquiva | Escudo + direção | Rolagem no chão ou esquiva no ar, com invencibilidade curta |
| Agarrão | Botão de agarrão, ou Escudo + Ataque | Segura o adversário à curta distância, no chão |

**Triângulo de decisões:** ataque vence agarrão (acerta antes de ele chegar), escudo vence ataque, agarrão vence escudo. Assim nenhuma defesa é segura sempre.

### Agarrão e arremessos

- Só funciona no chão e a curta distância. Errar o agarrão deixa o lutador vulnerável por um instante.
- Segurando o adversário: apertar Ataque dá golpes rápidos de pouco dano; apertar uma direção arremessa para frente, para trás, para cima ou para baixo.
- Cada arremesso tem dano e lançamento próprios, usando a mesma fórmula dos golpes.
- O agarrado se solta sozinho depois de um tempo, que fica menor quanto mais ele apertar botões e maior quanto mais dano tiver.

### Golpes básicos por personagem

| Situação | Golpe | Função |
|---|---|---|
| Chão, sem direção | Golpe rápido | Rápido, pouco dano, para interromper |
| Chão, lado | Golpe forte lateral | Mais dano e lançamento, mais lento |
| Chão, cima | Golpe para cima | Acerta quem está acima |
| Chão, baixo | Golpe baixo | Lança em ângulo baixo, bom perto da borda |
| Ar, qualquer direção | Golpe aéreo (neutro, frente, trás, cima, baixo) | Combos e disputas fora da arena |

Total por personagem: 9 golpes básicos, 4 especiais, 1 agarrão com golpe rápido e 4 arremessos.

### Dano e lançamento

Fórmula simples, toda configurável por golpe e por personagem:

```text
força_do_lançamento = base_do_golpe + (dano_% do alvo × crescimento_do_golpe) × (100 / peso do alvo)
```

- Cada golpe tem: dano, ângulo, força base, crescimento, duração de atordoamento (*hitstun*) e quadros de início, ativos e recuperação.
- Personagens mais pesados voam menos com o mesmo dano.
- Pausa curta no impacto (*hitstop*) e tremor de câmera em golpes fortes, para o acerto ter peso.
- Esses dados ficam em arquivos de configuração do Godot (Resources), não espalhados pelo código, para ajustar sem programar.

### Limites e câmera

- **Zonas de KO** retangulares fora da tela nos quatro lados. Passar delas é KO.
- **Câmera** que se afasta e aproxima para manter os dois lutadores na tela, com limite de zoom.

## Personagens temporários

Dois personagens com formas simples (cápsulas ou bonecos geométricos coloridos). A arte original entra nas Etapas 3 e 4, depois de o combate ser divertido.

**Identidade (14/10/2026):** o Ágil é **Juba**, mico-leão-dourado capoeirista, e o Pesado é **Seu Capivas**, capivara tiozão de clube. Detalhes em [identidade.md](identidade.md). No código os nomes internos continuam `agil` e `pesado`.

| | Personagem A: "Ágil" | Personagem B: "Pesado" |
|---|---|---|
| Ideia | Rápido, leve, combos | Lento, pesado, golpes que lançam longe |
| Peso | Leve (voa mais cedo) | Pesado (aguenta mais dano) |
| Especial neutro | Projétil rápido | Golpe carregável |
| Especial lateral | Investida que atravessa o palco | Agarra e arremessa à frente (funciona também no ar) |
| Especial para cima | Teletransporte curto em qualquer direção | Salto alto com golpe no topo |
| Especial para baixo | Contra-ataque (devolve o golpe recebido) | Golpe no chão que lança quem está perto |

O Ágil se aproxima e volta para a arena com facilidade; o Pesado precisa escolher bem a hora, mas um acerto resolve.

## Arena

Uma arena: plataforma principal sólida com bordas agarráveis e duas plataformas flutuantes atravessáveis acima, em formato de triângulo. Fundo neutro, sem obstáculos ou perigos.

## CPU

Máquina de estados simples, sem níveis de dificuldade no primeiro corte.

| Estado | Quando | O que faz |
|---|---|---|
| Aproximar | Longe do adversário | Anda ou pula em direção a ele |
| Atacar | Adversário ao alcance | Escolhe um golpe ou agarrão que alcança, com pequena aleatoriedade; agarra com mais frequência se o adversário estiver no escudo |
| Defender | Adversário atacando por perto | Às vezes usa escudo ou esquiva (chance configurável) |
| Recuperar | Fora da plataforma | Usa pulo duplo e especial para cima em direção à borda |
| Reagir | Depois de ser atingido ou agarrado | Espera o atordoamento, tenta se soltar e volta a aproximar |

A CPU tem um tempo de reação configurável, para não ser perfeita.

## Controles

Gamepad é o controle-alvo; teclado funciona no protótipo. Dois jogadores no mesmo teclado podem ter teclas que não registram juntas (limite do hardware), então o ideal para 2 pessoas é pelo menos um gamepad.

| Ação | Gamepad | Teclado — Jogador 1 | Teclado — Jogador 2 |
|---|---|---|---|
| Mover | Analógico esquerdo / direcional | W A S D | Setas |
| Pular | A (ou Cruz) | Espaço | Numpad 0 |
| Ataque | X (ou Quadrado) | J | Numpad 1 |
| Especial | B (ou Círculo) | K | Numpad 2 |
| Escudo / esquiva | RB ou LB | L | Numpad 3 |
| Agarrão | RT, ou Escudo + Ataque | L + J | Numpad 3 + Numpad 1 |
| Pausa | Start | Esc | Numpad Enter |

Os controles poderão ser trocados nas opções em versão futura; no primeiro corte ficam fixos.

## Interface

- Durante a luta: para cada jogador, o retrato (temporário), o dano % em número grande que muda de cor conforme cresce e os KOs marcados.
- Tela de resultado: vencedor, KOs de cada um e botões de revanche e menu.

## Fora do primeiro corte

Online e rollback; campanha ou progressão; elenco grande, várias arenas e itens. Também fora: níveis de dificuldade da CPU, troca de controles e áudio além do mínimo.

## Saída da Etapa 1

Etapa 1 **concluída** em 14/10/2026: GDD aprovado, com o agarrão incluído no primeiro corte a pedido do criador. O [backlog](backlog.md) passa a ser a lista oficial de tarefas e a Etapa 2 (engine e ponte com a IA) começa.
