# Efeitos de suporte dos golpes (proposta · rodada 8)

> **Proposta (20/10/2026), aguardando aprovação do João.**
> Ideia dele: o que deixa um golpe especial é um efeito que conta a história do
> golpe, como as folhas do Sumiço do Mico (Juba) ou o Peba entrando na terra.
> Efeito desenhado dentro do sprite fica estranho (espelha, corta, não combina),
> então **os efeitos são pedidos SEPARADOS** e o jogo encaixa cada um no lugar.

## Como funciona

- Cada efeito é uma folha própria `art/pixel/<id>/fx_<nome>.png`, na mesma grade
  (3x2, quadros de 64x64 ampliados 8x, fundo magenta), **só o efeito, sem personagem**.
  O importador já aceita (`fx_folhas` do Juba é assim) e o jogo toca com `PixelFx`.
- Três tipos:
  - **Estouro**: toca uma vez e some (folhas, poeira, terra, confete).
  - **Rastro/ligação**: o jogo estica ou repete (cauda do laço, fita, marcas no chão).
  - **Por cima do alvo**: desenhado na frente de quem leva o golpe (cauda enrolando,
    espiral da hipnose). É o que falta para o golpe "acontecer" no outro.
- O efeito também carrega informação de jogo (carregando, preso, contra-ataque pronto).

## Por personagem (★ = o que mais muda a cara do golpe)

### Juba · mico-leão capoeirista
| Golpe | Efeito | Tipo |
|---|---|---|
| Sumiço do Mico (cima) | Folhas ✅ já existe | Estouro |
| Investida (lado) | ★ Rastro de folhas e poeira no chão por onde passa | Rastro |
| Contra-ataque (baixo) | ★ Brilho dourado de "ginga" quando o contra pega + folhas | Estouro |
| Castanha (neutro) | Lasquinha de casca quando bate | Estouro |

### Seu Capivas · capivara tiozão de clube
| Golpe | Efeito | Tipo |
|---|---|---|
| Pisão (baixo) | ★ **Tchibum**: espirro de água e lama em volta (capivara ama água) + rachadura no chão | Estouro |
| Pancada carregada (neutro) | ★ Bufada: vapor saindo do focinho enquanto carrega, maior quanto mais carga | Estouro em loop |
| Agarrão (lado) | Marquinha de "abraço de tio" (estrelinhas tontas no arremessado) | Por cima do alvo |
| Pulo alto (cima) | Gotas de água caindo ao subir (como quem sai da piscina) | Estouro |
| Descanso / sentar | ★ Boia de piscina e copinho de suco aparecendo ao sentar (tira o "seco") | Estouro |

### Maracajá · jaguatirica do parkour
| Golpe | Efeito | Tipo |
|---|---|---|
| Bote (lado) | ★ **Marcas de garra** (3 riscos) no alvo a cada arranhão | Por cima do alvo |
| Espreita (neutro) | ★ Olhos brilhando + poeirinha no quadril mexendo (mostra a carga) | Loop |
| Cochilo (baixo) | ★ Bolhas de "Zzz" (sem letra: bolhas de sono) e estrela quando o coice pega | Loop / estouro |
| Salto de parede / grude | Poeira e pedacinhos de reboco saindo da parede | Estouro |

### Seu Peba · tatu forrozeiro
| Golpe | Efeito | Tipo |
|---|---|---|
| Toca (baixo) | ★ Terra subindo ao entrar, **montinho de terra andando** por baixo do chão até onde ele sai, explosão de terra na saída | Estouro + rastro |
| Rolamento (lado) | Poeira do sertão atrás da bola | Rastro |
| Fole a jato (cima) | ★ Lufada de ar saindo da sanfona para baixo | Estouro |
| Nota de sanfona (neutro) | Nota ✅ já existe; brilho quando bate | Estouro |
| Casco (mecânica) | ★ Faísca metálica quando o casco segura golpe pelas costas | Estouro |

### Mestra Sucuri · jiu-jitsu
| Golpe | Efeito | Tipo |
|---|---|---|
| Hipnose (neutro) | ★ **Espiral** nos olhos dela + **espirais girando em cima do alvo** enquanto ele está parado | Loop / por cima do alvo |
| Abraço (baixo) | ★ **Cauda enrolada por cima do adversário** (2 anéis de cauda desenhados NA FRENTE dele), apertando a cada aperto | Por cima do alvo |
| Laço (lado) | Cauda esticada ✅ (código pronto, falta `laco_cauda.png`) | Ligação |
| Mola (cima) | Poeira em círculo onde ela estava enrolada | Estouro |
| Agarrão | Os mesmos anéis do abraço, menores | Por cima do alvo |

### Dona Canga · arara baiana
| Golpe | Efeito | Tipo |
|---|---|---|
| No ritmo (mecânica) | ★ Pulso de plumas/confete no chão a cada batida da bateria (o jogador VÊ o ritmo) e brilho dourado no golpe que acerta na batida | Loop / estouro |
| Paradinha (baixo) | ★ Onda de choque de confete e plumas saindo do salto | Estouro |
| Desfile (lado) | Plumas voando enquanto gira | Rastro |
| Voo de alegoria (cima) | Penas caindo das asas | Estouro |
| Pandeiro (neutro) | Pandeiro ✅; platinelas brilhando quando volta | Estouro |

### Marianinha · ver nova proposta de golpes
Os efeitos dela dependem dos golpes novos (abaixo).

## Marianinha · golpes novos (proposta)

Problema (João): a bolinha é a rolagem do Peba, o mergulho e os pulos lembram a
Maracajá; nada é só dela. Proposta: **cada especial usa um aparelho de ginástica**
e a mecânica própria é a **nota dos jurados**.

| Golpe | Ideia | Efeito |
|---|---|---|
| Neutro · **Fita rítmica** | Gira a fita num espiral à frente: alcance longo, vários toquinhos; segurando, a fita fica girando como escudo leve contra projéteis | Fita (rastro) |
| Lado · **Arco** | Joga o arco de ginástica, que rola pelo chão e volta para a mão (no ar, voa reto) | Arco (projétil girando) |
| Cima · **Cama elástica** | ★ **Deixa uma mini cama elástica no palco** por ~6 s: ela quica nela bem alto, e qualquer um que pisar também é lançado (dá para usar contra o adversário). É a recuperação e muda o palco | Cama elástica (objeto) |
| Baixo · **Magnésio** | Bate as mãos e solta uma nuvem de pó de magnésio: quem está dentro escorrega (perde o controle no chão por um instante) | Nuvem branca (estouro) |
| Mecânica · **Nota dos jurados** | Golpes DIFERENTES seguidos sobem a nota (plaquinha acima dela: 7 → 8 → 9 → 10). Repetir golpe baixa. Com **10**, o próximo golpe tira 50% a mais e solta confete. Recompensa variar, ao contrário de todo o elenco | Plaquinhas + confete |

O que continua igual: golpes normais (estrelinha, mortal, espacate, aéreos) e o quique na cabeça.
Sai: semente, bala de canhão, trampolim de 3 pulos, bomba.

Alternativas, se não gostar da de aparelhos:
- **Papagaio imitador**: o especial neutro grita e **repete o último especial que o adversário usou** (como o Kirby), mais fraco.
- **Show de talentos**: cada especial é um número de circo da caçula (bambolê, pirueta, pirâmide de pássaros invisível) — mais engraçado, menos ginástica.

## Ordem sugerida
1. Terminar Canga e Sucuri (já em andamento).
2. Marianinha nova (código + folhas dos golpes novos + efeitos dela).
3. Efeitos ★ de todos (≈ 20 folhas pequenas; ~1 dia de gerador).
4. Efeitos sem ★ depois, se o limite de imagens deixar.
