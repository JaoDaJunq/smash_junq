# Espeto · ficha

> Rodada 11. Concept escolhido: **1 · roqueiro de garagem** (`art/concepts/ourico/escolhido.png`). Golpes aprovados em `design/proposta-rodada11.md`; esta ficha registra também os números que o código usa.

| | |
|---|---|
| **id** (pasta) | `ourico` |
| **Bicho** | ouriço-cacheiro |
| **Grupo · Tipo** | Roedores · **Forte** |
| **Profissão / papel** | Roqueiro de garagem: toca guitarra para resolver tudo |
| **Personalidade** | Cara de mau, coração mole |
| **Acessório de assinatura** | Guitarra vermelha nas costas, jaqueta jeans e tênis vermelho |
| **Silhueta** | Pequeno (~46 px), topete de espinhos dourados, cauda enrolada |
| **Cores** | espinhos dourados · jaqueta azul-jeans · guitarra vermelha · contorno vinho `#2a0f12` |
| **Altura no sprite** | ~46 px de 64 (Juba 52, Capivas 56) |
| **Barrinhas (1–5)** | Velocidade 3 · Força 4 · Peso 3 · Volta ao palco 3 |

**Números no jogo:** peso 98, andar 320, correr 560, ar 400, gravidade 2650, pulo 1000.

## Mecânica própria: espinhos
Enquanto está **arrepiado** (especial baixo, 1,5 s), quem o acerta com golpe corpo a corpo (inclusive no escudo dele) toma **3%** de volta. Projéteis e arremessos não machucam quem atira. Em troca, anda e corre a 65% da velocidade (e no ar também). Um anel de espinhos aparece em volta dele.

## Golpes

| Golpe | Ideia | Números |
|---|---|---|
| Jab 1 · 2 · 3 | soco, soco, cabeçada de espinhos | 3,2% (rápido: 3 quadros de início) |
| Forte frente | **guitarrada** (bate com a guitarra, alcance bom) | 11% · ângulo 35° |
| Forte cima | headbang de espinhos para cima | 8% · ângulo 88° |
| Forte baixo | rasteira com a cauda | 6,5% · ângulo 25° |
| Aéreo neutro | vira bola de espinhos girando | 7% |
| Aéreo frente | guitarrada | 10% |
| Aéreo trás | costas de espinhos | 10% |
| Aéreo cima | headbang | 8% |
| Aéreo baixo | cai de bunda espinhenta (cravada) | 11% |
| **Especial neutro · Power chord** | O acorde solta 3 espinhos em leque (−20°, 0°, +20°), projéteis curtos (alcance ~285 px) | 2,5% cada; de perto os 3 podem acertar |
| **Especial lado · Stage dive** | Pula de costas como em show e cai rolando como bola de espinhos; quica uma vez no chão | 9% (a caixa fica ligada o voo todo); ~360 px de distância |
| **Especial cima · Microfonia** | A guitarra solta um estouro que o joga para o alto (recuperação) | 6%; sobe ~230 px; depois fica sem golpe até pousar |
| **Especial baixo · Arrepiar** | Eriça os espinhos por 1,5 s (mecânica acima) | sem dano |
| Agarrão e arremessos | padrão do jogo | |

## Extras
- **Projétil / efeito próprio:** espinho (2 quadros), `fx_arrepio` (4 quadros, quando alguém se espeta) e `fx_power_chord` (4 quadros, ondas do acorde).
- **Comemoração:** solo de guitarra de joelhos.
- **Descanso na plataforma:** afinando a guitarra.
- **Pendurado na borda:** com uma mão só.
