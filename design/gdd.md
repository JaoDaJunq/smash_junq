# GDD — Smash Junq

> **Versão 0.1 · Etapa 1 · rascunho para aprovação**  
> Base: [brief aprovado](brief-etapa-0.md). Itens marcados **Aprovado** vêm do brief. Itens marcados **Proposta** são recomendações para o primeiro corte e só viram decisão com aprovação do criador. Números de jogo (velocidades, dano, força de lançamento) são valores iniciais para ajustar no playtest.

## O jogo em 30 segundos

Dois lutadores numa arena flutuante. Cada golpe aumenta o **dano %** de quem apanha, e quanto maior o dano, mais longe o golpe seguinte o arremessa. Quem sai pelos limites da arena é nocauteado, e o adversário marca um **KO**. O lutador nocauteado volta ao topo da arena, e a luta continua. Vence quem marcar **3 KOs** primeiro. Dá para jogar com um amigo no mesmo PC ou contra a CPU. **Aprovado**

## Pilares

1. **Partida rápida e legível.** Do menu à luta em poucos segundos; sempre fica claro quem está em perigo pelo número de dano.
2. **Voltar para a arena é metade da luta.** Ser lançado não é o fim: pulo duplo e golpe de recuperação dão uma chance de voltar, e o adversário pode tentar impedir.
3. **Cada personagem joga diferente.** Os especiais mudam como o personagem se aproxima, acerta e se recupera. **Aprovado** (diferencial do brief)

## Fluxo da partida

Menu → escolha de modo (2 jogadores / contra a CPU) → escolha de personagem → contagem 3, 2, 1 → luta → tela de resultado → revanche ou voltar ao menu. **Proposta** de telas; modos **Aprovado**.

- Revanche reinicia a luta com os mesmos personagens em um botão.
- Pausa a qualquer momento, com opção de reiniciar ou sair.

## Regras

| Regra | Definição | Estado |
|---|---|---|
| Vitória | Primeiro a 3 KOs | Aprovado |
| Tempo | Sem limite | Aprovado |
| KO simultâneo | Os dois marcam; se ambos chegarem a 3 juntos, morte súbita (próximo KO decide) | Provisória, testar |
| Dano | Começa em 0% a cada retorno; sem limite máximo (exibido até 999%) | Proposta |
| Retorno após KO | Reaparece numa plataforma no alto da arena, invencível por 2 s ou até agir | Proposta |

## Movimento

**Proposta** de conjunto mínimo, comum ao gênero:

- Andar e correr (correr ao manter o direcional inclinado por inteiro ou tocar duas vezes).
- Pulo e **pulo duplo** no ar. Pulo curto ao soltar o botão rápido.
- **Queda rápida** apertando para baixo no auge do pulo.
- Plataformas flutuantes **atravessáveis**: sobe por baixo, desce apertando para baixo.
- **Agarrar a borda** da plataforma principal automaticamente ao chegar perto dela caindo, com subida ao apertar para cima ou pulo. Ajuda muito na recuperação.

## Combate

### Ações

| Ação | Botão | Descrição | Estado |
|---|---|---|---|
| Ataque básico | Ataque | Muda conforme a direção e se está no chão ou no ar (ver tabela abaixo) | Proposta |
| Especial | Especial | 4 especiais por personagem: neutro, lateral, para cima (recuperação) e para baixo | Aprovado (básicos e especiais no corte) |
| Escudo | Escudo | Bloqueia golpes enquanto segurado; desgasta e, se quebrar, deixa o lutador atordoado | Proposta |
| Esquiva | Escudo + direção | Rolagem no chão ou esquiva no ar, com invencibilidade curta | Proposta |
| Agarrão e arremesso | — | Fora do primeiro corte | Proposta |

### Golpes básicos por personagem

| Situação | Golpe | Função |
|---|---|---|
| Chão, sem direção | Golpe rápido | Rápido, pouco dano, para interromper |
| Chão, lado | Golpe forte lateral | Mais dano e lançamento, mais lento |
| Chão, cima | Golpe para cima | Acerta quem está acima |
| Chão, baixo | Golpe baixo | Lança em ângulo baixo, bom perto da borda |
| Ar, qualquer direção | Golpe aéreo (neutro, frente, trás, cima, baixo) | Combos e disputas fora da arena |

Total: 9 golpes básicos + 4 especiais por personagem. **Proposta**

### Dano e lançamento

**Proposta** de fórmula simples, toda configurável por golpe e por personagem:

```text
força_do_lançamento = base_do_golpe + (dano_% do alvo × crescimento_do_golpe) × (100 / peso do alvo)
```

- Cada golpe tem: dano, ângulo, força base, crescimento, duração de atordoamento (*hitstun*) e quadros de início, ativos e recuperação.
- Personagens mais pesados voam menos com o mesmo dano.
- Pausa curta no impacto (*hitstop*) e tremor de câmera em golpes fortes, para o acerto ter peso.
- Esses dados ficam em arquivos de configuração do Godot (Resources), não espalhados pelo código, para ajustar sem programar.

### Limites e câmera

- **Zonas de KO** retangulares fora da tela nos quatro lados. Passar delas é KO. **Proposta**
- **Câmera** que se afasta e aproxima para manter os dois lutadores na tela, com limite de zoom. **Proposta**

## Personagens temporários

Para o primeiro corte, dois personagens com formas simples (cápsulas ou bonecos geométricos coloridos). A arte original entra na Etapa 3 e 4, depois de o combate ser divertido. **Proposta**

| | Personagem A: "Ágil" | Personagem B: "Pesado" |
|---|---|---|
| Ideia | Rápido, leve, combos | Lento, pesado, golpes que lançam longe |
| Peso | Leve (voa mais cedo) | Pesado (aguenta mais dano) |
| Especial neutro | Projétil rápido | Golpe carregável |
| Especial lateral | Investida que atravessa o palco | Agarra e arremessa à frente |
| Especial para cima | Teletransporte curto em qualquer direção | Salto alto com golpe no topo |
| Especial para baixo | Contra-ataque (devolve o golpe recebido) | Golpe no chão que lança quem está perto |

Os especiais de cada um mostram o diferencial do brief: o Ágil se aproxima e volta para a arena com facilidade; o Pesado precisa escolher bem a hora, mas um acerto resolve.

## Arena

Uma arena: plataforma principal sólida com bordas agarráveis e duas plataformas flutuantes atravessáveis acima, em formato de triângulo. Fundo neutro, sem obstáculos ou perigos. **Proposta** (uma arena **Aprovado**)

## CPU

Máquina de estados simples, sem níveis de dificuldade no primeiro corte. **Aprovado** (escopo); comportamento abaixo é **Proposta**.

| Estado | Quando | O que faz |
|---|---|---|
| Aproximar | Longe do adversário | Anda ou pula em direção a ele |
| Atacar | Adversário ao alcance de algum golpe | Escolhe um golpe que alcança, com pequena aleatoriedade |
| Defender | Adversário atacando por perto | Às vezes usa escudo ou esquiva (chance configurável) |
| Recuperar | Fora da plataforma | Usa pulo duplo e especial para cima em direção à borda |
| Reagir | Depois de ser atingido | Espera o atordoamento e volta a aproximar |

A CPU tem um tempo de reação configurável, para não ser perfeita.

## Controles

**Proposta.** Gamepad é o controle-alvo; teclado funciona no protótipo. Dois jogadores no mesmo teclado podem ter teclas que não registram juntas (limite do hardware), então o ideal para 2 pessoas é pelo menos um gamepad.

| Ação | Gamepad | Teclado — Jogador 1 | Teclado — Jogador 2 |
|---|---|---|---|
| Mover | Analógico esquerdo / direcional | W A S D | Setas |
| Pular | A (ou Cruz) | Espaço | Numpad 0 |
| Ataque | X (ou Quadrado) | J | Numpad 1 |
| Especial | B (ou Círculo) | K | Numpad 2 |
| Escudo / esquiva | RB ou LB | L | Numpad 3 |
| Pausa | Start | Esc | Numpad Enter |

Os controles poderão ser trocados nas opções em versão futura; no primeiro corte ficam fixos.

## Interface

- Durante a luta: para cada jogador, o retrato (temporário), o dano % em número grande que muda de cor conforme cresce e os KOs marcados. **Proposta**
- Tela de resultado: vencedor, KOs de cada um e botões de revanche e menu.

## Fora do primeiro corte

Online e rollback; campanha ou progressão; elenco grande, várias arenas e itens (todos **Aprovado** no brief). Também fora, por **Proposta**: agarrão, níveis de dificuldade da CPU, troca de controles, áudio além do mínimo.

## Critério para fechar a Etapa 1

O criador aprova este GDD (ou a versão revisada), em especial: movimento, escudo e esquiva, fórmula de lançamento, os dois personagens temporários, a arena, a CPU e os controles. Com isso aprovado, o [backlog](backlog.md) vira a lista oficial de tarefas e a Etapa 2 começa.
