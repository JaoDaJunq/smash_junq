# Revisão das telas fora da luta

Data: 22/10/2026. Escopo: menu, modo, seleção de personagem, seleção de arena,
HUD, pausa, resultado, como jogar e opções.

## Como foram feitos os prints

Teste novo `game/tests/ui_revisao_shots.tscn`. Ele abre cada tela com janela,
1920x1080, e salva em `evidence/ui/`:

- `menu`, `modo`
- `selecao_*`: um print para cada jogável, com o P1 nele e o P2 no próximo; mais um com o P2 no "?", um com o P1 confirmado, um com os dois confirmados ("PRONTOS!") e um no modo CPU.
- `arena_0..4`: Aleatória e as 4 arenas.
- `hud_*`: uma partida para cada par de jogáveis, com dano e KOs.
- `resultado_*`: 3 vencedores diferentes.
- `pausa`, `como_jogar`, `opcoes`, `controles`

Para gerar só uma parte: `-- so=menu,selecao,arena,hud,resultado,outras`.

Avaliei os prints em tamanho real e com recortes. O Godot fecha sozinho quando o teste termina.

## O que estava certo

- A grade mostra os 9 jogáveis com o retrato certo: Juba, Capivas, Maracajá, Canga, Marianinha, Sucuri, Peba, Tucão e Dona Onça. Cutia e Calango, que o coordenador está adicionando agora, também já aparecem. Os outros 13 lugares aparecem como "?".
- Nenhum nome é cortado. "Mestra Sucuri" é o mais longo e cabe.
- O mapa do Brasil está certo, com os pinos no lugar: Ruínas na Mata Atlântica (SE), Pantanal no MS/MT, Caatinga no NE e Cerrado no Centro. A prévia, o nome e a descrição aparecem e o botão "Aleatória" não fica por cima de nada.
- Teclado, controle e mouse funcionam. `match_smoke` e `menus_smoke` cobrem a navegação.
- A tela de resultado mostrava o vencedor certo e o placar.
- Não achei erro de português.

## Defeitos encontrados e correções

| # | Defeito | Correção | Arquivo |
|---|---|---|---|
| 1 | A arte pintada de apresentação (`assets/ui/apresentacao_*.png`, existe para os 11) só aparecia no menu (Juba e Capivas). Na seleção, o painel mostrava só o sprite pequeno ampliado. | O painel lateral agora mostra a arte pintada do lutador (corte no joelho, esmaecendo embaixo), entrando deslizando de fora para dentro, sobre um fundo na cor do grupo. O sprite do jogo fica pequeno no canto de fora, gingando. | `scripts/ui/character_select.gd` (`_show_splash`), `scripts/ui/ui_art.gd` (`splash`, `PANEL_BG`) |
| 2 | As descrições têm quebra de linha manual no meio da frase ("Rápido e leve:\ncombos..."), que somava com a quebra automática. Isso fazia a frase picotada ("combos e volta fácil, mas voa mais / cedo.") e mudava a altura do painel de um lutador para outro, empurrando as barras e o botão. | A descrição vira um parágrafo só, com altura fixa de 3 linhas e centralizada. As barras têm altura fixa e o status e o botão ficam presos embaixo. O painel não "pula" mais. | `character_select.gd`, `ui_art.gd` (`flat`) |
| 3 | O nome do lutador não tinha proteção para nomes longos. | O tamanho da fonte diminui se o nome não couber (`UiArt.fit_size`). | `character_select.gd`, `ui_art.gd` |
| 4 | O texto do "?" era seco ("Em breve: Mestre Muriqui (muriqui).") | Agora diz "Muriqui ainda está treinando. Em breve no torneio!" | `character_select.gd` |
| 5 | O mouse passando por cima da foto não fazia o "pulo" que o teclado faz. | Agora faz o mesmo `pop`. | `character_select.gd` (`_mouse_hover`) |
| 6 | Confirmar o lutador tinha pouca resposta e, com os dois prontos, a tela só esperava 0,5 s em silêncio. | Clarão no painel e pulo na foto ao confirmar. Com os dois prontos, a faixa "PRONTOS!" estoura no meio antes de ir para a arena. | `character_select.gd` (`_flash`, `_start_match`) |
| 7 | O HUD não tinha retrato, só "Jogador 1 · Nome", o % e os KOs. | Retrato em pixel art numa moldura com a cor do jogador, à esquerda de cada painel. Ao levar dano, o retrato pisca vermelho e dá um tranco junto com o número. Funciona para todos os personagens do elenco, porque busca o retrato pela cena do lutador. | `scripts/ui/hud.gd` (`_build_portrait`, `_punch_damage`) |
| 8 | A tela de resultado era só texto ("Jogador 2 venceu!", "com Dona Onça", placar) e usava os botões azuis do tema, diferentes das placas de madeira do resto. | Redesenhada: a arte pintada do vencedor entra grande pela esquerda e depois "respira". À direita ficam a faixa "Jogador N venceu!" na cor do jogador, "com <lutador>", o placar com os retratos dos dois (o perdedor apagado), os botões de madeira e confete verde-amarelo. A trava de 0,6 s nos botões continua. | `scripts/ui/results.gd` |
| 9 | O resultado não sabia qual personagem cada lado usou, só o nome. | `result_data` agora também manda `indices` (o índice em `Game.CHARACTERS`). A tela de resultado usa isso e, se faltar, cai em `Game.character_index`. | `scripts/match/match_manager.gd` (só `result_data`) |
| 10 | As telas de Modo de jogo e Pausa usavam o título dourado e os botões azuis do tema, diferentes do menu e da seleção. | Agora usam a faixa verde de campeonato e as placas de madeira, como o resto. | `scripts/ui/mode_select.gd`, `scripts/ui/pause_menu.gd` |
| 11 | Nas placas de madeira, os estados apertado e desabilitado vinham das cores do tema azul. | Cores e estilo próprios para `pressed`, `hover_pressed` e `disabled`. | `ui_art.gd` (`style_button`) |

## Pendências (não mexi, ficam como sugestão)

- **"%" no HUD**: a fonte do número de dano desenha o "%" como um "z" cortado ("109z"). É a fonte do `DamageLabel` no `theme.tres`. Duas saídas baratas: trocar só o "%" por outra fonte ou desenhar o sinal à parte. Não mexi porque o tema é usado em vários lugares.
- **Como jogar / Opções / Controles**: ainda usam os botões azuis do tema e o título dourado, sem placa de madeira. Não troquei porque o `menus_smoke` navega nessas telas por índice de filhos (`o.get_child(1).get_child(0)`), e mudar a estrutura pode quebrar o teste. Fica para quando for revisar esse teste.
- **Opções no print**: os três volumes aparecem em 0%. Pode ser o arquivo de opções da máquina, não verifiquei. Vale conferir se não é padrão errado.
- **Calango**: durante os prints apareceu `No loader found ... calango/pixel/andar.png`. É a importação que está acontecendo agora em paralelo, fora do meu escopo.
- **Roster**: Cutia e Calango já estão em `roster.gd`. A grade mostra 11 jogáveis quando os sprites estão importados.
- **Ideias baratas para depois**:
  - Tela de "carregando / VS" com as duas artes pintadas frente a frente entre a arena e a luta.
  - Som próprio de "PRONTOS!".
  - Na seleção de arena, mostrar o nome do bioma no pino só no hover, porque com mais arenas os nomes vão se encostar.

## Bateria

`rodar_testes.sh` depois das mudanças: os 15 testes deram `RESULTADO: OK`, com 0 erros de script.
