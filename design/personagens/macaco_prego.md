# Preguinho · ficha

> Kit aprovado pelo criador em `design/proposta-rodada11.md`. Concept escolhido: **1 · faz-tudo** (`art/concepts/macaco_prego/escolhido.png`). Programado na rodada 11 (branch `r11/b`).

| | |
|---|---|
| **id** (pasta) | `macaco_prego` |
| **Bicho** | macaco-prego (pelo marrom, topete escuro, rosto claro, cauda comprida que segura nas coisas) |
| **Grupo · Tipo** | Macacos · **Versátil** |
| **Profissão / papel** | Faz-tudo de bairro: pedreiro, eletricista e encanador num bicho só |
| **Personalidade** | Malandro, resolve tudo com gambiarra, cobra caro |
| **Acessório de assinatura** | O **cinto de ferramentas** (martelo, chave inglesa, furadeira) |
| **Silhueta** | Pequeno e ágil, camisa verde e jeans, cauda grande enrolada atrás |
| **Cores** | pelo `#754329` · roupa verde `#788237` · jeans `#32658F` · acentos `#E49A26` · contorno vinho `#2a0f12` |
| **Altura no sprite** | ~46 px de 64 (Juba 52, Capivas 56) |
| **Barrinhas (1–5)** | Velocidade 3 · Força 3 · Peso 3 · Volta ao palco 3 |

**Números no jogo:** peso 92, andar 335, correr 580, ar 430, gravidade 2600, 1 pulo no ar (valores de lutador médio/versátil).

## Mecânica própria: caixa de ferramentas
O **especial neutro troca a ferramenta da vez** (martelo → chave inglesa → furadeira → martelo...). O ícone da ferramenta aparece em cima da cabeça. Os **3 golpes fortes** (frente, cima, baixo) mudam com ela:

| Ferramenta | Efeito nos golpes fortes |
|---|---|
| **Martelo** (começa com ele) | forte e lento: +45% de dano, +10% de lançamento, +4 quadros de início |
| **Chave inglesa** | alcance: a caixa de acerto chega 30% mais longe, -8% de dano |
| **Furadeira** | vários acertos: 3 furadas fracas (1,4%) que prendem e a última (2,6%) lança |

## Golpes

| Golpe | Ideia | Números (início/ativo/volta · dano) |
|---|---|---|
| Jab 1 · 2 · 3 | soco, soco, martelada leve (o 3º é o padrão do jogo: mais forte e lento) | 2/2/7 · 2,2% (jab 3 ≈ 4%) |
| Forte frente | golpe com a ferramenta da vez | base 8/3/13 · 8% |
| Forte cima | golpe com a ferramenta da vez, para cima | base 6/3/12 · 6% |
| Forte baixo | golpe com a ferramenta da vez, rente ao chão | base 5/3/10 · 5% |
| Aéreo neutro | giro segurando-se pela cauda | 3/8/10 · 4% |
| Aéreo frente | martelada | 7/3/14 · 8% |
| Aéreo trás | chute | 5/3/12 · 6,5% |
| Aéreo cima | chave para cima | 5/3/12 · 5,5% |
| Aéreo baixo | martelada para baixo (crava) | 9/4/16 · 7,5% |
| Especial neutro | **Troca de ferramenta** (mecânica acima), sem dano | 6/1/14 |
| Especial lado | **Coco quebrado**: coquinho em arco (5%); **ao bater no chão quebra em 2 pedaços** (3,5% cada) que rolam um para cada lado e caem na borda | 9/1/16 |
| Especial cima | **Escada dobrável**: abre a escada no lugar (2 s) e salta por ela (recuperação); quem estiver na escada e segurar "cima" sobe por ela, **inclusive o adversário** | 6/12/10 · 3,5% |
| Especial baixo | **Pregar**: prego no chão à frente (1 por vez, até alguém pisar); quem pisa (menos o dono) tropeça: 4%, lançamento curto para cima. No ar não prega | 8/1/16 |
| Agarrão e arremesso | o padrão do jogo | — |

## Extras
- **Projétil / efeito próprio:** coquinho (`coquinho.png`, 2 quadros), escada (`escada.png`), prego (`prego.png`) e ícones das ferramentas (`ferramentas.png`, 3 quadros).
- **Comemoração (3 poses):** estende a mão cobrando o orçamento (folha `vitoria`).
- **Descanso na plataforma:** quebrando coco com pedra.
- **Pendurado na borda:** com uma mão, na folha `pendurado`.
