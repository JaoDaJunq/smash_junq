# Brief de validação — Smash Junq

> **Versão 1.0 · Etapa 0 · aprovado pelo criador em 14/10/2026**  
> Este arquivo separa decisões confirmadas de regras provisórias. Tudo o que está marcado como provisório será ajustado no protótipo, depois de jogar.

## Conceito confirmado

- **Gênero:** jogo de luta em plataformas (*platform fighter*), inspirado no formato de combate de Super Smash Bros.
- **Apresentação inicial:** 2D lateral.
- **Ação principal:** mover-se pela arena, acertar o adversário com ataques e habilidades próprias dos personagens e tentar lançá-lo para fora.
- **Regra central:** golpes acumulam dano; quanto maior o dano, maior tende a ser o lançamento. Vence quem tirar o oponente dos limites da arena.
- **Vitória por nocautes:** a partida é decidida pelo número de KOs, sem cronômetro como condição principal.
- **Direção de produção:** projeto feito com apoio de IA, usando Godot 4.7.2 conforme o arsenal; geração pesada de arte/animação deve ter alternativa em nuvem.

## Decisões do primeiro protótipo

| Decisão | Definição | Estado |
|---|---|---|
| Plataforma | PC desktop, começando por Windows; Godot permite avaliar exportação para outras plataformas depois | Aprovada |
| Modos | Partida local para duas pessoas no mesmo computador **e** jogador contra a CPU | Aprovada |
| Oponente CPU | Comportamento simples: aproximar, atacar, defender-se de vez em quando e tentar recuperar quando for lançado. Sem níveis de dificuldade no primeiro corte | Aprovada; comportamento detalhado no GDD |
| Controles | Gamepads como controle-alvo; teclado também suportado durante o protótipo para facilitar testes | Aprovada |
| Formato da partida | Cada nocaute soma para o placar; vence quem chegar primeiro a **3 KOs**. Sem limite de tempo | Aprovada; meta pode mudar após playtest |
| Duração esperada | 3 a 5 minutos por partida | Estimativa, medir no protótipo |
| Público | Amigos que gostam de jogos de luta casuais e partidas rápidas | Aprovada |
| Diferencial | Cada personagem tem habilidades próprias que mudam como se aproxima, acerta e retorna à arena | Aprovada |
| Primeiro corte | Uma arena, dois personagens temporários, ataques básicos e especiais, dano, lançamento, recuperação, nocaute e reinício | Aprovada |

## Regras provisórias para testar

- **Nocautes simultâneos:** os dois jogadores recebem o KO. Se ambos chegarem à meta ao mesmo tempo, a partida segue em morte súbita: o próximo KO decide.
- **Encerrar por diferença de pontos:** fora do primeiro teste.

Essas regras existem para o protótipo funcionar do começo ao fim. Elas mudam se o playtest mostrar algo melhor.

## Referências de sensação

- **Super Smash Bros.:** dano que aumenta o lançamento e vitória por expulsão da arena.
- **Brawlhalla:** referência de leitura lateral e combate em plataformas 2D.
- Ambas são referências de gênero e sensação. Personagens, nomes, visual, sons, cenários e código devem ser originais.

## Fora do primeiro corte (confirmado)

1. Multiplayer online e rollback.
2. Campanha, história extensa ou progressão entre partidas.
3. Elenco grande, múltiplas arenas e itens coletáveis.

Esses itens podem ser reavaliados depois que uma partida local curta estiver divertida e estável.

## Loop

1. Escolher o modo (2 jogadores ou contra a CPU) e um personagem, e entrar na arena.
2. Mover-se, saltar e atacar usando golpes básicos e habilidades próprias.
3. Acertar o oponente para elevar seu dano e potencial de lançamento.
4. Evitar ser lançado para fora ou usar a recuperação para voltar.
5. Nocautear o adversário e somar KOs até alcançar 3.

**Vitória:** chegar a 3 KOs antes do adversário.  
**Derrota:** o adversário chegar a 3 KOs primeiro.  
**Empate:** regra provisória de morte súbita, descrita acima.

## Saída da Etapa 0

Etapa 0 **concluída** em 14/10/2026: plataforma, controles, sessão, loop, vitória/derrota e exclusões aprovados pelo criador.

**Próximo passo (Etapa 1):** transformar este brief em um GDD curto e num backlog de tarefas pequenas para o primeiro corte.
