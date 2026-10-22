# Rodada 11 · avaliação completa e polimento (22/10/2026)

Pedido do João: depois de subir os personagens novos, avaliar tudo e já executar.

## Fase 1 · Levantamento (3 revisores em paralelo, só leitura, relatórios em `design/revisao-r11/`)
1. **Personagens novos** (Tucão, Dona Onça, Cutia, Calango): a ideia é diferente do elenco? Onde cabem efeitos? Como deixar cada golpe com a cara do personagem? Como interage com o resto (arenas, objetos, mecânicas dos outros: hipnose, estandarte, cama elástica, laço, casco, ficha corrida)?
2. **Atenção redobrada: Marianinha, Dona Canga e Seu Capivas**, nas 4 arenas: habilidades funcionam em todas (bordas, plataformas, paredes, quedas)? Algo passou batido?
3. **O jogo como um todo**: tela de início, mapa das arenas, seleção de personagens, HUD, pausa, vitória.

## Fase 2 · Execução
- Cutia e Calango: integração completa (sprites, código, testes), como Tucão e Onça.
- Correções e melhorias apontadas na fase 1, em lotes, cada lote com testes + prints em tamanho real + commit.
- Efeitos novos: pedidos ao Codex só dos efeitos (folhas `fx_*`), no máximo 2 chats ao mesmo tempo, portão e limite de 2 tentativas.
- Berrante e Seu Preguiçoso: base + parado assim que o gerador tiver folga.

## Regras
Mesmas de sempre: efeitos separados do sprite; conteúdo para todas as idades; conferir em tamanho real se "tem cara de golpe"; Godot fechado ao terminar; subir no git a cada etapa.
