# Brief de validação — Smash Junq

> **Versão 0.1 · Etapa 0 · rascunho para aprovação**  
> Este arquivo separa decisões confirmadas de recomendações provisórias. As recomendações abaixo não viram decisões do projeto até serem aprovadas pelo criador.

## Conceito confirmado

- **Gênero:** jogo de luta em plataformas (*platform fighter*), inspirado no formato de combate de Super Smash Bros.
- **Apresentação inicial:** 2D lateral.
- **Ação principal:** mover-se pela arena, acertar o adversário com ataques e habilidades próprias dos personagens e tentar lançá-lo para fora.
- **Regra central:** golpes acumulam dano; quanto maior o dano, maior tende a ser o lançamento. Vence quem tirar o oponente dos limites da arena.
- **Direção de produção:** projeto feito com apoio de IA, usando Godot 4.7.2 conforme o arsenal; geração pesada de arte/animação deve ter alternativa em nuvem.

## Recomendações provisórias para completar o brief

| Decisão em aberto | Recomendação para o primeiro protótipo | Estado |
|---|---|---|
| Plataforma | PC desktop, começando por Windows; Godot permite avaliar exportação para outras plataformas depois | Proposta |
| Modo inicial | Partida local para duas pessoas no mesmo computador | Proposta |
| Controles | Gamepads como controle-alvo; incluir teclado durante o protótipo para facilitar testes | Proposta |
| Duração | Partidas curtas, com limite de 3 minutos para a primeira rodada de testes | Proposta |
| Público | Amigos que gostam de jogos de luta casuais e partidas rápidas | Proposta |
| Diferencial | Cada personagem tem habilidades próprias que mudam como aproxima, acerta e retorna à arena | Proposta |
| Primeiro corte | Uma arena, dois personagens temporários, ataques básicos e especiais, dano, lançamento, recuperação, nocaute e reinício | Proposta |

A duração, o número de personagens e o conjunto de controles são parâmetros de teste, não especificações finais.

## Referências de sensação

- **Super Smash Bros.:** dano que aumenta o lançamento e vitória por expulsão da arena.
- **Brawlhalla:** referência de leitura lateral e combate em plataformas 2D.
- Ambas são referências de gênero e sensação. Personagens, nomes, visual, sons, cenários e código devem ser originais.

## Fora do primeiro corte

1. Multiplayer online e rollback.
2. Campanha, história extensa ou progressão entre partidas.
3. Elenco grande, múltiplas arenas e itens coletáveis.

Esses itens podem ser reavaliados depois que uma partida local curta estiver divertida e estável.

## Loop proposto

1. Escolher um personagem e entrar na arena.
2. Mover-se, saltar e atacar usando golpes básicos e habilidades próprias.
3. Acertar o oponente para elevar seu dano e potencial de lançamento.
4. Evitar ser lançado para fora ou usar a recuperação para voltar.
5. Expulsar o adversário da arena e iniciar outra partida.

**Vitória proposta:** expulsar o adversário da arena.  
**Derrota proposta:** ser expulso.  
**Empate:** se ambos forem nocauteados juntos, testar reinício da rodada; regra ainda em aberto.

## Pendências para fechar a Etapa 0

- Aprovar ou alterar plataforma, modo local, controles e duração.
- Aprovar o público e o diferencial.
- Confirmar as três exclusões do primeiro corte.
- Definir o formato de vitória: limite de tempo, número de nocautes/vidas, ou partidas sem cronômetro.
- Depois da aprovação, transformar este brief em GDD curto e backlog da Etapa 1.

## Critério para avançar

A Etapa 0 só fecha quando o criador aprovar a proposta de uma página, incluindo plataforma, controles, sessão, loop, vitória/derrota e exclusões. Até lá, este arquivo permanece um rascunho.
