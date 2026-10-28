# Revisão visual r11

Quadros numerados a partir de 0. Revisei as tiras dos seis lutadores e as telas de seleção, HUD e resultado fornecidas.

## Papo-Amarelo — OK

- `evidence/golpes/jacare/special_side.png`, quadros 0–29: a arrancada segue para a frente. O objeto arremessado e os efeitos não ficam soltos nem mudam de tamanho de forma visível.
- `evidence/golpes/jacare/special_neutral.png`, quadros 10–25: o impacto é pequeno e acompanha o golpe. Não vi corte ou mudança de personagem.

## Espeto — BLOQUEIA

- `evidence/golpes/ourico/special_side.png`, quadro 25: aparece uma nuvem cinza de círculos lisos, separada do lutador e do rastro. O acabamento destoa da pixel art e parece efeito desenhado por código. Refazer em pixels e prender o efeito à ação.
- O anel de espinhos, o estouro da microfonia e o rastro do stage dive parecem pixel art nas tiras; não encontrei outro problema claro nesses ajustes.

## Beija — OK

- `evidence/golpes/beija_flor/`: o skate mantém proporção semelhante nas folhas em que aparece. Não vi duplicação nem mudança brusca de tamanho. Nos golpes aéreos em que ela sai do skate, a ausência acompanha a pose.
- `evidence/ui/selecao_15_beija_flor.png`: nome e retrato correspondem à Beija; o texto fica dentro do painel.

## Preguinho — BLOQUEIA

- `evidence/golpes/macaco_prego/special_up.png`, quadros 0–25: há uma legenda de teste no alto dizendo `GOLPE: SPECIAL_SIDE (PREGUINHO)`, apesar de o arquivo ser `special_up`; ela também fica cortada na borda direita. Remover ou corrigir a legenda.
- `evidence/golpes/macaco_prego/special_up.png`, quadro 10: o alto da cabeça fica cortado pela borda do quadro.
- `evidence/golpes/macaco_prego/special_up.png`, quadro 25: uma ferramenta pequena aparece dentro de uma mancha circular escura, flutuando acima da escada enquanto Preguinho já segura o martelo. Parece duplicada e fora do estilo; remover ou integrar à ação.

## Mourisco — BLOQUEIA

- `evidence/golpes/mourisco/special_side.png`, quadros 5 e 10: há grupos de círculos cinza lisos flutuando ao lado da bola. O visual parece efeito de código e destoa dos pixels do personagem e da bola. Refazer como rastro pixelado, ou retirar.
- A bola aparece nos especiais e não aparece nos golpes comuns nas tiras revistas.

## Bandeira — OK

- `evidence/golpes/tamandua/special_neutral.png`, quadros 10–25: a nuvem de veneno está menor e sai junto do jato do bico, alcançando o adversário sem cobrir o lutador inteiro. Não vi objeto duplicado ou sprite cortado.

## Telas — MELHORAR

- `evidence/ui/hud_preguica_x_jacare.png`: o nome `SEU PREGUIÇOSO` fica cortado no lado direito do painel de P1. Ajustar o tamanho do texto ou a largura disponível.
- `evidence/ui/selecao_13_jacare.png` a `selecao_18_tamandua.png`: os seis nomes e retratos conferem; não vi texto escapando dos painéis.
- `evidence/ui/hud_macaco_prego_x_mourisco.png`, `hud_ourico_x_beija_flor.png` e `hud_tamandua_x_juba.png`: nomes e retratos conferem e ficam nos painéis.
- `evidence/ui/resultado_p1_vence_juba.png`, `resultado_p2_vence_arara_canga.png` e `resultado_p2_vence_onca.png`: textos e retratos cabem nos painéis. Essas telas não mostram os seis lutadores novos.
