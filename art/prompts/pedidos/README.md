# Pedidos de arte para animação — Juba e Seu Capivas

Material para deixar as animações fluidas. Cada arquivo tem os prompts prontos para colar no ChatGPT, na **conversa do personagem** (a mesma onde foi feita a folha), sempre anexando as imagens indicadas.

**Como a fluidez é dividida:**
- **Mais quadros, transições e física** são feitos no código (Claude): ciclos de andar/correr, antecipação e impacto dos golpes, cauda e juba balançando, pés colados no chão.
- **Mais articulação e expressões** dependem da arte abaixo: com mãos, pés e quadril separados, o boneco dobra em mais lugares e fica menos "duro".

**Regras para todo pedido:**
- Sempre anexe a folha aprovada (`art/conceitos/<personagem>/folha_v1`) e as partes atuais (`partes_v1.png`).
- Fundo **transparente** (PNG) em tudo que for parte ou cabeça/mão.
- **Sem bolinhas de junta, sem discos nas pontas**: os encaixes devem ter a mesma cor e textura da parte.
- Vista de **perfil olhando para a direita**, na **mesma escala** das partes anexadas.
- Salve com o nome indicado e faça commit (ou me avise).

## Checklist (em ordem de prioridade)

| # | Pedido | Juba | Seu Capivas | Ganho para a animação |
|---|---|---|---|---|
| 1 | Partes v2 (mais articulações, sem bolinhas) | [01_partes_v2](juba/01_partes_v2.md) · ☐ | [01_partes_v2](seu_capivas/01_partes_v2.md) · ☐ | **O maior**: mão, pé, peito/quadril e cauda em segmentos dobram separados |
| 2 | Cabeças com expressões | [02_cabecas](juba/02_cabecas.md) · ☐ | [02_cabecas](seu_capivas/02_cabecas.md) · ☐ | Rosto muda no golpe, na dor, no KO e na vitória |
| 3 | Mãos e pés em posições | [03_maos](juba/03_maos.md) · ☐ | [03_maos](seu_capivas/03_maos.md) · ☐ | Soco fechado, agarrão aberto, segurar objeto |
| 4 | Referência de movimento: andar, correr, parado | [04_ref_locomocao](juba/04_ref_locomocao.md) · ☐ | [04_ref_locomocao](seu_capivas/04_ref_locomocao.md) · ☐ | Eu copio cada quadro para o ciclo ficar natural |
| 5 | Referência dos golpes (3 quadros por golpe) | [05_ref_golpes](juba/05_ref_golpes.md) · ☐ | [05_ref_golpes](seu_capivas/05_ref_golpes.md) · ☐ | Antecipação, impacto e recuperação de cada golpe |
| 6 | Efeitos de rastro (smears) | [efeitos](comum/efeitos.md) · ☐ | (mesmo arquivo) | Golpes rápidos ganham "borrão" de movimento |

Marque ☐ → ☑ quando salvar. Os itens 1 e 2 já fazem uma diferença grande; os outros podem vir depois.

## Onde salvar

```text
art/conceitos/juba/partes_v2.png, montagem_v2.png
art/conceitos/juba/cabecas_v1.png
art/conceitos/juba/maos_v1.png
art/conceitos/juba/ref_parado.png, ref_andar.png, ref_correr.png, ref_pulo.png
art/conceitos/juba/ref_golpes_1.png, ref_golpes_2.png, ref_golpes_3.png, ref_especiais.png, ref_extras.png
art/conceitos/seu_capivas/(mesmos nomes)
art/conceitos/comum/smears_v1.png
```
