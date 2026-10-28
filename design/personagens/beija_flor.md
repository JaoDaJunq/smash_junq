# Beija · ficha

> Kit aprovado pelo criador em `design/proposta-rodada11.md`. Concept escolhido: **4 · skatista** (`art/concepts/beija_flor/escolhido.png`). Programado na rodada 11 (branch `r11/b`).

| | |
|---|---|
| **id** (pasta) | `beija_flor` |
| **Bicho** | beija-flor (verde, garganta rosada e bico fino e longo) |
| **Grupo · Tipo** | Aves · **Rápido** |
| **Profissão / papel** | Skatista de pista: boné, jaqueta e shape amarelo |
| **Personalidade** | Elétrico, fala em gíria de pista, nunca fica parado |
| **Acessório de assinatura** | O **skate** (e o bico, que serve de arma) |
| **Silhueta** | O menor e mais leve do elenco: corpo miúdo, asas abertas no ar, bico comprido para a frente |
| **Cores** | penas verdes `#28A936` · boné/jaqueta `#3C8584` · roupa e skate `#ECA91C` · contorno vinho `#2a0f12` |
| **Altura no sprite** | ~40 px de 64 (o menor do elenco; Juba 52, Capivas 56) |
| **Barrinhas (1–5)** | Velocidade 5 · Força 1 · Peso 1 · Volta ao palco 5 |

**Números no jogo:** peso 62 (o mais leve; Marianinha 70), andar 380, correr 700 (o mais rápido), ar 480, 2 pulos no ar (como as outras aves), gravidade 2500. A caixa de acerto dele é mais estreita e mais baixa (44×84 px, contra 56×110 dos outros): é "muito difícil de acertar", e morre cedo porque é leve.

## Mecânica própria: pairar
Segurando o pulo no ar, o Beija fica parado batendo asa por até **1,5 s por pulo** (cada pulo, inclusive os do ar, ganha 1,5 s novos; no chão o fôlego volta cheio). Só começa quando ele já quase parou de subir; soltar o pulo ou apertar para baixo corta. Enquanto paira, anda devagar para os lados (60% da velocidade do ar). Uma barrinha verde em cima da cabeça mostra o fôlego que sobrou. Não paira depois do voo (especial para cima) nem depois de levar golpe.

## Golpes

| Golpe | Ideia | Números (quadros: início/ativo/volta · dano) |
|---|---|---|
| Jab 1 · 2 · 3 | bicadas em rajada; o **jab 3 são 4 bicadas** seguidas: 3 fracas (1%) que prendem e a última (2,4%) lança | jab 2/2/6 · 1,6% · jab 3 3/10/9 · 1+1+1+2,4% |
| Forte frente | chute de skate (bate com o shape) | 6/3/12 · 7% |
| Forte cima | ollie com o skate para cima | 5/3/11 · 5,5% |
| Forte baixo | rasteira de rodinha | 4/3/10 · 4% |
| Aéreo neutro | giro com as asas | 3/8/10 · 3,5% |
| Aéreo frente | bicada em mergulho (avança um pouco) | 5/3/12 · 6% |
| Aéreo trás | batida de asa | 4/3/12 · 5,5% |
| Aéreo cima | kickflip para cima | 4/3/12 · 5% |
| Aéreo baixo | pisão com o skate (crava para baixo) | 9/6/16 · 6% |
| Especial neutro | **Néctar**: para no ar e suga uma flor invisível por ~1 s; se ninguém o acertar nesse tempo, **cura 4%** (aposta arriscada) | 6/1/54 · sem dano · cura 4% |
| Especial lado | **Manobra**: anda de skate (bate com o corpo); **apertar pulo no meio** sai do skate com um pulo. O skate segue sozinho como projétil, rente ao chão, e **cai e some na borda** | 7/14/16 · 5,5% (corpo) · skate 4,5% |
| Especial cima | **Voo de beija-flor**: arrancada de 16 quadros (~320 px) **sem dano** na direção da alavanca (sem direção = para cima); recuperação, depois fica sem golpe até pousar | 6/16/14 · sem dano |
| Especial baixo | **Grind**: no chão desliza ~190 px num corrimão invisível e derruba (lança para cima); no ar **cai com o skate** em velocidade de queda rápida e crava (lança para baixo) | 8/18/14 · chão 6% · ar 7% |
| Agarrão e arremesso | o padrão do jogo | — |

## Extras
- **Projétil / efeito próprio:** o **skate** (projétil desenhado por código, não há folha própria) e o brilho do **néctar** (`fx_nectar`, 4 quadros).
- **Comemoração (3 poses):** a da folha `vitoria` (manobra e pose com o skate).
- **Descanso na plataforma:** sentado no skate balançando.
- **Pendurado na borda:** com uma mão, na folha `pendurado`.
- **CPU:** usa o Beija como qualquer lutador (golpes básicos, especial para o lado, voo na volta ao palco); a CPU não segura o pulo para pairar.
