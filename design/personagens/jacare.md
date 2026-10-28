# Papo-Amarelo · ficha

> Rodada 11. Concept escolhido: **4 · pescador** (`art/concepts/jacare/escolhido.png`). Golpes aprovados em `design/proposta-rodada11.md`; esta ficha registra também os números que o código usa.

| | |
|---|---|
| **id** (pasta) | `jacare` |
| **Bicho** | jacaré-de-papo-amarelo |
| **Grupo · Tipo** | Répteis · **Pesado** |
| **Profissão / papel** | Pescador de rio. Paciente, conta história de pescador ("tinha dois metros!") |
| **Personalidade** | Calmo, teimoso, exagerado nas histórias. O mais pesado do jogo |
| **Acessório de assinatura** | Vara de pescar (ela é o "braço comprido" dos golpes), chapéu de palha e colete de pescador |
| **Silhueta** | O maior do elenco: corpo largo, focinho comprido, rabo grosso arrastando |
| **Cores** | principal verde-oliva · apoio papo amarelo · destaque marrom do colete · contorno vinho `#2a0f12` |
| **Altura no sprite** | ~58 px de 64 (o maior; Juba 52, Capivas 56) |
| **Barrinhas (1–5)** | Velocidade 1 · Força 5 · Peso 5 · Volta ao palco 3 |

**Números no jogo:** peso 130 (Seu Capivas 125), andar 250, correr 450, ar 340, gravidade 2800, pulo 980, pulo duplo 880.

## Mecânica própria: anzol
A linha de pesca prende na borda (ele é o único que volta ao palco puxando a linha) e fisga o adversário de longe. O anzol (`anzol_pesca.gd`) e a rede (`rede_pesca.gd`) são objetos próprios; o resto está em `papo_amarelo.gd`.

## Golpes

| Golpe | Ideia | Números |
|---|---|---|
| Jab 1 · 2 · 3 | tapa de pata, tapa, mordida | 4,5% · lento para um jab (4 quadros de início) |
| Forte frente | **varada** com a vara (alcance longo) | 13% · início 13 · ângulo 32° |
| Forte cima | mordida para cima | 11% · ângulo 88° |
| Forte baixo | rabada rasteira | 9% · ângulo 22° |
| Aéreo neutro | rolamento (corpo todo, acerta em volta) | 8,5% |
| Aéreo frente | mordida | 14% |
| Aéreo trás | rabada | 13% |
| Aéreo cima | bocejo gigante (a boca abre para cima) | 10% |
| Aéreo baixo | barrigada (cravada para baixo) | 14% · 20 quadros de recuperação ao pousar |
| **Especial neutro · Fisgada** | Lança o anzol na direção que o jogador segurar **depois do toque** (8 direções; sem direção, para a frente). Alcance 430 px. Se fisga, puxa o adversário até a boca e dá uma mordida curta | fisgada 2% + mordida 4,5% = 6,5%. Escudo bloqueia; esquiva solta. Anzol não atravessa o palco |
| **Especial lado · Rede** | Joga a rede em arco; quem é pego fica preso 1 s no ar e se solta mais cedo apertando botões (−0,1 s por aperto) ou com esquiva (regra normal de escape). Levar golpe também solta | 1%. Dá um golpe de graça em quem está preso |
| **Especial cima · Anzol na borda** | Lança o anzol para cima e para a frente. Ele mira sozinho na borda livre mais perto (até ~400 px, do lado de fora do palco) e, se pega, a linha puxa o jacaré e ele se pendura. Se não pega nada, fica sem pulo e sem golpe até pousar | um empurrãozinho para cima ao lançar, no ar |
| **Especial baixo · Rolamento da morte** | Mordida que agarra (passa pelo escudo), gira 36 quadros com o adversário na boca e arremessa longe. O adversário sai com "dente quebrado" (estrelinhas) | giro 1,5% a cada 9 quadros (6%) + arremesso 8% = 14%. Errar custa 34 quadros de recuperação |
| Agarrão e arremessos | padrão do jogo (sem arremessos próprios) | |

## Extras
- **Projétil / efeito próprio:** anzol (2 quadros), rede (4 quadros: bolinha, abrindo, aberta, trouxa) e `fx_splash_rio` (4 quadros) quando o rolamento bate no chão.
- **Comemoração:** mostra o peixe enorme.
- **Descanso na plataforma:** cochilando com a vara na água.
- **Pendurado na borda:** com uma mão só, vara na outra.
