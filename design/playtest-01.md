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

_(preencher depois de jogar)_
