# Seu Capivas — pixel art

Conversa nova só do Seu Capivas. Mande antes a **mensagem de regras** do [README](README.md).

## Paleta (passe junto com o sprite base)

```text
Paleta do Seu Capivas (use só estas cores):
contorno #3A0A12
pelo: luz #E8904A, base #D9773A, sombra #AA5522, sombra funda #7A3322
focinho e orelhas: #6E3424, #4E2216
laranjinha: #FF8A10, luz #FFB347, folha #6FAE44
toalha: base #7FC6EE, sombra #4FA0D8, listras #FFFFFF
bermuda: azul #12699A, azul escuro #0B4A70, flores #FF7A1A, folhas #77AA44
pochete: #26324A
chinelo: #1E73B8
olhos: branco #FFFFFF, pupila #2A1208
```

## Passo 1 · Sprite base (aprovar antes de tudo)

**Anexe:** `art/conceitos/seu_capivas/folha_v1.png` e `art/conceitos/seu_capivas/montagem_v2.png`.

```text
Sprite base do Seu Capivas em pixel art, baseado no personagem das imagens anexadas: capivara tiozão de clube, grandalhão e redondo, cabeça baixa encaixada num cangote largo (sem pescoço), olhos semicerrados e sorrisinho zen, laranjinha na cabeça, toalha azul no ombro, barrigão, bermuda florida azul, pochete, chinelo de dedo.
Uma imagem 1024x1024 com UM quadro de 64x64 pixels ampliado 16x. Pose: parado e tranquilo, de perfil para a direita, braços pendurados ao lado do corpo, pernas curtas e afastadas. Personagem com cerca de 56 pixels de altura contando a laranjinha, bem mais largo que um personagem comum, pés 4 pixels acima da borda de baixo.
[cole aqui a paleta do Seu Capivas]
```

Salve como: `art/pixel/seu_capivas/base.png`

- [ ] Parece o Seu Capivas do conceito, mesmo pequeno: cabeça baixa no cangote, sem pescoço fino.
- [ ] Pixels quadrados nítidos (dá para contar), sem borrado.
- [ ] Fundo magenta liso.

## Passo 2 · Animações — Lote 1 (para jogar)

Em cada pedido, **anexe o sprite base aprovado** e use o modelo:

```text
Folha de animação do Seu Capivas (idêntico ao sprite base anexado), <N> quadros, grade 3x2 de 1536x1024, fundo magenta #FF00FF.
Animação: <NOME>
Quadros:
<LISTA DE QUADROS>
```

| Arquivo | Animação | Quadros |
|---|---|---|
| `parado.png` | Respiração (loop) | 1) normal · 2) inspirando, barriga e ombros sobem · 3) cheio de ar, olhos fechados · 4) soltando o ar, toalha balança |
| `andar.png` | Andar pesado (loop) | 1) contato, chinelo à frente · 2) peso desce, barriga balança · 3) passagem, corpo mais alto · 4) contato da outra perna · 5) peso desce · 6) passagem. Passos curtos, corpo gingando de lado |
| `correr.png` | Correr desajeitado (loop) | 1) contato, barriga sacudindo · 2) corpo baixo · 3) impulso · 4) no ar por um instante, toalha subindo · 5) contato da outra perna · 6) impulso |
| `pulo.png` | Pulo, queda e pouso | 1) agachado com esforço · 2) impulso · 3) subindo, pernas encolhidas, toalha voando · 4) topo, braços abertos · 5) caindo, bochechas subindo · 6) pouso pesado agachado |
| `dor.png` | Levando golpe | 1) tranco para trás, bochecha amassada · 2) laranjinha saindo do lugar · 3) lançado de costas no ar · 4) lançado girando |
| `jab.png` | Tapa de sumô | 1) preparo, mão espalmada recolhida · 2) tapa esticado à frente · 3) volta |
| `golpe_frente.png` | Empurrão de barriga | 1) preparo, joga o peso para trás · 2) passo à frente · 3) impacto: barriga projetada à frente · 4) recolhendo · 5) volta |
| `golpe_cima.png` | Cabeçada para cima | 1) abaixa a cabeça · 2) sobe o corpo · 3) impacto: cabeça para cima, laranjinha quase cai · 4) descendo · 5) volta |
| `golpe_baixo.png` | Pisão de sumô | 1) levanta a perna bem alto · 2) perna no alto · 3) impacto: chinelo bate no chão · 4) recolhendo · 5) volta |
| `aereo_neutro.png` | Bola giratória | 1) encolhendo · 2) bola, abraçando os joelhos · 3) impacto: bola girando · 4) girando · 5) abrindo |

## Passo 3 · Animações — Lote 2

| Arquivo | Animação | Quadros |
|---|---|---|
| `aereo_frente.png` | Tapa duplo à frente | 1) mãos recolhidas · 2) esticando · 3) impacto: as duas mãos espalmadas à frente · 4) recolhendo · 5) volta |
| `aereo_tras.png` | Bundada para trás | 1) olha para trás · 2) prepara o quadril · 3) impacto: quadril empurrado para trás · 4) recolhendo · 5) volta |
| `aereo_cima.png` | Palmas para cima | 1) mãos abertas embaixo · 2) subindo · 3) impacto: palmas batendo acima da cabeça · 4) descendo · 5) volta |
| `aereo_baixo.png` | Cai sentado | 1) encolhe · 2) vira o quadril para baixo · 3) impacto: sentado com tudo, para baixo · 4) quicando · 5) volta |
| `especial_neutro.png` | Barrigada carregada | 1) meditando de olhos fechados · 2) enchendo a barriga · 3) barriga enorme · 4) barrigada para a frente · 5) impacto · 6) volta |
| `especial_lado.png` | Abraço de capivara | 1) braços abertos · 2) avançando · 3) abraço apertado · 4) levantando · 5) arremessa por cima do ombro · 6) volta |
| `especial_cima.png` | Pulo de bomba | 1) agachado · 2) impulso · 3) subindo, joelhos abraçados · 4) topo · 5) caindo de bomba · 6) impacto |
| `especial_baixo.png` | Senta e faz onda de choque | 1) pulinho · 2) sentando no ar · 3) impacto sentado, bumbum no chão · 4) ainda sentado, barriga balançando · 5) levantando · 6) volta |
| `defesa_esquiva.png` | Defesa e rolamento | 1) encolhido atrás da toalha esticada · 2) toalha tremendo · 3) rolamento: abaixa · 4) rolando · 5) rolando · 6) levanta |
| `agarrar.png` | Agarrão e arremessos | 1) braços abertos agarrando · 2) abraçando · 3) arremesso para a frente · 4) arremesso para trás · 5) arremesso para cima · 6) arremesso para baixo |
| `borda.png` | Borda | 1) pendurado com esforço, olhos arregalados · 2) balançando · 3) puxando o corpo · 4) barriga na plataforma · 5) de pé · 6) volta |
| `tonto.png` | Tonto | 1) olhos em espiral · 2) balançando · 3) balançando para o outro lado · 4) quase caindo |
| `vitoria.png` | Vitória | 1) pega o coco · 2) leva à boca · 3) gole no canudinho · 4) olhos fechados satisfeito · 5) suspiro · 6) joinha |
