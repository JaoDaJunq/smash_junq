# Arsenal do Jogo com IA

> **Versão 2.1 · revisão em 14/10/2026. Etapa atual: 0, escolha e validação do jogo.** Proposta aprovada até aqui: um jogo 2D de luta em plataformas, inspirado no formato de combate de Super Smash Bros. O escopo da primeira versão, a plataforma, o público e os modos ainda precisam ser definidos. Nenhum jogo específico deve ser presumido a partir de projetos anteriores.

## Resumo executivo da revisão

**Avaliação:** a escolha de Godot, o estúdio de agentes, a ponte MCP e a produção visual em nuvem formam uma base inicial coerente. As especificações do PC de casa ainda não foram confirmadas. O catálogo é amplo, mas a versão inicial ainda não distinguia ferramentas confirmadas de experimentos, não tinha uma especificação de entrega e tratava custos e licenças como estáveis. Esta revisão mantém a rota, acrescenta critérios de aprovação, rastreabilidade dos assets, testes, exemplos reais e corrige a condição de uso do Tripo Free.

**O que significa “100% com IA”:** IA pode elaborar design, código, arte, animação, áudio e testes. O criador define direção, aprova ou rejeita resultados e joga para validar. IA na criação **não** implica colocar um modelo generativo dentro do jogo. IA em tempo de execução é uma decisão futura, com custo, latência, moderação e funcionamento offline próprios.

**Regra de prioridade:** usar primeiro as ferramentas escolhidas e já catalogadas. Uma ferramenta nova só entra se resolver uma lacuna concreta, após checar licença, compatibilidade com Godot 4.7, manutenção, custo e resultado em um teste pequeno. Estrelas são retrato datado, não critério de seleção.

### Decisões e pendências

| Estado | Decisão | Critério para rever |
|---|---|---|
| Fechada | Godot 4.7 como linha; instalar a última correção estável da linha (4.7.2 em 14/10/2026), sem migrar automaticamente para 4.8 dev | Incompatibilidade comprovada ou ganho essencial testado |
| Fechada | Claude-Code-Game-Studios organiza briefs, tarefas, papéis e revisões; começar apenas com os comandos necessários | Complexidade maior que o benefício no primeiro protótipo |
| Fechada | `hi-godot/godot-ai` é a ponte principal; fixar uma release publicada e testar conexão com o editor | Falha reproduzível no Windows, com issue e teste de alternativa |
| Fechada | Geração 3D pesada e animação generativa ficam na nuvem | Hardware diferente e benchmark medido |
| Em andamento | Brief do jogo: gênero e câmera 2D definidos; falta fechar plataforma, público, controles, duração, diferencial e escopo da primeira versão | Aprovar um brief de uma página |
| Fechada | Começar em 2D; expansão para 3D ou outros formatos fica para uma decisão futura | Reavaliar só depois do protótipo 2D jogável |
| Aberta | Comercialização e distribuição | Definir antes de incorporar assets de planos gratuitos com restrições |

## Rota operacional e critérios de saída

Seguimos as sete etapas da rota original abaixo. O progresso só avança quando o artefato e a prova de funcionamento existem.

| Etapa | Entrega concreta | Gate de aprovação |
|---|---|---|
| 0. Escolha do jogo (atual) | Brief: fantasia central, ação repetida pelo jogador, gênero, câmera, plataforma, sessões, referências e três exclusões de escopo | Proposta 2D e mecânica central aprovadas; fechar o restante do brief antes de avançar |
| 1. Ideia e GDD | `/brainstorm` → brief; `/map-systems` e `/design-system` só para sistemas do primeiro corte; backlog com tarefas pequenas | Loop jogável explicado em 30 segundos; condições de vitória/derrota e controles escritos |
| 2. Engine e ponte | Projeto Godot versionado, plugin fixado, cena inicial, execução e screenshot pelo MCP | Um agente altera uma cena, roda o jogo e registra a evidência; sem erros na importação |
| 3. Bíblia visual | Paleta, silhuetas, escala, câmera, UI, 3 a 5 referências e folha de personagem aprovada | O mesmo personagem e cenário mantêm proporções, estilo e leitura no tamanho real do jogo |
| 4. Arte e integração | Um personagem, um inimigo/obstáculo, um cenário e um efeito; fontes + exportações + metadados | Assets entram no Godot com pivô, escala, transparência/material e animações corretos; nada depende de recorte manual não registrado |
| 5. Rig e animação | Idle, locomoção, ação principal, impacto e derrota; estado e transições | Sem inversão cabeça/corpo, escorregamento, salto de escala ou frame residual; testar em todas as direções usadas |
| 6. Som e voz | Efeitos ligados aos eventos, música em loop e mix mínimo | Timing e volume conferidos no jogo; licenças e fontes registradas |
| 7. Testar e repetir | Uma fase curta exportável, checklist visual, testes de lógica e registro de bugs | Rodar no PC alvo, revisar manualmente, fechar bugs bloqueadores e gerar build reproduzível |

**Primeiro corte vertical:** uma única sessão completa de 5 a 10 minutos com menu simples, início, ação principal, resposta visual e sonora, desafio, fim e reinício. Os números são meta inicial para dimensionar escopo, não compromisso de design. Só depois expandir níveis, personagens e geração em lote.

### Brief inicial do jogo (etapa 0)

**Decisões confirmadas pelo criador**
- Gênero: jogo de luta em plataformas (*platform fighter*), inspirado na estrutura de combate de Super Smash Bros.
- Visual e câmera iniciais: 2D lateral. Pensar em expansão para 3D ou outros formatos somente depois; isso ainda não é compromisso.
- Mecânica central: golpes acumulam dano no adversário; conforme o dano aumenta, os golpes tendem a lançá-lo mais longe. A vitória ocorre ao arremessar o oponente para fora dos limites da arena.
- Os personagens terão habilidades próprias. Elenco, tema, estilo visual e universo ainda estão em aberto.

**Proposta de escopo para validar, ainda não aprovada**
- Primeiro protótipo: uma arena, dois personagens, combate local 1 contra 1, golpes básicos e especiais, recuperação após ser lançado, limites de nocaute e reinício rápido.
- Adiar modos online, elenco grande, itens, múltiplas arenas e conteúdo de campanha até o combate básico ser divertido e estável.
- Começar com personagens, nomes, visuais, sons e cenários originais. Usar Smash como referência de gênero e mecânicas, sem copiar personagens, marcas ou assets da Nintendo.

**Ainda falta decidir:** plataforma inicial, perfil de jogador, controles, duração de partida e três exclusões de escopo. A recomendação inicial é validar primeiro uma partida local curta no PC, mas isso depende de aprovação e não é requisito fechado.

### Fluxo de trabalho repetível

1. Escrever uma tarefa com comportamento esperado, referência visual, arquivos afetados e critério de aceite.
2. Criar branch pequena; guardar conceitos e fontes originais. Fixar versão de engine, plugin e serviços usados.
3. Gerar ou editar o artefato; importar no Godot. Registrar prompt, modelo/serviço, plano/licença, data e operações manuais.
4. Rodar importação e teste de lógica; capturar screenshot ou vídeo da cena **em funcionamento**, com comparação à referência. Revisar visualmente no tamanho real.
5. Corrigir, reexecutar e concluir somente com evidência. A IA propõe o próximo lote; o criador aprova o resultado visual e a jogabilidade.

**Contrato mínimo de asset** (`assets/manifest.csv` no futuro repositório): `id, tipo, personagem/mapa, arquivo_fonte, arquivo_exportado, resolução_ou_tris, frames, fps, direção, pivô, licença, origem, plano, prompt_ou_referência, data, estado_aprovação`. Para 2D, guardar atlas sem rótulos na área de frames, alfa verdadeiro, dimensões e ordem de frames; validar ausência de cortes, bordas, duplicatas e mudança de escala. Para 3D, guardar `.blend` quando houver edição, exportar `.glb`, conferir rig, UV, materiais, escala, colisões e animações. Não definir um teto universal de 5 mil faces: medir por tipo de objeto e plataforma.

**Teste mínimo:** lógica crítica com GdUnit4 (ou teste Godot equivalente após piloto), importação e inicialização em `--headless`, exportação na versão fixada, e teste manual das telas, controles e animações. CI executa verificações em push; desempenho e qualidade visual precisam de execução real na máquina alvo. O MCP acelera o ciclo, mas screenshot e log sozinhos não provam que o jogo é divertido.

### Estrutura inicial sugerida para o repositório do jogo

```text
game/                 projeto Godot e project.godot
assets/source/        fontes de arte e áudio, quando a licença permitir
assets/export/        arquivos otimizados importados no jogo
assets/manifest.csv   procedência, configuração e aprovação
design/               brief, GDD pequeno e bíblia visual
docs/decisions/       decisões e mudanças de direção
tests/                lógica, cenas e validação de importação
evidence/             capturas de revisão e relatórios de teste
```

Não duplicar automaticamente a estrutura inteira do Claude-Code-Game-Studios: adaptar os caminhos ao template real instalado e manter uma única fonte de verdade para cada documento.

## Validação de ferramentas e casos novos

| Item | Tipo | O que foi confirmado | Uso recomendado |
|---|---|---|---|
| [Godot 4.7.2](https://godotengine.org/download/archive/) | Base escolhida | Correção estável publicada em agosto de 2026; 4.8 ainda está em desenvolvimento em 14/10 | Fixar 4.7.2 no protótipo e registrar o executável usado |
| [Claude-Code-Game-Studios](https://github.com/Donchitos/Claude-Code-Game-Studios) | Base escolhida | README atual informa 49 agentes, 74 skills/comandos, 12 hooks e 39 templates | Usar brief e fluxo de tarefas antes de acionar dezenas de especialistas |
| [godot-ai](https://github.com/hi-godot/godot-ai) | Base escolhida | Plugin conecta editor vivo a clientes MCP e exige Godot 4.7+; instalação e migração v4 têm instruções específicas | Instalar release publicada seguindo o procedimento de verificação; testar alteração e execução de cena |
| [GdUnit4](https://github.com/godot-gdunit-labs/gdUnit4) e [gdUnit4-action](https://github.com/godot-gdunit-labs/gdUnit4-action) | Novo no catálogo | Testes de GDScript/cenas e integração com CI | Piloto na lógica central; conferir release compatível antes de fixar |
| [godot-ci](https://github.com/abarichello/godot-ci) | Novo no catálogo | Imagens e exemplos para exportação em CI | Considerar só após definir plataforma; usar tag da linha 4.7 se disponível e testar |
| [GodotIQ](https://github.com/salvo10f/godotiq) | Alternativa, não instalar agora | Análise espacial e de fluxo; conjunto completo em camada Pro | Avaliar apenas se o godot-ai não cobrir um problema real de depuração |
| [Godot Reversi](https://github.com/regiellis/godot-reversi) | Caso verificável | Jogo completo com fonte e execução, criado por agente no editor; README relata falhas visuais corrigidas por revisão humana | Evidência de loop agente/editor; não prova criação de um gênero novo com um único prompt |
| [GodotIQ Crystal Keep](https://github.com/salvo10f/godotiq) | Demonstração do autor da ferramenta | Relato de tower defense 3D construído a partir de brief e kit de assets | Inspirar prova de integração; verificar build/código antes de assumir resultado independente |
| [Godot Asset Store](https://godotengine.org/article/introducing-the-godot-asset-store/) | Fonte oficial | Nova loja integrada à linha 4.7; o catálogo antigo permanece em transição | Procurar base CC0/MIT e validar licença do item individual |
| [PlatformFighterGodot](https://github.com/L4igi/PlatformFighterGodot) | Referência direta de mecânicas | Protótipo Godot inspirado em Smash, com estados de personagem, estágios, itens/projéteis e dados de ataque como dano e ângulo de knockback | Estudar como referência. Usa `KinematicBody`, API anterior ao Godot 4; adaptar antes de reaproveitar. README credita sprites de Mario e Link; não importar esses assets. Licença do código precisa ser confirmada antes de qualquer cópia. |
| [Shoto Fighter Godot](https://github.com/aminRX/shoto-fighter-godot) | Referência de arquitetura | Jogo 2D tradicional, não platform fighter; separa lógica e arte, usa estados, ataques dirigidos por dados e testes automatizados. Código MIT | Aproveitar padrões e testes, não suas regras de luta como especificação do nosso jogo. Sprites incluídos têm licença não comercial; substituir por arte própria. |
| [Godot Rollback Fighter Demo](https://github.com/blast-harbour/Godot-Rollback-Fighter-Demo) | Referência futura de multiplayer | Exemplo de luta com rollback, hitboxes/hurtboxes, estados e projéteis; baseado em Godot 4.2.2 e componentes com licenças próprias | Não adicionar ao primeiro protótipo. Reavaliar após combate local e decisão explícita de incluir jogo online. |

**Lição dos casos:** o ganho está no ciclo brief → cena → execução → feedback → correção. Mesmo o caso Reversi, com regras conhecidas, precisou corrigir interface e áudio após parecer pronto. Para nossa mecânica original, reservar iteração e playtest; não prometer que uma geração resolve tudo.

## Fontes e política de atualização

Pesquisa verificada em 14/10/2026. Links primários: [arquivo oficial Godot](https://godotengine.org/download/archive/), [documentação de importação 3D](https://docs.godotengine.org/en/4.7/tutorials/assets_pipeline/importing_3d_scenes/import_configuration.html), [Godot AI](https://github.com/hi-godot/godot-ai), [CCGS](https://github.com/Donchitos/Claude-Code-Game-Studios), [GdUnit4](https://github.com/godot-gdunit-labs/gdUnit4), [Godot Reversi](https://github.com/regiellis/godot-reversi), [Meshy Free](https://help.meshy.ai/en/articles/15696428-what-is-included-on-the-free-plan), [Tripo preços](https://www.tripo3d.ai/pricing) e [Adobe Mixamo FAQ](https://helpx.adobe.com/creative-cloud/faq/mixamo-faq.html).

Antes de uma compra, publicação ou adoção, conferir novamente termos, preço, licença, release e compatibilidade. Links e notas do catálogo são pontos de partida, não selo de aprovação. O projeto mantém um registro das escolhas para que a ferramenta nova não substitua a rota por impulso.

Pesquisa-base feita em 14/10/2026 com 30 buscas no GitHub e mais de 300 repositórios triados (afirmação da versão original, sem reauditoria integral nesta revisão). Objetivo: criar um jogo 100% com IA. Estrelas abaixo são um retrato informado pela pesquisa-base, não foram recontadas nesta revisão.

## Contexto do criador

- As especificações anteriormente registradas (i5-1135G7, 8 GB, Intel Iris Xe) eram do computador da agência, não do computador de casa. Foram invalidadas e não devem orientar escolhas deste projeto.
- PC de casa: modelo, CPU, RAM, GPU e sistema operacional ainda a confirmar. Até medir, não classificar Unreal, Unity, Godot, Blender ou geração local como viáveis/inviáveis para esta máquina.
- Política: qualquer tarefa que possa exigir GPU local precisa ter alternativa em nuvem (Space, API ou GPU alugada), com custo, fila e requisitos anotados. Os rótulos PC/GPU do catálogo descrevem a classe de execução, não uma afirmação sobre o computador do criador.

## Decisões recomendadas

| Área | Escolha | Por quê |
|---|---|---|
| Engine | Godot 4.7.2 (linha 4.7) | Leve, gratuita (MIT), roda em vídeo integrado, melhores integrações com agentes de IA |
| Organização do projeto | Claude-Code-Game-Studios | 49 agentes e 74 comandos que levam do GDD ao lançamento |
| Ponte IA ↔ engine | godot-ai (MCP) | A IA cria cenas, scripts, animações e partículas direto no editor |
| Arte 3D e animação | Na nuvem | Sem GPU dedicada: Meshy/Tripo via API, Spaces do Hugging Face, Mixamo |

## Rota recomendada (nesta ordem)

1. **Ideia e documento de design (GDD).** Claude-Code-Game-Studios com `/brainstorm` e `/design-system`. Se partir de uma história: novel-to-game.
2. **Engine e conexão com a IA.** Instalar Godot 4.7.2 e uma release publicada do plugin godot-ai; somar as awesome-gamedev-agent-skills para GDScript no padrão da versão.
3. **Bíblia de arte antes dos assets.** Fixar paleta, estilo e 3 a 5 imagens de referência, reutilizadas em toda geração. Sem isso, cada personagem sai num estilo diferente.
4. **Gerar arte.** 2D: PerfectPixel (spritesheets em 8 direções), Aseprite ou Pixelorama via MCP. 3D: imagem conceito → Meshy, Tripo ou Space do TRELLIS.2 → redução de polígonos no Blender via mcp-for-blender.
5. **Rig e animação.** Humanoides: rig automático no Mixamo ou Meshy; animações do Mixamo ou Quaternius (CC0). Sob medida: texto → animação (HY-Motion no Hugging Face) ou vídeo → animação (mixamo-llm-mocap).
6. **Som, música e vozes.** Vozes com Kokoro ou MOSS-TTS-Nano (rodam em CPU). Música com ACE-Step 1.5. Efeitos com Stable Audio via agent-audio.
7. **Testar, corrigir, repetir.** O MCP roda o jogo, lê erros e tira screenshots; a IA corrige. Começar com uma fase e uma mecânica jogáveis.

## Catálogo

Legenda de execução: **PC** = roda no computador acima · **Nuvem** = precisa de API ou serviço online · **GPU** = precisa de NVIDIA 16 GB+ (usar via Space, API ou GPU alugada). ⭐ = ponto de partida.

### Estúdio de agentes
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/Donchitos/Claude-Code-Game-Studios | 26,5 mil | PC | 49 agentes (diretor criativo, programação, arte, áudio, QA), 74 comandos, 39 modelos de documento; especialistas para Godot, Unity e Unreal |
| ⭐ github.com/gamedev-skills/awesome-gamedev-agent-skills | 1,5 mil | PC | 74 skills com roteador por engine (Godot, Unity, Unreal, Phaser, three.js, Bevy, Roblox) e fluxo de direção de arte. `npx skills add gamedev-skills/awesome-gamedev-agent-skills` |
| github.com/htdt/godogen | 7,1 mil | Nuvem | Gera o jogo inteiro em Godot, Bevy ou Babylon.js, com assets (Gemini/Grok, Tripo) e vídeo de prova. Linux/macOS; no Windows, WSL |
| github.com/RandallLiuXin/GodotMaker | 554 | Nuvem | Ideia → GDD → projeto Godot jogável com testes e correção em loop |
| github.com/thedivergentai/Game-Dev-Agentic-Skills | 850 | PC | Memória de longo prazo, 99 skills de Godot 4.7, 27 modelos por gênero |
| github.com/zenstory-ai/novel-to-game | 858 | PC | Adapta história ou roteiro em design de jogo |
| github.com/tettethu/VibeGame | 269 | Nuvem | Framework multiagente que evolui o jogo sozinho |

### Engines
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/godotengine/godot | 118,5 mil | PC | Engine 2D/3D gratuita; 4.7 lançada em 2026 (HDR, AreaLight3D, nova loja de assets) |
| github.com/mrdoob/three.js | 116,4 mil | PC | 3D no navegador |
| github.com/phaserjs/phaser | 40,5 mil | PC | 2D no navegador (JS/TS) |
| github.com/bevyengine/bevy | 49 mil | PC | Rust/ECS; verificar custo de compilação e requisitos do projeto |
| github.com/raysan5/raylib | 35,2 mil | PC | Biblioteca C minimalista |
| github.com/4ian/GDevelop | 27,5 mil | PC | Sem código, IA embutida |
| github.com/BabylonJS/Babylon.js | 26,2 mil | PC | 3D web completo |
| github.com/playcanvas/engine | 17 mil | PC | 3D web WebGL/WebGPU |
| github.com/defold/defold | 6,4 mil | PC | Leve, foco em 2D e mobile |

### Pontes IA ↔ ferramenta (MCP)
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/hi-godot/godot-ai | 3 mil | PC | 46 ferramentas, 120+ operações no Godot 4.7+: cenas, scripts, sinais, UI, materiais, animação, partículas |
| github.com/Coding-Solo/godot-mcp | 6,1 mil | PC | Abre o editor, roda o projeto, captura debug |
| github.com/youichi-uda/godot-mcp-pro | 625 | PC | 162 ferramentas para Godot 4 |
| ⭐ github.com/ahujasid/mcp-for-blender | 30,8 mil | PC | Controla o Blender por linguagem natural |
| github.com/arjun988/blender-skills | 298 | PC | 94 skills de Blender |
| github.com/HoldMyBeer-gg/blenderwright | 168 | PC | MCP de Blender com 191 ferramentas |
| ⭐ github.com/willibrandon/pixel-plugin | 360 | PC | Aseprite via IA: sprites, ciclos de animação, export com JSON para Godot/Unity/Phaser (Aseprite é pago, ~US$ 20) |
| github.com/abidoo22/Pixelorama-MCP | 33 | PC | Pixelorama (gratuito), alternativa ao Aseprite |
| github.com/CoplayDev/unity-mcp | 14,9 mil | PC | Ponte mais popular para Unity |
| github.com/IvanMurzak/Unity-MCP | 4,4 mil | PC | Skills, MCP e CLI para Unity |
| github.com/Glade-tool/glade-mcp | 212 | PC | Unity e Godot num só MCP |
| github.com/chongdashu/unreal-mcp | 2,1 mil | GPU | Unreal (inviável nesta máquina) |
| github.com/Natfii/UnrealClaude | 922 | GPU | Unreal 5.7 |

### Geração 3D
| Repositório / serviço | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/img2threejs/img2threejs | 18,1 mil | PC | Reconstrói objeto de imagem como código three.js procedural; o LLM gera, sem GPU |
| ⭐ Meshy (serviço) | — | Nuvem | Texto/imagem → 3D; verificar rig/animação no plano usado. Free: 100 créditos/mês e CC BY 4.0 com atribuição em 14/10/2026; preço/limites pagos variam |
| Tripo3D (serviço) | — | Nuvem | Texto/imagem → 3D. Free: modelos públicos e uso não comercial segundo a página de preços em 14/10/2026; Pro: modelos privados e uso comercial. Revalidar antes de publicar |
| github.com/scenario-labs/skills | 998 | Nuvem | 71 skills para gerar sprites, texturas, skyboxes, 3D, áudio via Scenario (pago) |
| github.com/microsoft/TRELLIS.2 | 12 mil | GPU | Melhor imagem → 3D aberto, PBR, MIT |
| github.com/Tencent-Hunyuan/Hunyuan3D-2.1 | 4,2 mil | GPU | Imagem → 3D PBR; licença comunitária restrita |
| github.com/Tencent-Hunyuan/Hunyuan3D-2 | 15,1 mil | GPU | Versão anterior, muitos wrappers |
| github.com/Stability-AI/stable-fast-3d | 1,9 mil | GPU | Malha com UV em <1 s |
| github.com/stepfun-ai/Step1X-3D | 897 | GPU | Assets 3D texturizados |
| github.com/Bingeljell/image-to-3dlab (AssetFurnace) | 754 | GPU | Frase → personagem 3D com rig e 21 animações, otimizado para jogo |
| github.com/lightningpixel/modly | 8,2 mil | GPU | App desktop de imagem → 3D local |
| github.com/visualbruno/3DGenStudio | 721 | GPU | Pipeline 3D completo |
| github.com/MrForExample/ComfyUI-3D-Pack | 3,9 mil | GPU | Nós 3D para ComfyUI |

### Rigging
| Repositório / serviço | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ Mixamo (serviço) | — | Nuvem | Rig automático de humanoides + biblioteca de animações, livre para jogos; sem manutenção da Adobe |
| github.com/VAST-AI-Research/UniRig | 1,8 mil | GPU | Rig automático para humanos, animais, objetos |
| github.com/VAST-AI-Research/SkinTokens | 488 | GPU | Sucessor do UniRig, MIT |
| github.com/Arminando/GameRig | 346 | PC | Addon Blender de rigs para jogos |

### Animação 3D
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/Tencent-Hunyuan/HY-Motion-1.0 | 2,6 mil | GPU | Texto → animação de esqueleto, 200+ categorias; tem Space no Hugging Face |
| ⭐ github.com/squall01337/mixamo-llm-mocap | 366 | GPU | Vídeo (filmado ou gerado por IA) → animação em personagem Mixamo no Blender |
| ⭐ github.com/catprisbrey/Godot4-OpenAnimationLibraries | 342 | PC | Bibliotecas de animação prontas para Godot 4 |
| Quaternius Universal Animation Library | — | PC | Animações CC0 para Godot, Unity, Unreal |
| github.com/fyyakaxyy/AnimationGPT | 480 | GPU | Movimentos de combate a partir de texto |
| github.com/zju3dv/GVHMR | 2,1 mil | GPU | Movimento 3D a partir de vídeo |
| github.com/MaxLiu22/Motion2MixamoRig | 1,1 mil | GPU | Vídeo → personagem Mixamo |
| github.com/OpenMotionLab/MotionGPT | 2 mil | GPU | Movimento como linguagem |
| github.com/EricGuo5513/momask-codes | 1,3 mil | GPU | Texto → movimento 3D |
| github.com/antzGames/Godot_Vertex_Animation_Textures_Plugin | 129 | PC | Multidões animadas baratas no Godot |

### Arte e animação 2D
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/gykim80/perfectpixel-studio | 587 | Nuvem | Descrição → personagem → 100+ animações em 8 direções, com pós-processamento consistente (API Gemini) |
| github.com/GenielabsOpenSource/spine-animation-ai | 530 | PC | Skill para animação esquelética no Spine (editor pago) |
| github.com/EsotericSoftware/spine-runtimes | 5,3 mil | PC | Runtimes do Spine |
| github.com/Retropaint/SkelForm | 106 | PC | Editor gratuito de animação esquelética 2D |
| github.com/ianlintner/ai-pixel-art-image-generation | 22 | Nuvem | Pixel art, sprites e tilemaps |
| github.com/acatovic/ai-game-studio | 167 | Nuvem | Spritesheets 2D |
| github.com/zxc02621948-sketch/ai-sprite-align-tool | 14 | PC | Conserta spritesheets desalinhadas |
| github.com/CombinEC-R/Pixel-Perfect-Aligner | 7 | PC | Sprites de IA → pixel art alinhada (GIMP) |
| github.com/GraphiteEditor/Graphite | 27,6 mil | PC | Editor 2D gratuito |

### Áudio e voz
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| ⭐ github.com/hexgrad/kokoro | 9,3 mil | PC | TTS leve em CPU, vozes em pt-BR |
| github.com/OpenMOSS/MOSS-TTS-Nano | 4,5 mil | PC | TTS em tempo real na CPU, clonagem de voz |
| ⭐ github.com/ace-step/ACE-Step-1.5 | 13,5 mil | GPU | Música aberta (MIT), alternativa ao Suno |
| github.com/fspecii/ace-step-ui | 5 mil | GPU | Interface para ACE-Step |
| github.com/HeartMuLa/heartlib | 3,8 mil | GPU | Geração de música |
| github.com/AIEGOBOT/agent-audio | 41 | GPU | Efeitos sonoros com Stable Audio 3 via MCP |
| github.com/resemble-ai/chatterbox | 26,9 mil | GPU | TTS com emoção, MIT |
| github.com/RVC-Boss/GPT-SoVITS | 62,8 mil | GPU | Clonagem de voz com 1 minuto |
| github.com/OpenBMB/VoxCPM | 39,3 mil | GPU | TTS multilíngue, design de voz |

### Procedural e mundos
| Repositório | Estrelas | Roda | Função |
|---|---|---|---|
| github.com/mxgmn/WaveFunctionCollapse | 25,4 mil | PC | Mapas/tilemaps a partir de um exemplo |
| github.com/AlexeyBond/godot-constraint-solving | 464 | PC | WFC no Godot |
| github.com/Jaysmito101/TerraForge3D | 1,3 mil | PC | Terreno procedural |
| github.com/Tencent-Hunyuan/HunyuanWorld-1.0 | 2,9 mil | GPU | Mundos 3D a partir de texto/imagem |
| github.com/ZiYang-xie/WorldGen | 2,2 mil | GPU | Cena 3D em segundos |
| github.com/SkyworkAI/Matrix-Game | 2,4 mil | GPU | Modelo de mundo interativo (pesquisa, não usar como base) |

### Listas de referência
- ⭐ github.com/Yuan-ManX/ai-game-devtools — maior hub de ferramentas de IA para games
- github.com/ellisonleao/magictools — recursos clássicos de gamedev
- github.com/devanshutak25/3d-resources — 3.400+ recursos de 3D, VFX e games
- github.com/lappemic/awesome-ai-built-games — jogos feitos com agentes, com código
- github.com/Foruck/Awesome-Human-Motion — pesquisa em movimento humano
- github.com/dawdle-deer/awesome-learn-gamedev — aprender gamedev
- github.com/simoninithomas/awesome-ai-tools-for-game-dev — parada desde 2024

## Comparativo de engines (compatibilidade local a confirmar)

| Engine | No PC | Integração com IA | Custo | Melhor para |
|---|---|---|---|---|
| **Godot 4.7.2** (linha recomendada) | Requisito exato depende do projeto e renderer; validar no PC alvo | Ótima (godot-ai, godot-mcp) | Grátis, MIT | 2D e 3D estilizado/low-poly |
| Web: Phaser / three.js | Requisito depende da complexidade e navegador | Ótima | Grátis, MIT | Jogos casuais, itch.io |
| Unity 6 | Medir editor, importação e build na máquina | Ótima (unity-mcp) | Grátis no Personal, sujeito aos termos atuais | Mobile e 3D intermediário |
| Unreal 5 | Medir projeto mínimo na máquina antes de selecionar | Boa | Consultar termos atuais | 3D realista AAA |

## Cuidados

- **Licenças:** verificar a licença exata de cada repo e cada output. Hunyuan3D 2.x pode ter restrições por território e escala conforme a versão. Meshy Free declara CC BY 4.0 e exige crédito; Tripo Free declara uso não comercial, então não integrar em build comercial sem licença apropriada. A Adobe permite personagens e animações Mixamo em jogos comerciais; guardar arquivos baixados e conferir restrições de redistribuição independente. Preferir MIT, Apache e CC0 quando couber.
- **Malha de IA é pesada:** otimizar topologia, materiais, texturas e níveis de detalhe conforme a cena e o dispositivo; medir antes de definir orçamento de polígonos. Revisar deformação no rig e importar `.glb` de teste.
- **Estrelas enganam:** conferir último commit, issues respondidas e resultados reais no README.
- **Instaladores de uma linha** (`irm … | iex`): executam código da internet; ler antes.
- **Mixamo:** guardar localmente os personagens rigados e as animações usadas; a Adobe informa que somente o último personagem fica armazenado no serviço.
- **Escopo pequeno primeiro:** um protótipo de uma fase vale mais que um GDD enorme.
- **Preços mudam:** confirmar créditos, direitos comerciais, privacidade, exportação e preço no site oficial antes de assinar.
