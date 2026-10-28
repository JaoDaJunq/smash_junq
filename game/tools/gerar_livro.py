"""Gera o livro de pedidos de arte (art/prompts/pedidos/<id>/todos.md) de um personagem
novo a partir dos dados abaixo + a paleta escrita na etapa A (art/prompts/pixel/<id>.md).

Uso: python game/tools/gerar_livro.py <id> [<id> ...]

Ordem do livro: 0 base + parado (etapa A, já feita) -> lote 1 -> lote 2 -> efeitos -> interface.
Sem intermediários (_meio). Toda folha leva as regras de grade e o parágrafo LIMPEZA.
"""
import os
import sys

RAIZ = os.path.join(os.path.dirname(__file__), "..", "..")

LIMPEZA = ("LIMPEZA (obrigatório): pixel art de 64x64 DE VERDADE, simples e legível como art/pixel/juba/parado.png "
           "e art/pixel/seu_capivas/parado.png (anexe os dois). Cada pixel lógico é um bloco grande e visível (8x8 nas folhas); "
           "NÃO desenhe ilustração detalhada fina com cara de pixel. Formas grandes de cor chapada, no máximo 2-3 tons por "
           "material, contorno contínuo de 1 px sem falhas, nenhum pixel solto, sem textura de ruído. O rosto se lê de longe. "
           "O personagem NÃO enche a imagem: ocupa só a altura pedida, com folga em volta.")

def regras(altura):
    return f"""Regras desta imagem (pixel art de verdade para um jogo de luta 2D):
- Imagem 1536x1024 com grade de 3 colunas x 2 linhas. Cada célula tem 512x512 e contém UM quadro de 64x64 pixels ampliado 8x (cada pixel vira um quadrado de 8x8). Quadros em ordem da esquerda para a direita, de cima para baixo. Células que sobrarem ficam só com o fundo.
- Fundo magenta chapado #FF00FF, uma cor só, sem sombra.
- Sem anti-aliasing, sem borrado, sem degradê suave. Contorno de 1 pixel #2A0F12 em volta do personagem. Só as cores da paleta.
- Personagem de perfil olhando para a DIREITA. Quando está no chão, a base (pés) fica na mesma linha em todos os quadros, 4 pixels acima da borda de baixo da célula.
- ESCALA: mesma escala, paleta, contorno e proporção do sprite base e do parado anexados (cerca de {altura} pixels de altura em pé). A CABEÇA tem exatamente o mesmo tamanho em pixels que no parado.png em TODOS os quadros: só a pose muda. Folha com o personagem menor ou maior é reprovada pela medição automática.
- Corpo inteiro DENTRO do quadro de 64x64 com pelo menos 4 pixels de folga: poses de alcance longo (cauda, vara, língua, asa) ficam COMPACTAS; o jogo desenha o alcance extra.
- Cada quadro tem SÓ o personagem (e o que ele segura). Proibido: chão, plataforma, parede, borda ou cenário; linhas de velocidade, rastros, borrão de movimento, poeira, ondas de som, notas musicais, brilhos, confete ou auras (o jogo faz os efeitos).
- Espaço vazio generoso em volta do personagem em cada célula: nada encosta na borda da célula, e nenhum pedaço de um quadro aparece na célula vizinha.
- {LIMPEZA}
- Sem texto, números, linhas de grade ou moldura. Roupa sempre comportada (personagem para todas as idades)."""

REGRAS_FX = ("Regras de EFEITO: imagem 1536x1024, grade 3x2, cada célula 512x512 com UM quadro de 64x64 pixels ampliado 8x "
             "(cada pixel vira um quadrado de 8x8), quadros na ordem da esquerda para a direita, de cima para baixo, células que "
             "sobrarem só com fundo. Fundo magenta chapado #FF00FF (NÃO use magenta nem rosa-choque no efeito). SÓ o efeito/objeto, "
             "SEM personagem, centralizado na célula, com folga; nada atravessa a célula vizinha. Pixel art sem anti-aliasing e sem "
             "brilho suave/degradê: blocos chapados de 2-3 tons, contorno 1 px #2A0F12 nas peças maiores (partículas pequenas podem "
             "ficar sem contorno). Mesmo estilo de pixel do jogo (anexe art/pixel/juba/fx_folhas.png). Sem texto, letras ou números.")

# Folhas comuns: (arquivo, quadros, animação, quadros). {cauda} etc. vêm do personagem.
COMUNS_L1 = [
    ("andar", 6, "Andar (loop)", "1) a 6) passos no jeito do personagem ({andar})"),
    ("correr", 6, "Correr (loop)", "1) contato, corpo inclinado · 2) corpo baixo · 3) impulso, perna de trás esticada · 4) no ar · 5) contato da outra perna · 6) impulso"),
    ("pulo", 6, "Pulo, queda e pouso", "1) agachado preparando · 2) impulso saindo do chão · 3) subindo, pernas encolhidas · 4) topo · 5) caindo, braços para cima · 6) pouso agachado"),
    ("transicoes_a", 6, "Virar e arrancar (duas animações na mesma folha)", "VIRAR: 1) começando a girar o tronco · 2) de frente para a câmera no meio do giro · 3) de perfil para a direita de novo. ARRANCAR: 4) joga o peso para trás · 5) explode para a frente, corpo baixo · 6) primeira passada da corrida"),
    ("transicoes_b", 6, "Frear e pouso (duas animações na mesma folha)", "FREAR: 1) corpo jogado para trás, pés deslizando · 2) quase parando · 3) voltando à guarda. POUSO: 4) tocando o chão, joelhos dobrando · 5) agachado absorvendo · 6) levantando para a guarda"),
    ("defesa_esquiva", 6, "Escudo e esquiva", "ESCUDO: 1) {escudo} · 2) mesma pose, olhos apertados. ESQUIVA: 3) se jogando de lado · 4) rolando encolhido · 5) saindo do rolamento · 6) levantando na guarda"),
    ("dor", 4, "Levando golpe", "1) tranco para trás, olhos apertados · 2) corpo dobrado · 3) lançado de costas no ar · 4) lançado girando de cabeça para baixo"),
]
COMUNS_L2 = [
    ("tonto", 4, "Tonto depois do escudo quebrar (loop)", "1) cambaleando, olhos em espiral · 2) inclinado para um lado · 3) inclinado para o outro · 4) volta ao meio"),
    ("agarrar", 6, "Agarrão e arremesso", "1) estica as mãos à frente · 2) segurando algo invisível na altura do peito · 3) puxando para trás · 4) girando o corpo · 5) arremessando à frente · 6) guarda"),
    ("pendurado", 2, "Pendurado na borda por UMA mão", "1) pendurado por uma mão no alto do quadro (à direita), corpo pendendo · 2) balançando. Sem desenhar a borda"),
]
ORDEM_L1_GOLPES = ["jab", "jab_b", "jab_c", "golpe_frente"]
ORDEM_L2_GOLPES = ["golpe_cima", "golpe_baixo", "aereo_neutro", "aereo_frente", "aereo_tras", "aereo_cima", "aereo_baixo",
                   "especial_neutro", "especial_lado", "especial_cima", "especial_baixo"]
QUADROS = {"jab": 3, "jab_b": 3, "jab_c": 4, "golpe_frente": 5, "golpe_cima": 5, "golpe_baixo": 5, "aereo_neutro": 5,
           "aereo_frente": 5, "aereo_tras": 5, "aereo_cima": 5, "aereo_baixo": 5, "especial_neutro": 6,
           "especial_lado": 6, "especial_cima": 6, "especial_baixo": 6, "descanso": 4, "vitoria": 3}

P = {
    "jacare": dict(
        nome="Papo-Amarelo", altura=58,
        desc="jacaré-de-papo-amarelo humanizado, PESCADOR de rio grandão e pesado (concept escolhido anexado): focinho LARGO e curto, papo AMARELO bem visível, couro escuro esverdeado com placas, cauda grossa; chapéu de pescador, colete de bolsos, vara de pesca curta",
        andar="passos pesados e lentos, cauda arrastando, vara apoiada no ombro",
        escudo="encolhido atrás dos braços cruzados, cabeça baixa protegida pelas placas",
        golpes={
            "jab": ("Tapa de pata", "1) pata recolhida · 2) tapa à frente · 3) volta"),
            "jab_b": ("Outro tapa", "1) outra pata recolhida · 2) tapa · 3) volta"),
            "jab_c": ("Mordida", "1) boca fechando para trás · 2) avançando a cabeça · 3) impacto: bocarra aberta à frente, dentes à mostra · 4) volta"),
            "golpe_frente": ("Varada", "1) vara puxada para trás por cima do ombro · 2) girando · 3) impacto: vara batendo à frente na horizontal (vara curta, dentro do quadro) · 4) voltando · 5) guarda"),
            "golpe_cima": ("Mordida para cima", "1) agacha · 2) cabeça subindo · 3) impacto: boca aberta para cima · 4) fechando · 5) guarda"),
            "golpe_baixo": ("Rabada rasteira", "1) agacha virando · 2) cauda varrendo · 3) impacto: cauda grossa rente ao chão à frente · 4) recolhendo · 5) levanta"),
            "aereo_neutro": ("Rolamento", "1) encolhido · 2) girando de lado · 3) impacto: corpo enrolado de costas, cauda em volta · 4) terminando · 5) encolhido"),
            "aereo_frente": ("Mordida no ar", "1) cabeça para trás · 2) vindo · 3) impacto: bocarra aberta à frente · 4) fechando · 5) recolhido"),
            "aereo_tras": ("Rabada para trás", "1) olhando para trás · 2) cauda recolhida · 3) impacto: cauda batendo para TRÁS (esquerda) · 4) voltando · 5) recolhido"),
            "aereo_cima": ("Bocejo gigante", "1) cabeça baixa · 2) abrindo a boca para cima · 3) impacto: boca enorme aberta para o alto · 4) fechando · 5) recolhido"),
            "aereo_baixo": ("Barrigada", "1) encolhido · 2) virando de barriga para baixo · 3) impacto: barriga amarela para baixo, braços e pernas abertos · 4) quicando · 5) recolhido"),
            "especial_neutro": ("Fisgada (lança o anzol)", "1) vara para trás · 2) lançando · 3) impacto: vara apontada à frente, braço esticado (a linha e o anzol NÃO aparecem, o jogo desenha) · 4) segurando · 5) puxando a vara para trás com força · 6) guarda"),
            "especial_lado": ("Rede de pesca", "1) rede dobrada nas mãos · 2) girando o corpo · 3) impacto: arremessando à frente, braços esticados, mãos vazias (a rede NÃO aparece) · 4) acompanhando · 5) voltando · 6) guarda"),
            "especial_cima": ("Anzol na borda (recuperação)", "1) no ar, vara para trás · 2) lançando para cima e para a frente · 3) impacto: vara apontada para o alto-frente · 4) pendurado na linha, puxando · 5) subindo puxado · 6) chegando"),
            "especial_baixo": ("Rolamento da morte", "1) bote: boca aberta à frente · 2) mordendo algo invisível · 3) começando a girar de lado · 4) impacto: deitado girando como rolo · 5) soltando · 6) levanta"),
            "descanso": ("Cochilo de pescador (loop)", "1) sentado com a vara apoiada, olhos fechados · 2) cabeça caindo · 3) acorda de leve · 4) volta"),
            "vitoria": ("Comemoração (3 poses)", "1) levantando um peixe enorme com as duas mãos · 2) mostrando o tamanho com os braços abertos · 3) pose final: sorriso cheio de dentes, polegar para cima"),
        },
        extras=[],
        fx=[
            ("anzol", 2, "Objeto: ANZOL de pesca prateado #C8CCD2/#8A9098 com isca vermelha #D7262E pequena, de uns 10 pixels; 1) anzol parado · 2) anzol balançando. A LINHA não é desenhada (o jogo faz)."),
            ("rede", 4, "Projétil: REDE DE PESCA bege #D8C49A com nós escuros #8A6A2E em losangos, voando aberta e depois prendendo: 1) rede embolada (12 px) · 2) abrindo (24 px) · 3) bem aberta (36 px) · 4) fechada em volta de algo (forma de saco, 30 px)."),
            ("fx_splash_rio", 4, "Efeito: respingo de água de rio azul #5AB0E8/#2D6FC4 com espuma branca, saindo do chão para cima, para o rolamento da morte: 1) pequeno · 2) grande · 3) gotas caindo · 4) restos."),
        ],
        retrato="Virado em 3/4 olhando para a direita, sorriso confiante cheio de dentes, chapéu de pescador",
        splash="Pose: segurando um peixe enorme numa mão e a vara na outra, sorriso cheio de dentes, cauda grossa no chão",
    ),
    "ourico": dict(
        nome="Espeto", altura=46,
        desc="ouriço-cacheiro humanizado, ROQUEIRO de garagem baixinho e invocado (concept escolhido anexado): espinhos CURTOS e grossos cor creme cobrindo costas e cabeça formando topete, focinho rosado redondo, olhos pequenos, cauda preênsil; jaqueta jeans com patches, guitarra vermelha pendurada nas costas",
        andar="passo marrento balançando a cabeça, guitarra nas costas",
        escudo="encolhido virando uma bola de espinhos",
        golpes={
            "jab": ("Soco", "1) punho recolhido · 2) soco à frente · 3) volta"),
            "jab_b": ("Outro soco", "1) outro punho recolhido · 2) soco · 3) volta"),
            "jab_c": ("Cabeçada de espinhos", "1) cabeça para trás · 2) avançando · 3) impacto: cabeçada à frente, topete de espinhos na frente · 4) volta"),
            "golpe_frente": ("Guitarrada", "1) tira a guitarra das costas · 2) erguendo pelo braço da guitarra · 3) impacto: bate com o corpo da guitarra à frente · 4) voltando · 5) guarda"),
            "golpe_cima": ("Headbang para cima", "1) cabeça baixa · 2) jogando a cabeça · 3) impacto: espinhos da cabeça apontados para cima, olhos fechados de rock · 4) descendo · 5) guarda"),
            "golpe_baixo": ("Rasteira de cauda", "1) agacha · 2) cauda varrendo · 3) impacto: cauda rente ao chão à frente · 4) recolhendo · 5) levanta"),
            "aereo_neutro": ("Bola de espinhos", "1) encolhendo · 2) virando bola · 3) impacto: bola de espinhos fechada · 4) abrindo · 5) encolhido"),
            "aereo_frente": ("Guitarrada no ar", "1) guitarra para trás · 2) vindo · 3) impacto: guitarra à frente · 4) voltando · 5) recolhido"),
            "aereo_tras": ("Costas de espinhos", "1) olhando para trás · 2) virando as costas · 3) impacto: costas espinhentas para TRÁS (esquerda) · 4) voltando · 5) recolhido"),
            "aereo_cima": ("Headbang no ar", "1) cabeça baixa · 2) subindo · 3) impacto: espinhos para cima · 4) descendo · 5) recolhido"),
            "aereo_baixo": ("Sentada espinhenta", "1) encolhido · 2) virando de bunda para baixo · 3) impacto: caindo sentado, espinhos para baixo · 4) quicando · 5) recolhido"),
            "especial_neutro": ("Power chord", "1) guitarra na posição de tocar · 2) mão erguida · 3) impacto: palhetada forte, corpo jogado para trás, espinhos eriçados (os espinhos voando NÃO aparecem) · 4) segurando o acorde · 5) relaxando · 6) guarda"),
            "especial_lado": ("Stage dive", "1) correndo · 2) pulando de costas, braços abertos · 3) impacto: no ar de costas, espinhos à frente · 4) virando bola · 5) bola rolando · 6) levanta"),
            "especial_cima": ("Microfonia (recuperação)", "1) segura a guitarra apontada para baixo · 2) tremendo · 3) impacto: impulsionado para cima, guitarra para baixo, espinhos eriçados · 4) subindo · 5) topo · 6) abrindo braços"),
            "especial_baixo": ("Arrepiar", "1) encolhendo os ombros · 2) espinhos levantando · 3) impacto: TODOS os espinhos eriçados e maiores, cara brava · 4) mantendo · 5) baixando · 6) guarda"),
            "descanso": ("Afinando a guitarra (loop)", "1) sentado com a guitarra no colo · 2) mexendo na tarraxa · 3) ouvindo de olhos fechados · 4) volta"),
            "vitoria": ("Comemoração (3 poses)", "1) solo de guitarra de joelhos · 2) guitarra erguida acima da cabeça · 3) pose final: chifrinho de rock com a mão, língua de fora"),
        },
        extras=[],
        fx=[
            ("espinho", 2, "Projétil: um ESPINHO creme #E9D9A6 com ponta escura #6B5A3A, reto, de uns 12 pixels de comprimento, apontado para a DIREITA: 1) espinho · 2) espinho levemente girado."),
            ("fx_power_chord", 4, "Efeito: onda de acorde de guitarra em arcos vermelhos #D7262E e amarelos #F2C230 saindo para a DIREITA, sem notas musicais: 1) arco pequeno · 2) dois arcos · 3) três arcos grandes · 4) restos."),
            ("fx_arrepio", 4, "Efeito: estrelinhas de dor brancas e amarelas #F2C230 em volta de um ponto (quem bateu nos espinhos): 1) pequena · 2) estoura · 3) grande · 4) some."),
        ],
        retrato="Virado em 3/4 olhando para a direita, cara de invocado com sorriso de canto, topete de espinhos",
        splash="Pose: tocando um acorde de pé com a guitarra vermelha, espinhos eriçados, uma perna para a frente",
    ),
    "tamandua": dict(
        nome="Bandeira", altura=56,
        desc="tamanduá-bandeira humanizado, DEDETIZADOR calmo e profissional (concept escolhido anexado): focinho MUITO longo e fino em tubo, faixa preta diagonal com borda branca no ombro, cauda enorme e peluda como bandeira (compacta atrás do corpo), garras grandes; macacão de dedetizador e bomba de inseticida nas costas",
        andar="passo calmo e pesado, garras dobradas para dentro, cauda balançando atrás",
        escudo="encolhido atrás da cauda enorme dobrada para a frente como um escudo de pelos",
        golpes={
            "jab": ("Garrada", "1) garra recolhida · 2) garrada à frente · 3) volta"),
            "jab_b": ("Outra garrada", "1) outra garra recolhida · 2) garrada · 3) volta"),
            "jab_c": ("Focinhada", "1) cabeça para trás · 2) avançando · 3) impacto: focinho comprido esticado à frente · 4) volta"),
            "golpe_frente": ("Jato de mangueira", "1) puxa o bico da bomba · 2) aponta à frente · 3) impacto: bico apontado à frente, corpo firme (o jato NÃO aparece, o jogo desenha) · 4) segurando · 5) guarda"),
            "golpe_cima": ("Cauda-bandeira para cima", "1) vira de lado · 2) cauda subindo · 3) impacto: cauda aberta abanando para o alto · 4) descendo · 5) guarda"),
            "golpe_baixo": ("Focinho varrendo", "1) agacha · 2) focinho baixando · 3) impacto: focinho rente ao chão à frente · 4) recolhendo · 5) levanta"),
            "aereo_neutro": ("Giro de cauda", "1) encolhido · 2) girando · 3) impacto: de lado com a cauda aberta em volta · 4) terminando · 5) recolhido"),
            "aereo_frente": ("Garras no ar", "1) garras para trás · 2) vindo · 3) impacto: as duas garras à frente · 4) voltando · 5) recolhido"),
            "aereo_tras": ("Cauda para trás", "1) olhando para trás · 2) cauda recolhida · 3) impacto: cauda abanando para TRÁS (esquerda) · 4) voltando · 5) recolhido"),
            "aereo_cima": ("Focinho para cima", "1) cabeça baixa · 2) subindo · 3) impacto: focinho apontado para o alto · 4) descendo · 5) recolhido"),
            "aereo_baixo": ("Pisão de botina", "1) encolhido · 2) perna descendo · 3) impacto: botina pisando para baixo · 4) quicando · 5) recolhido"),
            "especial_neutro": ("Nuvem de veneno", "1) pega o bico da bomba · 2) bombeando · 3) impacto: borrifando à frente, bico apontado (a nuvem NÃO aparece) · 4) segurando · 5) baixando · 6) guarda"),
            "especial_lado": ("Língua", "1) focinho recolhido · 2) boca abrindo · 3) impacto: focinho esticado à frente, bochechas cheias (a língua NÃO aparece, o jogo desenha) · 4) puxando · 5) mastigando satisfeito · 6) guarda"),
            "especial_cima": ("Escalada de garra (recuperação)", "1) no ar, garras erguidas · 2) cravando as garras para cima · 3) impacto: braços esticados para o alto · 4) puxando o corpo · 5) subindo · 6) chegando"),
            "especial_baixo": ("Abraço de tamanduá", "1) braços abertos · 2) avançando devagar · 3) impacto: abraço fechado em algo invisível · 4) apertando com força · 5) soltando · 6) guarda"),
            "descanso": ("Lambendo formigas (loop)", "1) agachado ao lado de um formigueiro baixinho · 2) focinho no formigueiro · 3) mastigando feliz · 4) volta"),
            "vitoria": ("Comemoração (3 poses)", "1) borrifando a área com a bomba, satisfeito · 2) conferindo uma prancheta · 3) pose final: polegar para cima, cauda aberta atrás"),
        },
        extras=[],
        fx=[
            ("fx_nuvem_veneno", 4, "Efeito: nuvem de veneno verde-amarelada #A8C83A/#6E8A1E com bolinhas, que fica parada no lugar (loop): 1) pequena · 2) cheia · 3) cheia mexendo · 4) desmanchando."),
            ("fx_jato", 4, "Efeito: jato de spray de inseticida branco-esverdeado #D8F0C0/#8AB870 saindo para a DIREITA: 1) curto · 2) médio · 3) longo · 4) gotas finais."),
        ],
        retrato="Virado em 3/4 olhando para a direita, olhar calmo de profissional, focinho comprido, boné/capacete de dedetizador",
        splash="Pose: segurando o bico da bomba de inseticida apontado para cima, cauda enorme aberta atrás, garras à mostra",
    ),
    "beija_flor": dict(
        nome="Beija", altura=40,
        desc="beija-flor humanizado, SKATISTA elétrico e pequeno (concept escolhido anexado): bico fino e longo, penas verdes com garganta brilhante, asas pequenas; capacete/boné, roupa de skatista e skate como no concept",
        andar="saltitando inquieto, asas tremendo, skate debaixo do braço",
        escudo="encolhido atrás das asas fechadas na frente do corpo",
        golpes={
            "jab": ("Bicada", "1) cabeça recolhida · 2) bicada à frente · 3) volta"),
            "jab_b": ("Outra bicada", "1) recolhe · 2) bicada · 3) volta"),
            "jab_c": ("Rajada de bicadas", "1) recolhendo · 2) bicadas rápidas (bico em 2 posições borradas) · 3) impacto: bicada final à frente · 4) volta"),
            "golpe_frente": ("Chute de skate", "1) skate na mão para trás · 2) girando · 3) impacto: batendo com o shape do skate à frente · 4) voltando · 5) guarda"),
            "golpe_cima": ("Ollie para cima", "1) em cima do skate agachado · 2) pulando · 3) impacto: no alto com o skate erguido acima da cabeça · 4) descendo · 5) guarda"),
            "golpe_baixo": ("Rasteira de rodinha", "1) agacha · 2) skate deslizando · 3) impacto: skate rente ao chão à frente · 4) puxando · 5) levanta"),
            "aereo_neutro": ("Giro com asas", "1) asas fechadas · 2) girando · 3) impacto: asas abertas girando · 4) terminando · 5) recolhido"),
            "aereo_frente": ("Bicada mergulho", "1) bico para trás · 2) mergulhando · 3) impacto: bico apontado à frente-baixo, corpo esticado · 4) voltando · 5) recolhido"),
            "aereo_tras": ("Asa para trás", "1) olhando para trás · 2) asa recolhida · 3) impacto: asa batendo para TRÁS (esquerda) · 4) voltando · 5) recolhido"),
            "aereo_cima": ("Kickflip para cima", "1) skate nos pés · 2) chutando · 3) impacto: skate girando acima da cabeça · 4) pegando · 5) recolhido"),
            "aereo_baixo": ("Cravada de skate", "1) skate nos pés · 2) virando · 3) impacto: pisando para baixo com o skate debaixo dos pés · 4) quicando · 5) recolhido"),
            "especial_neutro": ("Néctar", "1) parado no ar batendo asa · 2) bico à frente · 3) impacto: sugando, olhos fechados de prazer · 4) sugando · 5) satisfeito · 6) guarda"),
            "especial_lado": ("Manobra (skate segue sozinho)", "1) subindo no skate · 2) remando · 3) impacto: deslizando em cima do skate · 4) pulando do skate (o skate solto NÃO aparece) · 5) no ar sem skate · 6) guarda"),
            "especial_cima": ("Voo de beija-flor (recuperação)", "1) asas abertas · 2) asas borradas de tão rápidas · 3) impacto: corpo esticado voando · 4) voando · 5) freando · 6) parado no ar"),
            "especial_baixo": ("Grind", "1) em cima do skate · 2) virando de lado · 3) impacto: deslizando de lado com o skate (grind), braços abertos · 4) deslizando · 5) pulando fora · 6) guarda"),
            "descanso": ("Sentado no skate (loop)", "1) sentado no skate · 2) balançando os pés · 3) olhando o celular imaginário · 4) volta"),
            "vitoria": ("Comemoração (3 poses)", "1) manobra no ar com o skate · 2) pousando no skate · 3) pose final: skate em pé ao lado, sinal de 'joia', piscando"),
        },
        extras=[],
        fx=[
            ("skate", 2, "Objeto: o SKATE do Beija (shape colorido como no concept, rodinhas amarelas), visto de lado, uns 20 pixels: 1) skate · 2) skate com rodinhas girando."),
            ("fx_nectar", 4, "Efeito: brilhinhos de néctar dourado #F2C230 e rosa #F28AB8 subindo (cura): 1) poucos · 2) mais · 3) cheio · 4) sumindo."),
        ],
        retrato="Virado em 3/4 olhando para a direita, sorriso elétrico, boné/capacete de skatista, bico fino",
        splash="Pose: em pé em cima do skate fazendo pose, asas abertas, sinal de 'joia'",
    ),
    "macaco_prego": dict(
        nome="Preguinho", altura=46,
        desc="macaco-prego humanizado, FAZ-TUDO malandro (concept escolhido anexado): topete de pelo escuro no alto da cabeça, rosto claro, cauda; cinto de ferramentas, roupa como no concept, MARTELO na mão",
        andar="passo malandro balançando o martelo, cauda enrolada",
        escudo="encolhido atrás da caixa de ferramentas erguida",
        golpes={
            "jab": ("Soco", "1) punho recolhido · 2) soco à frente · 3) volta"),
            "jab_b": ("Outro soco", "1) outro punho · 2) soco · 3) volta"),
            "jab_c": ("Martelada leve", "1) martelo para trás · 2) vindo · 3) impacto: martelo batendo à frente · 4) volta"),
            "golpe_frente": ("Martelada forte", "1) martelo erguido atrás da cabeça · 2) descendo · 3) impacto: martelo batendo à frente com as duas mãos · 4) voltando · 5) guarda"),
            "golpe_cima": ("Martelo para cima", "1) agacha · 2) erguendo · 3) impacto: martelo para o alto · 4) descendo · 5) guarda"),
            "golpe_baixo": ("Martelada no chão", "1) agacha · 2) martelo descendo · 3) impacto: martelo batendo no chão à frente · 4) recolhendo · 5) levanta"),
            "aereo_neutro": ("Giro na cauda", "1) encolhido · 2) girando · 3) impacto: girando com a cauda aberta e martelo para fora · 4) terminando · 5) recolhido"),
            "aereo_frente": ("Martelada no ar", "1) martelo para trás · 2) vindo · 3) impacto: martelo à frente · 4) voltando · 5) recolhido"),
            "aereo_tras": ("Chute para trás", "1) olhando para trás · 2) perna recolhida · 3) impacto: chute para TRÁS (esquerda) · 4) voltando · 5) recolhido"),
            "aereo_cima": ("Chave para cima", "1) chave inglesa na mão · 2) subindo · 3) impacto: chave inglesa para o alto · 4) descendo · 5) recolhido"),
            "aereo_baixo": ("Martelada para baixo", "1) martelo erguido · 2) virando · 3) impacto: martelo para baixo · 4) quicando · 5) recolhido"),
            "especial_neutro": ("Troca de ferramenta", "1) mão no cinto · 2) puxando · 3) impacto: erguendo a ferramenta nova orgulhoso (mão vazia fechada, o jogo desenha a ferramenta) · 4) girando · 5) conferindo · 6) guarda"),
            "especial_lado": ("Coco quebrado", "1) coquinho na mão para trás · 2) girando o braço · 3) impacto: arremessando em arco, braço esticado, mão vazia (o coco NÃO aparece) · 4) acompanhando · 5) voltando · 6) guarda"),
            "especial_cima": ("Escada dobrável (recuperação)", "1) no ar, mãos para cima · 2) abrindo algo · 3) impacto: subindo, uma mão e um pé erguidos (a escada NÃO aparece) · 4) subindo · 5) subindo · 6) chegando"),
            "especial_baixo": ("Pregar", "1) agacha com o prego · 2) martelo erguido · 3) impacto: martelando no chão · 4) segunda martelada · 5) levantando · 6) guarda"),
            "descanso": ("Consertando (loop)", "1) sentado mexendo na caixa de ferramentas · 2) apertando um parafuso · 3) limpando a testa · 4) volta"),
            "vitoria": ("Comemoração (3 poses)", "1) girando o martelo · 2) entregando uma nota fiscal enorme · 3) pose final: martelo no ombro, sorriso malandro"),
        },
        extras=[],
        fx=[
            ("coquinho", 2, "Projétil: COQUINHO marrom #8A5A2E com fibras #C8945A, redondo, uns 12 pixels: 1) inteiro · 2) quebrado em 2 metades."),
            ("prego", 2, "Objeto: PREGO prateado #C8CCD2/#8A9098 cravado no chão, uns 8 pixels: 1) prego · 2) prego torto."),
            ("escada", 2, "Objeto: ESCADA DOBRÁVEL de alumínio #C8CCD2 com degraus, aberta em pé, uns 50 pixels de altura: 1) aberta · 2) balançando."),
            ("ferramentas", 3, "Objetos: as 3 FERRAMENTAS do Preguinho, uma por quadro, cada uma uns 16 pixels: 1) martelo · 2) chave inglesa · 3) furadeira amarela."),
        ],
        retrato="Virado em 3/4 olhando para a direita, sorriso malandro, topete escuro, lápis atrás da orelha",
        splash="Pose: martelo apoiado no ombro, outra mão no cinto de ferramentas, cauda enrolada, sorriso de quem vai cobrar caro",
    ),
    "mourisco": dict(
        nome="Mourisco", altura=50,
        desc="gato-mourisco (jaguarundi) humanizado, JOGADOR DE VÔLEI DE PRAIA animado (concept escolhido anexado): corpo comprido e baixo, cabeça pequena e achatada, orelhas curtas e redondas, pelo LISO sem pintas, cauda longa; uniforme de vôlei de praia comportado, faixa na testa",
        andar="passo atlético na ponta dos pés, braços soltos",
        escudo="braços cruzados à frente do rosto como bloqueio de vôlei",
        golpes={
            "jab": ("Tapa", "1) mão recolhida · 2) tapa à frente · 3) volta"),
            "jab_b": ("Outro tapa", "1) outra mão · 2) tapa · 3) volta"),
            "jab_c": ("Manchete", "1) braços juntos baixos · 2) subindo · 3) impacto: manchete, braços unidos esticados à frente · 4) volta"),
            "golpe_frente": ("Cortada no chão", "1) braço armado atrás da cabeça · 2) vindo · 3) impacto: cortada, mão batendo à frente com força · 4) voltando · 5) guarda"),
            "golpe_cima": ("Levantamento", "1) agacha, mãos acima da testa · 2) subindo · 3) impacto: toque de levantamento, mãos para o alto · 4) descendo · 5) guarda"),
            "golpe_baixo": ("Peixinho rasteiro", "1) agacha · 2) mergulhando · 3) impacto: deitado esticado rente ao chão, braços à frente · 4) recolhendo · 5) levanta"),
            "aereo_neutro": ("Giro de bloqueio", "1) encolhido · 2) girando · 3) impacto: girando com braços abertos · 4) terminando · 5) recolhido"),
            "aereo_frente": ("Cortada no ar", "1) braço armado atrás · 2) vindo · 3) impacto: cortada à frente · 4) voltando · 5) recolhido"),
            "aereo_tras": ("Chute de bicicleta", "1) de costas · 2) perna subindo · 3) impacto: chute de bicicleta para TRÁS (esquerda) · 4) voltando · 5) recolhido"),
            "aereo_cima": ("Bloqueio para cima", "1) braços baixos · 2) subindo · 3) impacto: bloqueio, os dois braços esticados para o alto · 4) descendo · 5) recolhido"),
            "aereo_baixo": ("Cravada", "1) braço armado alto · 2) vindo · 3) impacto: mão batendo para BAIXO · 4) quicando · 5) recolhido"),
            "especial_neutro": ("Saque", "1) segurando a bola (mão vazia em concha, a bola NÃO aparece) · 2) jogando para cima · 3) impacto: braço armado olhando para cima · 4) cortando · 5) acompanhando · 6) guarda"),
            "especial_lado": ("Manchete refletora", "1) braços juntos · 2) posicionando · 3) impacto: manchete forte à frente, corpo firme · 4) segurando · 5) voltando · 6) guarda"),
            "especial_cima": ("Levantada e cortada (recuperação)", "1) agachado · 2) saltando · 3) impacto: no alto com o braço armado · 4) cortada para baixo · 5) caindo · 6) recolhido"),
            "especial_baixo": ("Peixinho", "1) correndo · 2) mergulhando · 3) impacto: rasante esticado, braços à frente · 4) deslizando na areia · 5) levantando · 6) guarda"),
            "descanso": ("Bola no dedo (loop)", "1) em pé girando a bola no dedo · 2) girando · 3) olhando a bola · 4) volta"),
            "vitoria": ("Comemoração (3 poses)", "1) gritando com o punho para o alto · 2) pulando · 3) pose final: bola debaixo do braço, polegar para cima"),
        },
        extras=[],
        fx=[
            ("bola_volei", 2, "Objeto: BOLA DE VÔLEI de praia branca #F4F1E6 com faixas azul #2D6FC4 e amarela #F2C230, redonda, uns 12 pixels: 1) bola · 2) bola girada."),
            ("fx_areia_mergulho", 4, "Efeito: nuvem de areia clara #E8D2A0/#C8A86A saindo do chão para os lados (peixinho): 1) pequena · 2) grande · 3) grãos caindo · 4) restos."),
        ],
        retrato="Virado em 3/4 olhando para a direita, sorriso confiante gritando 'vai!', faixa na testa, orelhas curtas",
        splash="Pose: saltando para a cortada com a bola acima da mão, cauda longa atrás",
    ),
}

def paleta(cid):
    p = os.path.join(RAIZ, "art", "prompts", "pixel", f"{cid}.md")
    if not os.path.exists(p):
        return "Paleta: a mesma do base.png e do parado.png aprovados (use só essas cores)."
    return "Paleta (a mesma do base.png e do parado.png aprovados; use só estas cores):\n" + open(p, encoding="utf-8").read().strip()

def folha(d, cid, arq, n, anim, quadros, pal):
    q = quadros.format(**d)
    return (f"### `{arq}.png` ({n} quadros)\n\n```text\nFolha de animação do {d['nome']}: {d['desc']}, {n} quadros.\n"
            f"Animação: {anim}\nQuadros:\n{q}\n\n{regras(d['altura'])}\n\n{pal}\n```\n")

def livro(cid):
    d = P[cid]
    pal = paleta(cid)
    out = [f"# {d['nome']} · todos os pedidos (rodada 11)\n",
           f"Concept escolhido: `art/concepts/{cid}/escolhido.png`. Ficha: `design/proposta-rodada11.md`. Tudo em `art/pixel/{cid}/` (interface em `art/ui/`).\n",
           "**Ordem:** 0 base + parado (feito na etapa A) → 1 lote 1 → 2 lote 2 → 3 efeitos → 4 interface. Sem intermediários (_meio).\n",
           f"Anexe em todo pedido: `art/concepts/{cid}/escolhido.png`, `art/pixel/{cid}/base.png`, `art/pixel/{cid}/parado.png`, `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png` (escala e limpeza).\n",
           "## Lote 1\n"]
    for arq, n, anim, q in COMUNS_L1:
        out.append(folha(d, cid, arq, n, anim, q, pal))
    for g in ORDEM_L1_GOLPES:
        anim, q = d["golpes"][g]
        out.append(folha(d, cid, g, QUADROS[g], anim, q, pal))
    out.append("## Lote 2\n")
    for arq, n, anim, q in COMUNS_L2:
        out.append(folha(d, cid, arq, n, anim, q, pal))
    for g in ORDEM_L2_GOLPES + ["descanso", "vitoria"]:
        anim, q = d["golpes"][g]
        out.append(folha(d, cid, g, QUADROS[g], anim, q, pal))
    for arq, n, anim, q in d["extras"]:
        out.append(folha(d, cid, arq, n, anim, q, pal))
    out.append("## Efeitos (folhas separadas, sem o personagem)\n")
    for arq, n, txt in d["fx"]:
        out.append(f"### `{arq}.png` ({n} quadros)\n\n```text\n{txt} {n} quadros.\n\n{REGRAS_FX}\n```\n")
    out.append("## Interface (`art/ui/`)\n")
    out.append(f"### `retrato_{cid}.png`\n\n```text\nRetrato em pixel art (busto) do {d['nome']}: {d['desc']}. {d['retrato']}. "
               "Imagem 1024x1024, fundo magenta #FF00FF, busto ocupando o quadro, cortado reto embaixo. Pixel art de 128x128 ampliado 8x, "
               "contorno vinho-escuro, cel shading em 2 tons, sem anti-aliasing, sem texto. Mesmo estilo de art/ui/retrato_juba.png.\n```\n")
    out.append(f"### `apresentacao_{cid}.png`\n\n```text\nArte de apresentação (splash art cartoon de jogo de luta) do {d['nome']}: {d['desc']}, "
               f"IGUAL ao concept anexado. {d['splash']}. Virado em 3/4 para a DIREITA, corpo inteiro. Imagem 1024x1536, fundo magenta chapado #FF00FF, "
               "contorno vinho-escuro grosso, cel shading em 2-3 tons, bordas nítidas, sem sombra no chão, sem efeitos, sem texto. "
               "Mesmo estilo de art/ui/apresentacao_juba.png.\n```\n")
    dst = os.path.join(RAIZ, "art", "prompts", "pedidos", cid)
    os.makedirs(dst, exist_ok=True)
    open(os.path.join(dst, "todos.md"), "w", encoding="utf-8", newline="\n").write("\n".join(out))
    n = len(COMUNS_L1) + len(ORDEM_L1_GOLPES) + len(COMUNS_L2) + len(ORDEM_L2_GOLPES) + 2 + len(d["extras"]) + len(d["fx"]) + 2
    print(f"{cid}: {n} imagens -> art/prompts/pedidos/{cid}/todos.md")

if __name__ == "__main__":
    for c in sys.argv[1:]:
        livro(c)
