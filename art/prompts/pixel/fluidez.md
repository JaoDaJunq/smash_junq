# Mais fluidez — quadros intermediários e transições

Duas formas de deixar o movimento mais liso, sem perder o que já está aprovado:

1. **Quadros intermediários (intercalação):** você anexa a folha que já está no jogo e o GPT desenha **só os quadros do meio**, entre cada par. O jogo intercala sozinho (1, 1½, 2, 2½...): o andar vai de 6 para 12 quadros, os golpes de 5 para 9. Os quadros originais não mudam, e por isso o personagem continua igual.
2. **Transições:** animações curtas que hoje não existem e que deixam os cortes secos: **virar, arrancar, frear e pousar**.

Tudo pronto no jogo para receber: é só salvar com o nome certo e me avisar. Arquivo faltando não quebra nada (o jogo usa o que já tem).

## Como pedir os intermediários

Na conversa do personagem (que já tem a **mensagem de regras**), anexe **o sprite base** e **a folha atual da animação** (`art/pixel/<personagem>/<animacao>.png`) e mande:

```text
Anexei a folha "<ANIMACAO>" do <PERSONAGEM> que já está no jogo, e o sprite base.
Desenhe os QUADROS INTERMEDIÁRIOS dessa animação, para o movimento ficar mais suave:
<QTD> quadros, em ordem, um por célula: o quadro entre o 1 e o 2 da folha anexada, depois entre o 2 e o 3, e assim por diante<LOOP>.
Cada intermediário é exatamente a metade do caminho entre os dois quadros vizinhos: mesma posição dos pés, mesmo tamanho, mesmas cores, mesma roupa.
Não redesenhe os quadros originais. Mesmas regras de sempre: grade 3x2 de 1536x1024, quadros de 64x64 ampliados 8x, fundo magenta #FF00FF, perfil para a direita. Células que sobrarem ficam vazias.
```

- Troque `<ANIMACAO>`, `<PERSONAGEM>` e `<QTD>` pela tabela abaixo.
- Em `<LOOP>`: nas animações marcadas como **loop**, escreva `, e por último o quadro entre o último e o primeiro (a animação repete)`; nas outras, apague.

Salve como: `art/pixel/<personagem>/<animacao>_meio.png` (ex.: `andar_meio.png`).

### Tabela (vale para os dois personagens)

| Prioridade | Animação | Quadros hoje | Intermediários (`<QTD>`) | Loop? |
|---|---|---|---|---|
| 1 | `andar` | 6 | 6 | **loop** |
| 1 | `correr` | 6 | 6 | **loop** |
| 1 | `parado` | 4 | 4 | **loop** |
| 2 | `jab` | 3 | 2 | |
| 2 | `golpe_frente` | 5 | 4 | |
| 2 | `golpe_cima` | 5 | 4 | |
| 2 | `golpe_baixo` | 5 | 4 | |
| 3 | `pulo` | 6 | 5 | |
| 3 | `dor` | 4 | 3 | |
| 4 | `aereo_neutro`, `aereo_frente`, `aereo_tras`, `aereo_cima`, `aereo_baixo` | 5 | 4 | |
| 5 | `especial_neutro`, `especial_lado`, `especial_cima`, `especial_baixo` | 6 | 5 | |
| 6 | `borda` | 6 | 5 | |
| 6 | `vitoria` | 6 | 6 | **loop** |
| 6 | `tonto` (só Seu Capivas) | 4 | 4 | **loop** |

Não precisa de intermediários: `agarrar`, `defesa_esquiva` e `tonto_pulo_duplo` (são várias ações curtas na mesma folha).

## Transições (2 folhas por personagem)

Anexe o sprite base e a folha `andar.png` (como referência de pose) e use o modelo de sempre:

```text
Folha de animação do <PERSONAGEM> (idêntico ao sprite base anexado), 6 quadros, grade 3x2 de 1536x1024, fundo magenta #FF00FF.
Animação: <NOME>
Quadros:
<LISTA DE QUADROS>
```

### Juba

| Arquivo | Quadros |
|---|---|
| `transicoes_a.png` | **Virar:** 1) ainda olhando para a ESQUERDA, corpo começando a girar · 2) no meio da virada, de frente para a câmera, juba balançando · 3) já olhando para a DIREITA, em guarda de ginga. **Arrancada:** 4) corpo baixo, perna de trás empurrando o chão · 5) primeiro passo largo, inclinado para a frente · 6) entrando na corrida, braços para trás, juba esvoaçando |
| `transicoes_b.png` | **Freada:** 1) pés derrapando à frente, corpo inclinado para trás · 2) ainda derrapando, braços abertos para se equilibrar · 3) voltando à guarda. **Pouso:** 4) tocando o chão, joelhos começando a dobrar · 5) agachado absorvendo o impacto, juba caída para a frente · 6) levantando para a guarda |

### Seu Capivas

| Arquivo | Quadros |
|---|---|
| `transicoes_a.png` | **Virar:** 1) ainda olhando para a ESQUERDA, barriga começando a girar · 2) no meio da virada, de frente para a câmera, toalha balançando · 3) já olhando para a DIREITA, parado e tranquilo. **Arrancada:** 4) peso jogado para a frente, barriga balançando · 5) primeiro passo pesado, chinelo batendo · 6) entrando na corrida desajeitada, toalha voando |
| `transicoes_b.png` | **Freada:** 1) chinelos derrapando, corpo inclinado para trás · 2) barriga ainda indo para a frente, braços abertos · 3) se ajeitando, toalha caindo no ombro. **Pouso:** 4) chinelos tocando o chão · 5) agachado e amassado pelo peso, bochechas descendo · 6) se levantando devagar |

**Importante na virada:** o quadro 1 olhando para a **esquerda** e o 3 para a **direita** (o jogo espelha sozinho quando a virada é no outro sentido).

## Conferência rápida antes de salvar

- [ ] Os intermediários parecem mesmo "metade do caminho" (sem pose nova inventada).
- [ ] Pés na mesma linha da folha original.
- [ ] Mesmo tamanho e cores do sprite base.
- [ ] Um quadro por célula, sem invadir a vizinha.

## Situação (15/10/2026)

### Juba

**No jogo:** intermediários de todas as 19 animações da tabela e as 4 transições (virar, arrancar, frear, pousar). As 8 folhas refeitas (corrida completa e golpes, aéreos e especial para cima na escala certa) passaram na conferência de quantidade, escala e visual. Nada pendente.

### Seu Capivas

**No jogo:** intermediários de todas as 20 animações da tabela (incluindo `jab` e `tonto`) e as 4 transições (`virar`, `arrancar`, `frear` e `pouso`). Tudo passou na conferência de quantidade e escala. Único ajuste: no `dor`, o intermediário entre "lançado de costas" e "girando" veio com o Capivas em pé; no jogo ele virou repetição do quadro anterior (`MEIO_REPETIR` no importador). Se quiser, dá para pedir só esse quadro de novo.
