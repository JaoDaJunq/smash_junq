# Juba — pixel art

Conversa nova só do Juba. Mande antes a **mensagem de regras** do [README](README.md).

## Paleta (passe junto com o sprite base)

```text
Paleta do Juba (use só estas cores):
contorno #3A0A0A
juba e pelo: luz #FFC42A, base #FF9A1A, sombra #E86A12, sombra funda #B8440F
rosto, mãos e pés: luz #CC7744, base #AA5522, sombra #7A3A1A
calça de abadá: base #F2E6D6, sombra #D2B898
faixa da testa e cordão: verde #4F8A3A, verde escuro #2F5A24, amarelo #FFD23A
olhos: branco #FFFFFF, pupila #2A1208
```

## Passo 1 · Sprite base (aprovar antes de tudo)

**Anexe:** `art/conceitos/juba/folha_v1.jpg` e `art/conceitos/juba/cabecas_v1.png`.

```text
Sprite base do Juba em pixel art, baseado no personagem das imagens anexadas: mico-leão-dourado capoeirista, juba enorme laranja-dourada, faixa verde na testa, calça de abadá branca com cordão verde e amarelo, sem camisa, cauda longa enrolada na ponta, mãos e pés marrons, sorriso de canto confiante.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: guarda de capoeira parada (ginga), de perfil para a direita, pés afastados, braço da frente protegendo o rosto. Cabeça grande (cerca de 1/3 da altura), personagem com cerca de 52 pixels de altura, pés 4 pixels acima da borda de baixo.
[cole aqui a paleta do Juba]
```

Salve como: `art/pixel/juba/base.png`

- [ ] Parece o Juba do conceito, mesmo pequeno.
- [ ] Pixels quadrados nítidos (dá para contar), sem borrado.
- [ ] Fundo magenta liso.

## Passo 2 · Animações — Lote 1 (para jogar)

Em cada pedido, **anexe o sprite base aprovado** e use o modelo:

```text
Folha de animação do Juba (idêntico ao sprite base anexado), <N> quadros, grade 3x2 de 1536x1024, fundo magenta #FF00FF.
Animação: <NOME>
Quadros:
<LISTA DE QUADROS>
```

| Arquivo | Animação | Quadros |
|---|---|---|
| `parado.png` | Ginga parada (loop) | 1) peso atrás, braço da frente no rosto · 2) passando ao meio, corpo mais baixo · 3) peso à frente, braços trocados · 4) voltando ao meio |
| `andar.png` | Andar malandro (loop) | 1) contato, perna da frente esticada · 2) peso desce · 3) passagem, corpo mais alto · 4) contato da outra perna · 5) peso desce · 6) passagem. Braços ao contrário das pernas, cauda balançando atrasada |
| `correr.png` | Correr (loop) | 1) contato · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso. Corpo inclinado para a frente, juba sacudindo |
| `pulo.png` | Pulo, queda e pouso | 1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado |
| `dor.png` | Levando golpe | 1) tranco para trás, olhos apertados · 2) corpo dobrado, juba bagunçada · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo |
| `jab.png` | Tapa rápido | 1) preparo, mão recolhida · 2) tapa esticado na altura do rosto · 3) volta para a guarda |
| `golpe_frente.png` | Martelo (chute lateral alto) | 1) preparo, joelho sobe · 2) perna girando · 3) impacto: perna esticada na altura da cabeça, com rastro curvo · 4) perna voltando · 5) guarda |
| `golpe_cima.png` | Meia-lua de frente (chute em arco para cima) | 1) preparo · 2) perna subindo pela frente · 3) impacto: perna no alto, acima da cabeça, com rastro curvo · 4) perna descendo · 5) guarda |
| `golpe_baixo.png` | Rasteira | 1) agachando, mão no chão · 2) perna começa a varrer · 3) impacto: perna esticada rente ao chão, com rastro · 4) recolhendo · 5) levantando |
| `aereo_neutro.png` | Parafuso no ar | 1) encolhido · 2) girando, pernas abrindo · 3) impacto: pernas abertas no giro, com rastro circular · 4) terminando o giro · 5) encolhido |

## Passo 3 · Animações — Lote 2

| Arquivo | Animação | Quadros |
|---|---|---|
| `aereo_frente.png` | Voadora com os dois pés | 1) encolhido · 2) esticando · 3) impacto: dois pés à frente · 4) recolhendo · 5) encolhido |
| `aereo_tras.png` | Chute de costas | 1) olha para trás · 2) perna de trás recolhida · 3) impacto: perna esticada para trás · 4) recolhendo · 5) volta |
| `aereo_cima.png` | Bananeira no ar chutando para cima | 1) virando de cabeça para baixo · 2) pernas subindo · 3) impacto: pernas para cima · 4) desvirando · 5) volta |
| `aereo_baixo.png` | Pisão com os dois pés | 1) encolhido · 2) pernas descendo · 3) impacto: pés para baixo, juba subindo · 4) recolhendo · 5) volta |
| `especial_neutro.png` | Arremesso de castanha | 1) pega a castanha · 2) braço para trás · 3) arremesso por cima do ombro · 4) castanha saindo · 5) braço à frente · 6) guarda |
| `especial_lado.png` | Rolê de capoeira | 1) abaixa · 2) mãos no chão · 3) rolando de lado · 4) meio do giro · 5) saindo · 6) guarda |
| `especial_cima.png` | Cipó | 1) olha para cima · 2) agarra o cipó · 3) sobe puxando · 4) gira no cipó · 5) solta · 6) caindo |
| `especial_baixo.png` | Negativa e contra-ataque | 1) abaixando · 2) deitado de lado esquivando · 3) apoio na mão · 4) chute para cima · 5) recolhendo · 6) levantando |
| `defesa_esquiva.png` | Defesa e rolamento | 1) guarda baixa, braços cruzados · 2) guarda tremendo · 3) rolamento: abaixa · 4) rolando · 5) rolando · 6) levanta |
| `agarrar.png` | Agarrão e arremessos | 1) mãos à frente agarrando · 2) segurando · 3) arremesso para a frente · 4) arremesso para trás · 5) arremesso para cima · 6) arremesso para baixo |
| `borda.png` | Borda | 1) pendurado pelas mãos, olhos arregalados · 2) pendurado balançando · 3) puxando o corpo · 4) joelho na plataforma · 5) de pé · 6) guarda |
| `tonto_pulo_duplo.png` | Tonto e pulo duplo | 1) tonto, estrelinhas · 2) tonto balançando · 3) pulo duplo: cambalhota começa · 4) de cabeça para baixo · 5) terminando · 6) abrindo |
| `vitoria.png` | Vitória | 1) ginga · 2) ginga trocando · 3) pulo · 4) aterrissa · 5) mostra a língua · 6) aponta para a câmera |
