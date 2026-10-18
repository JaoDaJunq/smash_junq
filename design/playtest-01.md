# Playtest 01 — primeiro corte (greybox)

> Roteiro da T22. Jogue no PC de casa, com o build exportado (`builds/SmashJunq.exe`) ou pelo editor (F5). Anote as respostas nas seções "Notas" e marque a T22 como feita no [backlog](backlog.md).

## Antes de jogar

- [ ] Especificações do PC de casa anotadas no README (T01).
- [ ] Gamepad conectado, se houver (T04).
- [ ] Jogo abre no menu sem travar.

## Roteiro

1. **Contra a CPU, Ágil x Pesado.** Jogue uma partida inteira até 3 KOs.
2. **Contra a CPU, Pesado x Ágil.** Troque os lados e jogue de novo.
3. **2 jogadores**, se tiver alguém (ou jogue os dois lados para testar controles). Uma partida inteira.
4. Use a pausa, reinicie uma partida e use "Revanche" na tela de resultado.
5. **Treino** (Jogar → Treino): escolha um dano para o boneco (ex.: 80%, 120%, 150%), ligue "Manter esse dano" e teste os golpes fortes. Anote em que faixa de dano cada golpe começa a tirar o boneco da arena e se isso parece cedo ou tarde.
6. No fim, copie a pasta `%APPDATA%\Godot\app_userdata\Smash Junq\playtest\` (arquivos `partidas.jsonl` e `treino.jsonl`) para dentro do repositório em `design/playtest-01-dados/` e mande um commit, ou envie para a IA.

## O que observar

| Pergunta | Notas |
|---|---|
| Os controles respondem na hora? Algum botão estranho ou difícil? | |
| Correr, pular, pulo duplo e voltar para a arena são fáceis de entender? | |
| Os golpes parecem ter peso (pausa no impacto, tremor da tela)? | |
| Com quantos % de dano um golpe forte começa a tirar o adversário da arena? Cedo ou tarde demais? | |
| O Pesado está resistente demais? (Na simulação CPU x CPU ele aguentou 230–296%.) | |
| O Ágil e o Pesado jogam de jeitos diferentes de verdade? | |
| Escudo, rolagem, esquiva no ar e agarrão funcionam como esperado? | |
| A CPU está fácil, difícil ou justa? Ela faz algo bobo (cair sozinha, travar)? | |
| Quanto durou cada partida? (O GDD espera de 3 a 5 minutos.) | |
| Foi divertido? O que mais incomodou? O que deu vontade de jogar de novo? | |

## Resultado automático antes do playtest (14/10/2026)

Quatro partidas completas CPU x CPU, simuladas sem janela (detalhes e cada KO em [`evidence/etapa-2/cpu-vs-cpu.txt`](../evidence/etapa-2/cpu-vs-cpu.txt)):

- Todas terminaram com vencedor, entre **3:34 e 4:20** de jogo, dentro dos 3 a 5 minutos do GDD.
- A maioria dos KOs foi pelas laterais. O Ágil caiu entre ~150% e 190%; o Pesado entre ~210% e 296%.
- A simulação mede o jogo entre duas CPUs iguais; só o playtest humano diz se a luta é divertida.

## Notas

Playtest humano do João, 15 a 18/10/2026, pelo jogo aberto direto do Godot (sem o `.exe`), no PC com NVIDIA RTX 3050 6 GB (notebook). Dados em [`playtest-01-dados/`](playtest-01-dados/).

**Partida contra a CPU (18/10):** João (Juba) 3 x 2 CPU (Seu Capivas), 5:46. O Seu Capivas caiu com 285% e 320% (resistente demais, como na simulação); o Juba caiu com 202% (sem conseguir voltar) e 118%. KOs do Juba vieram do especial lateral (2) e do especial para baixo. Treino: 248 golpes registrados.

| Pergunta | Notas |
|---|---|
| Controles | Bons. Escudo quase não foi usado; pedido: Shift como botão único de defesa (parado = escudo, andando/no ar = esquiva intocável, estilo Brawlhalla) e controles editáveis, inclusive mouse. Feito. |
| Peso dos golpes | Muita coisa "MUITO boa". Ataque básico parecia duro (sempre o mesmo tapa): virou sequência de 3 golpes, aprovada. |
| % para KO / Pesado resistente | Seu Capivas aguenta demais (285–320%). Ajuste de peso fica para a próxima rodada. |
| Ágil x Pesado diferentes | Sim. |
| CPU | Justa; venceu 2 KOs. |
| Duração | 5:46, um pouco acima dos 3–5 min do GDD (efeito do Pesado resistente). |
| Arte e animação | Rodada 1: andar/correr tremidos, cipó, escudo fora do padrão, borda com plataforma desenhada, círculo azul, bola azul no lugar da castanha, respawn, carregado com efeitos desenhados e sobras na sentada. Tudo corrigido (ver `art/prompts/pedidos/PLAYTEST01_CODEX.md`). Rodada 2: carregado ilegível, borda com animação demais, comemoração rápida demais: corrigidos. |
| Arenas | A arena original "estava meio feia": 3 arenas novas em pixel art (Pantanal, Caatinga, Cerrado), escolhidas na tela de personagens. |

**Falta para fechar a T22 pelo critério do backlog:** rodar o `.exe` exportado no PC de casa e jogar uma partida no modo 2 jogadores.
