# Rodada 12: os 5 últimos do elenco (PROPOSTA de kit, aguardando o ok do João)

Com eles o elenco fecha as 24 vagas. Profissões e concepts escolhidos pelo João em 28/10/2026 (`art/concepts/<id>/escolhido.png`).

Mecânicas que já existem, para não repetir: projétil, bumerangue, contra-golpe, agarrão de comando, cavar, objeto no palco (cama elástica, estandarte, escada, bola), atordoar, escorregão, armadura, marcas que acumulam, cegar, fuga de combo, lentidão em área, empurrão de som, fio na borda, anzol na borda, rede que prende, espinhos que devolvem, pairar, refletor (manchete), troca de ferramenta, armadilha no chão (castanha, prego), nuvem que dá dano, comer projétil, voo direcional. Regra: ninguém tem especial de lado que é só investida reta. **Arte nunca por código**: todo objeto e efeito abaixo vira folha própria no livro de pedidos.

| id | Nome | Bicho · grupo · tipo | Concept | Altura no sprite |
|---|---|---|---|---|
| `muriqui` | **Mestre Muriqui** | muriqui · Macacos · Pesado | 1 tai chi (roupa branca, faixa verde) | ~60 px (o mais alto, braços compridos) |
| `paca` | **Dona Paca** | paca · Roedores · Versátil | 2 cozinheira (touca de chef, dólmã, panela e concha) | ~48 px |
| `sucuarana` | **Suçuarana** | onça-parda · Felinos · Forte | 2 carteira (jaqueta azul, boné virado, pacote) | ~54 px |
| `jabuti` | **Seu Jabuti** | jabuti-piranga · Répteis · Versátil | 1 dominó (camisa xadrez, suspensório, boina) | ~44 px (casco alto) |
| `bolinha` | **Bolinha** | tatu-bola · Garrudos · Rápido | 1 boliche (camisa retrô creme e vermelha, toalhinha) | ~40 px; no sprite, casco em **faixas largas** (o concept tem escama demais, lembra pangolim) |

---

## Mestre Muriqui · mestre de tai chi (Pesado)
Sereno, fala devagar ("respira, jovem"). O maior e mais calmo do elenco: golpes largos, lentos e que empurram longe.

**Mecânica própria: cauda preênsil** — segurando para cima embaixo de uma plataforma, ele se pendura de cabeça para baixo pela cauda (até 3 s) e ataca dali; solta descendo ou pulando.

| Golpe | Ideia |
|---|---|
| Jab 1·2·3 | palma aberta, palma, empurrão das duas mãos |
| Forte frente / cima / baixo | braço comprido varrendo em arco · mãos subindo em círculo · rasteira lenta com a perna comprida |
| Aéreos | neutro: giro de braços abertos · frente: palma · trás: chute para trás · cima: mãos em círculo para o alto · baixo: pisão das duas pernas |
| Especial neutro | **Empurrão de energia (sem efeito mágico)**: carrega a palma devagar; solto, empurra MUITO longe sem quase dano (golpe de nocaute no fim do palco) |
| Especial lado | **Passo do tai chi**: desliza em arco suave para a frente e para trás, desviando de projéteis no meio, e termina com uma palma |
| Especial cima | **Balanço de cauda**: lança a cauda para cima; se pegar plataforma ou borda, gira nela e sobe |
| Especial baixo | **Postura da garça**: fica numa perna; quem atacar ele nesse instante é desequilibrado e cai sentado (diferente do contra-golpe: não devolve dano, derruba) |
| Comemoração · descanso | sequência de tai chi serena · pendurado de cabeça para baixo cochilando |

## Dona Paca · cozinheira de quentinha (Versátil)
Mãezona animada, chama todo mundo de "meu filho". Bate de panela e concha.

**Mecânica própria: prato no fogo** — coloca uma marmita no chão; em 3 s ela fica pronta (fumegando). Quem pegar primeiro cura 6%, **inclusive o adversário** se chegar antes. Uma por vez.

| Golpe | Ideia |
|---|---|
| Jab 1·2·3 | colherada, colherada, panelada |
| Forte frente / cima / baixo | panela de cobre à frente · concha para cima (respingo quente) · colher de pau rasteira |
| Aéreos | neutro: gira com a panela · frente: panelada · trás: concha para trás · cima: tampa da panela para cima · baixo: panela para baixo |
| Especial neutro | **Prato no fogo** (mecânica acima) |
| Especial lado | **Arremesso de tempero**: joga um saquinho de pimenta em arco; quem é atingido espirra (fica 0,5 s sem poder atacar) |
| Especial cima | **Tampa voadora**: segura a tampa da panela e sobe soprada pelo vapor da panela |
| Especial baixo | **Mexer o caldeirão**: gira a concha numa panela grande no chão; quem está perto é puxado para o redemoinho e toma vários acertos |
| Comemoração · descanso | serve a quentinha e manda um beijo · provando a comida na colher |

## Suçuarana · carteira dos Correios (Forte)
Determinada e séria, "chova ou faça sol". Botes rápidos e fortes, pouca mobilidade no chão.

**Mecânica própria: encomenda** — gruda um pacote no adversário que **estoura em 3 s** (dano e lançamento). Se o adversário acertar a Suçuarana antes de estourar, o pacote **passa de volta para ela**.

| Golpe | Ideia |
|---|---|
| Jab 1·2·3 | patada, patada, bolsada |
| Forte frente / cima / baixo | bote curto com as duas patas · patada para cima · rasteira com a cauda |
| Aéreos | neutro: giro com a bolsa · frente: bote no ar · trás: coice · cima: patada para cima · baixo: aterrissa com as patas (crava) |
| Especial neutro | **Encomenda** (mecânica acima) |
| Especial lado | **Carimbo**: avança até o adversário e carimba; quem é carimbado fica marcado 4 s e o próximo forte dela nele lança mais (avanço com pulinho curvo, não reto) |
| Especial cima | **Salto do muro**: pulo de onça para o alto, alto e rápido, com patada no topo |
| Especial baixo | **Bote**: se agacha e espera (até 1 s); soltando, dá um bote longo na direção segurada |
| Comemoração · descanso | confere a lista e dá baixa "entregue!" · sentada lambendo a pata em cima da bolsa |

## Seu Jabuti · aposentado do dominó (Versátil)
Lento, sábio, implicante ("no meu tempo..."). Joga peças de dominó e confia no casco.

**Mecânica própria: casco** — o escudo é o casco: segura mais que o escudo normal e não quebra, mas se ele levar um golpe forte escondido, sai **deslizando como projétil** (machuca quem estiver no caminho).

| Golpe | Ideia |
|---|---|
| Jab 1·2·3 | tapinha, tapinha, bengalada curta (palito na boca) |
| Forte frente / cima / baixo | batida de dominó na mesa (as duas mãos) · cabeçada para cima saindo do casco · rasteira de casco girando |
| Aéreos | neutro: casco girando · frente: tapa com a peça · trás: casco para trás · cima: cabeçada · baixo: cai de casco (crava) |
| Especial neutro | **Peça de dominó**: joga uma peça; na terceira seguida, joga uma "carroça" (peça dupla) maior |
| Especial lado | **Efeito dominó**: arma uma fileira de peças no chão à frente que cai em cascata, acertando quem estiver em cima |
| Especial cima | **Casco foguete**: entra no casco e gira subindo como pião |
| Especial baixo | **Bate o dominó**: "BATI!" — bate a peça na mesa e quem está perto no chão tropeça |
| Comemoração · descanso | bate a última peça e ri · cochilando na cadeira de praia |

## Bolinha · jogador de boliche (Rápido)
Animado e competitivo, comemora com "STRIKE!". Pequeno e escorregadio, vira bola.

**Mecânica própria: strike** — vira bola e rola. Quanto mais tempo carrega, mais longe e mais forte vai, e **atravessa vários** (não para no primeiro).

| Golpe | Ideia |
|---|---|
| Jab 1·2·3 | soquinho, soquinho, cabeçada de casco |
| Forte frente / cima / baixo | balanço de arremesso (braço) · bola de casco para cima · rasteira enrolado |
| Aéreos | neutro: bola girando · frente: cambalhota · trás: coice · cima: bola para cima · baixo: cai como bola (crava) |
| Especial neutro | **Strike** (mecânica acima): carrega parado, solta rolando para a frente |
| Especial lado | **Pino de boliche**: arremessa um pino que gira e quica no chão (projétil em arco) |
| Especial cima | **Spare**: vira bola e quica para o alto duas vezes, como bola batendo na canaleta |
| Especial baixo | **Canaleta**: rola enrolado pela borda do palco, grudado no chão, e volta pela parede (recuperação rasteira) |
| Comemoração · descanso | faz "STRIKE!" com a toalhinha girando · limpando a bola (o próprio casco) com a toalha |
