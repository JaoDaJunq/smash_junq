# Revisão R11 · O jogo como um todo (fora dos personagens)

Data: 22/10/2026 · Cópia revisada: worktree `rev_jogo` (nenhum código do jogo foi alterado).
Prints em tamanho real (1920x1080): `evidence/revisao-r11/` — gerados pela cena nova
`game/tests/r11_jogo_shots.tscn` (rodar COM janela:
`--path game --resolution 1920x1080 res://tests/r11_jogo_shots.tscn`). Mosaicos de apoio:
`mosaico_paineis.png`, `mosaico_menus.png`, `mosaico_partida.png`, `mosaico_arenas.png`,
`mosaico_apresentacao.png`, `mosaico_extra.png`.

Legenda: **[código]** = só código · **[imagem]** = precisa de arte nova · **[ambos]**.

---

## Resumo rápido

- **1 bug feio de verdade:** na seleção de personagens, **Tucão e Dona Onça aparecem quebrados no
  painel grande** (pedaços de dois quadros lado a lado). Causa: o boneco animado do painel supõe
  quadros de 64 px, mas a folha deles tem quadros de 80 px (Tucão) e 84 px (Onça).
- **A arte de apresentação (pintada) existe para os 9 personagens, inclusive Tucão e Onça, mas só
  Juba e Seu Capivas aparecem em alguma tela** (menu inicial). As outras 7 não aparecem em lugar
  nenhum. É o maior ganho fácil: dá para usar na seleção, no resultado e no menu sem arte nova.
- **A tela de vitória é pobre:** só texto ("JOGADOR 1 VENCEU!"), sem o personagem, sem festa, e sem
  botão para trocar de lutador (é preciso voltar ao menu e passar por 3 telas).
- **Dois estilos visuais misturados:** menu inicial, seleção e mapa usam placas de madeira + faixa
  verde; Modo de jogo, Opções, Controles, Como jogar, Pausa, Treino, Resultado e HUD usam botões
  azul-marinho "genéricos".
- Nada de texto cortado/sobreposto nas telas; navegação funciona; nenhum "?" em personagem que já
  existe. Os 9 retratos da grade estão certos.

---

## 1. Menu inicial (`scripts/ui/main_menu.gd`)

Evidência: `01_menu.png`, `mosaico_menus.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 1.1 | MÉDIA | Só Juba e Seu Capivas aparecem. Com 9 jogáveis (11 em breve), o menu não mostra o elenco. As 7 outras artes (`assets/ui/apresentacao_*.png`) estão prontas e sem uso. | `main_menu.gd` `_ready()`: sortear 2 personagens diferentes a cada abertura (lista dos ids de `Game.CHARACTERS` com `apresentacao_<id>.png` existente) em vez dos caminhos fixos de Juba/Capivas. Opcional: trocar o par a cada ~8 s com o mesmo deslize de entrada. | [código] |
| 1.2 | BAIXA | "Sair" fecha o jogo na hora; criança aperta sem querer. | Em "Sair", pedir confirmação ("Sair do jogo? Sim / Não") ou exigir segurar o botão 1 s. | [código] |
| 1.3 | BAIXA | Dica do rodapé fica pequena (22 px) e em fonte estreita, difícil de ler da TV. | `hint` para 26 px. | [código] |

Visual do menu: bonito e coerente (logo, fundo pintado, placas de madeira). Nada cortado.

## 2. Modo de jogo (`scripts/ui/mode_select.gd`)

Evidência: `02_modo.png` (canto inferior direito de `mosaico_partida.png`).

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 2.1 | MÉDIA | Botões azul-marinho pequenos (440x70, fonte pequena) — destoa do menu inicial (madeira, 460x76) que vem logo antes. Título "Modo de jogo" em fonte de tema, não na faixa verde das outras telas novas. | Chamar `UiArt.style_button(b)` em cada botão (como no `main_menu.gd`) e trocar o título por `UiArt.ribbon("MODO DE JOGO", 46)`. Ideal: centralizar isso em `MenuScreen.add_button()` para todas as telas (ver 10.1). | [código] |
| 2.2 | MÉDIA | Não há como escolher o número de KOs (sempre 3, `Game.ko_target`). Para criança, 2 KOs (partida curta) ou 5 (longa) é comum no gênero. | Adicionar linha "KOs para vencer: « 3 »" (esquerda/direita 1–5) em `mode_select.gd`, gravando em `Game.ko_target`. Atualizar o texto fixo "Vence quem fizer 3 KOs" em `how_to_play.gd` (`RULES`) para usar `Game.ko_target`. | [código] |
| 2.3 | BAIXA | Só volta com Esc/B (`ui_cancel`); Especial e Pausa não voltam aqui, mas voltam na seleção e no mapa. | Tratar `p1_special/p2_special` e `p1_pause/p2_pause` como voltar em `MenuScreen._poll_buttons()` (ver 10.2). | [código] |
| 2.4 | BAIXA | Sem descrição do modo (o que é "Treino"?). Criança não lê, mas o pai sim. | Linha de dica embaixo que muda com o foco ("Bata num boneco para treinar golpes"). | [código] |

## 3. Seleção de personagens (`scripts/ui/character_select.gd`, `ui_art.gd`, `roster.gd`)

Evidências: `10_selecao_tucao_onca.png`, `11_selecao_p1_pronto.png`, `12_selecao_mesmo_quadro.png`,
`13_selecao_em_breve.png`, `14_painel_*.png` (os 9), `15_selecao_cpu.png`, `mosaico_paineis.png`,
`mosaico_extra.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 3.1 | **ALTA** | **Tucão e Dona Onça quebrados no painel grande**: aparecem cortados, com pedaço de outro quadro ao lado (`14_painel_07_tucano.png`, `14_painel_08_onca.png`, `mosaico_extra.png`). `UiArt.FighterIdle.setup()` usa `frames = largura/64` e região 64x64, mas `tucano/pixel/parado.png` é 320x64 (4 quadros de 80) e `onca/pixel/parado.png` é 336x64 (4 de 84) — no jogo isso está certo porque `pixel_sprite.gd` lê `animacoes.json` e usa `center_x` 40/42. | Em `ui_art.gd` `FighterIdle.setup()`: ler `animacoes.json` da mesma pasta, `frames = parado.quadros`, `frame_w = sheet.get_width() / frames`; `region = Rect2(i*frame_w, 0, frame_w, 64)`; `custom_minimum_size = Vector2(frame_w, 64) * px`. Em `character_select.gd` `_show_fighter()`: centralizar com `f.custom_minimum_size.x` em vez de `64 * 5.6`. Acrescentar ao `novos_smoke`/teste um check "quadro do painel = largura/quadros" para Cutia e Calango não repetirem o erro. | [código] |
| 3.2 | ALTA | Arte de apresentação de Tucão/Onça (e de todos menos Juba/Capivas) **não aparece**. O painel mostra só o sprite pequeno do jogo; num jogo do gênero o "retrato grande" na seleção é o momento de brilho do personagem. | No painel (`_build_side`/`_show_fighter`): mostrar `assets/ui/apresentacao_<id>.png` (TextureRect, `STRETCH_KEEP_ASPECT_CENTERED`, filtro linear, altura ~340) quando existir; sprite animado como reserva. Opção: arte pintada enquanto escolhe + sprite fazendo o "parado" quando confirma (PRONTO!). | [código] (arte já existe) |
| 3.3 | MÉDIA | Não há **Aleatório** (quadro com dado). Padrão no gênero e ótimo para criança indecisa. | Em `roster.gd`/`character_select.gd`: um quadro extra "Aleatório" (ex.: abaixo da grade, ao lado de Voltar, ou célula à direita de cada linha). Ao confirmar, sorteia entre `Game.character_ready()`. | [código] |
| 3.4 | MÉDIA | 15 dos 24 quadros são "?" — a grade parece "vazia" e o olho vai para os "?". Os jogáveis não se destacam o bastante. | `_refresh()`: "?" com `modulate` 0.5 (hoje 0.75) e sem a cor do grupo no fundo; jogáveis com fundo um pouco mais claro. Ou mostrar silhueta escura do bicho (precisa de imagem). | [código] / [imagem] p/ silhuetas |
| 3.5 | MÉDIA | Descrição em fonte estreita 22 px, tudo maiúsculo e 3–4 linhas: difícil para criança e para ler da TV. Palavras soltas em linha ("CEDO.", "OUTROS.", "DO GOLPE.") em Juba, Marianinha, Seu Peba (`mosaico_paineis.png`). | Encurtar `desc` em `game_state.gd` para 1 frase curta de até ~45 caracteres + mover a 2ª parte para "dica" opcional; ou subir a fonte para 24 e tirar o `\n` fixo (deixar o autowrap quebrar). | [código] |
| 3.6 | BAIXA | No "?" o texto é "Em breve: Calango (calango)." — nome repetido; revela nomes futuros (ok, mas é spoiler). | `_refresh()`: só mostrar `(animal)` se diferente do nome; ou só "Em breve!". | [código] |
| 3.7 | BAIXA | Quando Cutia e Calango entrarem: `roster.gd` tem `"Cutia Ligeira"` e `"Calango"` com `char: -1`; precisa apontar o índice em `Game.CHARACTERS` (e o nome exibido virá do slot do roster, não de `CHARACTERS` — "Cutia Ligeira" vs. "Cutia"). | Ao integrar: atualizar `char` nos dois slots e alinhar o nome. Ideal: `_refresh()` usar `Game.CHARACTERS[idx].name` quando jogável, para não ter 2 fontes de nome. | [código] |
| 3.8 | BAIXA | Mouse só controla o Jogador 1 no modo 2 jogadores; passar o mouse parado sobre a grade move o cursor do P1 sem querer. | Só mover no hover se o mouse realmente se mexeu (`InputEventMouseMotion` com `relative` > 0), ou só no clique. | [código] |
| 3.9 | BAIXA | Sem som/voz do nome do personagem ao confirmar ("Tucão!"). | Ver 9.2. | [imagem/áudio] |
| 3.10 | BAIXA | Descrição do Tucão em `game_state.gd` tem quebra de linha literal dentro da string (os outros usam `\n`). Funciona, mas é frágil. | Trocar por `\n`. | [código] |

O que está bom: retratos dos 9 na grade corretos e sem esticar; nenhum "?" em quem existe; 1P/2P
no mesmo quadro mostram os dois marcadores + borda dourada; "PRONTO!" verde é claro; modo CPU diz
"Você escolhe o seu lutador e depois o da CPU" e escurece o lado que espera.

## 4. Escolha de arena / mapa do Brasil (`scripts/ui/arena_select.gd`)

Evidências: `20_arena_0.png` … `20_arena_4.png`, `mosaico_arenas.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 4.1 | MÉDIA | Prévia da "Aleatória" usa o fundo do menu (parece uma arena de verdade que não existe). | `_refresh()` com `opt < 0`: montar um mosaico 2x2 das 4 prévias (ou as prévias girando a cada 0,4 s) com um "?" grande por cima. | [código] |
| 4.2 | MÉDIA | Prévia das Ruínas da Mata tem outro estilo (vetorial roxo/sci-fi, com Juba e Capivas antigos) — as outras 3 são pintadas e em pixel art. A arena em si também destoa (`31_hud_luta.png`). | Refazer a prévia das Ruínas com o mesmo enquadramento das outras (print da arena atual sem lutadores). A arena em si precisaria de arte nova no estilo das demais. | prévia [código: novo print] · arena [imagem] |
| 4.3 | BAIXA | O botão "Aleatória" fica solto embaixo do mapa, longe dos pinos; com teclado ele é o 1º item, mas visualmente parece outro controle. | Botão com ícone de dado e no mesmo "trilho" de navegação (ex.: um pino no mar à direita, "Sorteio"). | [código] |
| 4.4 | BAIXA | Revanche com arena "Aleatória" repete a mesma arena (a arena só é sorteada ao montar a partida). | Aceitável; se quiser re-sortear, ao "Revanche" recarregar a cena quando `Game.arena_index < 0`. | [código] |
| 4.5 | BAIXA | Cima/baixo andam como esquerda/direita (na ordem da lista, não do mapa). Para criança, apertar "cima" e ir para um pino abaixo confunde. | `_move()` direcional: escolher o pino mais próximo na direção apertada (usar `pin` de `Game.ARENAS`). | [código] |

Mapa bonito, pinos nos lugares certos (Pantanal no MS, Caatinga no NE, Cerrado no centro, Ruínas na
Mata Atlântica), nomes legíveis, sem sobreposição. Com 4 arenas está ótimo; cabe mais (Amazônia,
Pampa, litoral).

## 5. Partida: contagem e HUD (`scripts/ui/hud.gd`, `scripts/match/match_manager.gd`)

Evidências: `30_contagem.png`, `31_hud_luta.png`, `33_morte_subita.png`, `34_fim_banner.png`,
`36_hud_versus_pantanal.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 5.1 | MÉDIA | HUD sem rosto do personagem: só "JOGADOR 1 · MESTRA SUCURI" em letra pequena. Criança identifica pelo rosto, não pelo texto. Os KOs são bolinhas genéricas. | `hud.gd` `_build_panel()`: `TextureRect` com `assets/characters/<id>/retrato_pixel.png` (~96 px) à esquerda do dano; KOs como mini-retratos (ou manter bolinhas). O `id` vem de `Game.CHARACTERS[Game.character_index(pid)]`. | [código] |
| 5.2 | MÉDIA | Estilo do HUD (painel azul-marinho, fonte digital) não conversa com os menus de madeira/faixa verde. | `HudPanel` no `theme.tres`: borda/fundo no tom madeira escura com fita da cor do jogador; manter número grande. | [código] |
| 5.3 | BAIXA | Contagem "3, 2, 1" cinza-clara, sem contorno grosso — some no céu roxo (`30_contagem.png`). "LUTEM!" já é dourado. | Em `match_manager.gd` `_process()`: cor `UiArt.GOLD`/creme com contorno escuro (`BannerLabel` com `outline_size` 14) e escala maior nos números. | [código] |
| 5.4 | BAIXA | "FIM!" na cor do vencedor, mas não diz quem ganhou. | Banner "JUBA VENCEU!" ou "FIM!" + zoom da câmera no vencedor por 1 s antes do resultado. | [código] |
| 5.5 | BAIXA | Marcadores P1/P2/CPU em cima dos bonecos são pequenos (`36_hud_versus_pantanal.png`); com bichos parecidos (Maracajá x Onça) a criança pode se perder. | Aumentar o marcador (fonte 22, seta maior) e/ou contorno colorido fino no sprite do jogador. | [código] |

Dano muda de cor (branco → amarelo → vermelho) e é legível; KOs animam; MORTE SÚBITA aparece bem.

## 6. Pausa (`scripts/ui/pause_menu.gd`)

Evidência: `32_pausa.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 6.1 | MÉDIA | "Reiniciar" e "Sair para o menu" sem confirmação, logo abaixo de "Continuar": criança aperta e perde a partida. | Confirmar ("Tem certeza? Sim/Não") em Reiniciar e Sair; ou segurar 1 s. | [código] |
| 6.2 | BAIXA | Não diz quem pausou. | Subtítulo "Pausado pelo Jogador 2" (cor do jogador) em `toggle()`/`open(pid)`. | [código] |
| 6.3 | BAIXA | Botões azul-marinho (estilo diferente dos menus). Falta "Trocar lutadores" e "Controles" na pausa. | Ver 10.1; adicionar "Trocar lutadores" → `Game.go_to(Game.SELECT_SCENE)`. | [código] |

## 7. Tela de vitória / resultado (`scripts/ui/results.gd`)

Evidências: `35_resultado.png`, `37_resultado_p2.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 7.1 | **ALTA** | Sem o personagem vencedor: só texto sobre a arena escurecida. É o momento mais esperado do gênero (pose de vitória). | `results.gd`: tela própria (fundo pintado `UiArt.backdrop`) com `apresentacao_<id>.png` do vencedor grande à esquerda, entrando com o deslize do menu; perdedor menor e acinzentado à direita (ou o sprite "dor"). Confete/serpentina (partículas simples) + faixa verde "VITÓRIA!". | [código] (arte já existe) |
| 7.2 | ALTA | Só "Revanche" e "Menu". Para trocar de lutador é Menu → Jogar → Modo → Seleção (3 telas). | Botões: "Revanche", "Trocar lutadores" (`Game.go_to(Game.SELECT_SCENE)`, mantém o modo), "Trocar arena" (`ARENA_SELECT_SCENE`), "Menu". | [código] |
| 7.3 | MÉDIA | Título fala "JOGADOR 1 VENCEU!" / "CPU VENCEU!" e o personagem vem pequeno embaixo ("com Mestra Sucuri"). Para criança o herói é o bicho. | Título: "MESTRA SUCURI VENCEU!" (grande); subtítulo "Jogador 1" na cor do jogador. | [código] |
| 7.4 | MÉDIA | Placar "JOGADOR 1 3 X 2 CPU" em fonte média, sem destaque; nenhuma estatística divertida. | Placar grande com retratos; opcional: "Golpe mais forte", "Maior dano" (dados já existem em `_last_hits`). | [código] |
| 7.5 | BAIXA | Som de fim é só um "bong". | Jingle de vitória curto (2–3 s) + aplausos. | [imagem/áudio] |

## 8. Treino (`scripts/match/training_mode.gd`)

Evidências: `40_treino.png`, `41_treino_painel.png`.

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 8.1 | BAIXA | HUD mostra bolinhas de KO, que não valem no treino. | `hud.gd`: `markers.visible = Game.mode != "training"`. | [código] |
| 8.2 | BAIXA | Linha do topo em fonte pequena com números técnicos ("Lançamento: 1234 px/s") — útil para o João calibrar, não para a Alice. | Deixar só "Dano" e "KO!" por padrão; números técnicos ligados por uma opção "Mostrar números". | [código] |
| 8.3 | BAIXA | Painel no estilo azul (ver 10.1). Fora isso, claro e sem texto cortado. | — | [código] |

## 9. Som e "vida" do jogo

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 9.1 | MÉDIA | O arquivo real de opções do usuário (`%APPDATA%/Godot/app_userdata/Smash Junq/settings.cfg`, de 18/10) está com **volume geral, efeitos e música = 0** — o jogo está mudo nessa máquina. Pode ter sido escolha, ou um teste que vazou. Os prints de Opções mostram 0%. | Conferir com o João. Se foi teste: garantir que todo teste que mexe em `Settings` troque `file_path` (como `menus_smoke` faz). | [código]/conferir |
| 9.2 | BAIXA | Sem narrador/voz ("Três, dois, um, LUTEM!", nome do personagem na seleção, "Vitória!"). | Gravar voz (o João/Alice podem gravar!) e tocar em `match_manager` (contagem) e `character_select` (confirmar). | [áudio] |
| 9.3 | BAIXA | Uma faixa de menu e duas de luta para 4 arenas. | Uma faixa por bioma (forró na Caatinga, etc.). | [áudio] |

## 10. Coerência geral e fluxo entre telas

| # | Grav. | Problema | Correção proposta | Tipo |
|---|---|---|---|---|
| 10.1 | MÉDIA | Dois estilos: madeira/faixa verde (menu inicial, seleção, mapa) x azul-marinho do tema (Modo, Opções, Controles, Como jogar, Pausa, Treino, Resultado, HUD). Ver `mosaico_menus.png`. | Em `menu_screen.gd`: `add_button()` chamar `UiArt.style_button(b)`; `build_column()` usar `UiArt.ribbon(title)` no lugar do `TitleLabel` + filete. Isso alinha 8 telas de uma vez. Painéis (`training_mode`, `how_to_play`) com `UiArt.panel()`. | [código] |
| 10.2 | MÉDIA | "Voltar" inconsistente: Esc/B em todas; Especial volta no mapa mas não no Modo/Opções/Como jogar; Pausa volta na seleção e no mapa mas não nas outras. | `MenuScreen._poll_buttons()`: Especial = voltar (chamar um `_on_back()` virtual que cada tela implementa), e documentar "Especial volta" no rodapé de todas as telas. | [código] |
| 10.3 | MÉDIA | Fluxo depois da luta longo (ver 7.2). Fluxo antes: Menu → Modo → Seleção → Arena → Luta — ok, padrão do gênero. | Ver 7.2. | [código] |
| 10.4 | BAIXA | "Como jogar" é uma tabela densa de texto pequeno (`03_como_jogar.png`); criança não lê. | Página 1 com 4 desenhos/ícones grandes ("Bata", "Pule", "Jogue para fora", "3 vezes ganha"); a tabela vira página 2. Ícones simples precisam de arte. | [ambos] |
| 10.5 | BAIXA | Sem transição entre telas (corte seco + fade curto só no conteúdo). | Fade preto de 0,15 s em `Game.go_to()` (CanvasLayer autoload). | [código] |

---

## O que precisa de imagem/áudio novo (separado)

1. Arena Ruínas da Mata no estilo pintado/pixel das outras (4.2) — e prévia nova.
2. Silhuetas dos personagens "em breve" para a grade (3.4) — opcional.
3. Ícones grandes para a página infantil do "Como jogar" (10.4).
4. Voz de narrador/nomes e jingle de vitória (7.5, 9.2); músicas por bioma (9.3).

Todo o resto é **só código** — inclusive usar as 9 artes de apresentação que já existem.

## Lista priorizada

1. **ALTA · 3.1** Corrigir `FighterIdle` (quadro = largura/quadros do `animacoes.json`) — Tucão e Onça quebrados na seleção; Cutia/Calango podem vir igual. [código, pequeno]
2. **ALTA · 7.1 + 7.3** Tela de vitória com a arte de apresentação do vencedor, nome do bicho no título e festa. [código]
3. **ALTA · 7.2** Botões "Trocar lutadores" / "Trocar arena" no resultado (e na pausa, 6.3). [código, pequeno]
4. **ALTA · 3.2** Arte de apresentação no painel da seleção. [código]
5. **MÉDIA · 10.1** Unificar estilo (madeira/faixa) via `MenuScreen` — alinha 8 telas. [código]
6. **MÉDIA · 9.1** Conferir volume 0 no `settings.cfg` real. [conferir]
7. **MÉDIA · 3.3** Personagem aleatório. [código]
8. **MÉDIA · 1.1** Menu inicial sorteando a dupla do elenco. [código, pequeno]
9. **MÉDIA · 5.1/5.2** Retrato no HUD e HUD no estilo do jogo. [código]
10. **MÉDIA · 6.1** Confirmação em Reiniciar/Sair na pausa. [código]
11. **MÉDIA · 2.2** Escolher número de KOs. [código]
12. **MÉDIA · 10.2** "Especial volta" em todas as telas. [código]
13. **MÉDIA · 3.4/3.5** Destacar jogáveis vs "?"; descrições mais curtas. [código]
14. **MÉDIA · 4.1/4.2** Prévia da Aleatória; prévia/arte das Ruínas. [código / imagem]
15. **BAIXAS**: 5.3 contagem dourada, 5.4 "FIM!" com nome, 5.5 marcadores maiores, 8.1 esconder KOs no treino, 3.6/3.7/3.8/3.10, 4.3/4.4/4.5, 1.2/1.3, 2.3/2.4, 6.2, 8.2, 10.4, 10.5, 9.2/9.3.

## Arquivos criados nesta revisão (só na cópia `rev_jogo`)

- `game/tests/r11_jogo_shots.gd` / `.tscn` — prints de todas as telas e estados (menu, modo, como
  jogar, opções, controles, seleção em 2P/CPU/"?"/mesmo quadro, painel dos 9, 5 opções de arena,
  contagem, HUD, pausa, morte súbita, fim, resultado P1/P2, treino e painel do treino).
- `evidence/revisao-r11/*.png` — prints e mosaicos.
