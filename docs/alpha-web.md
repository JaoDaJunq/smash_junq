# Smash Junq — Alpha Web

## Objetivo
Publicar a versão local do Smash Junq em navegador desktop via GitHub Pages, sem alterar a branch principal antes da revisão.

## Como publicar
1. Revisar e mesclar a branch `alpha-web` na `main`.
2. Em **Settings > Pages > Build and deployment**, escolher **GitHub Actions**.
3. Abrir **Actions > Alpha Web** e acompanhar o workflow da `main`.
4. Após sucesso, acessar https://jaodajunq.github.io/smash_junq/.

## Testes de aceitação
- Carregamento inicial e menu sem erros de console.
- Jogar vs CPU, Treino e dois jogadores no mesmo teclado.
- Gamepads conectados antes de iniciar a partida.
- Golpes, KO, pausa, revanche, áudio e tela cheia.
- Confirmar que todos os sprites e sons foram exportados.
- Testar Chrome e Firefox desktop.
- Verificar tamanho total do download e desempenho.

## Limitações
- Sem multiplayer pela internet.
- Prioridade para PC; mobile não é suportado nesta Alpha.
- Godot Web pode ter limitações de áudio e gamepad conforme navegador.
- Se o build falhar, baixar o artefato ou conferir logs do Actions.
- GitHub Pages precisa estar configurado para **GitHub Actions**.

## Feedback sugerido
Informar navegador, sistema operacional, modo, personagem, passos para reproduzir, resultado esperado e ocorrido.
