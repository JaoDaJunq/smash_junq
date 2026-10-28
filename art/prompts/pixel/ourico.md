# Espeto — ouriço-cacheiro roqueiro

## Identidade e silhueta

- Ouriço-cacheiro brasileiro de corpo baixo, redondo e compacto, com cerca de 46 px de altura em uma tela lógica 64×64.
- Perfil voltado para a direita.
- Coberto por espinhos curtos, grossos e retos, creme-claro `#E9D9A6` com pontas marrom-escuras `#6B5A3A`. Os espinhos eriçam em leque nas costas e na cabeça e formam um topete pontudo de silhueta serrilhada.
- Espinhos são estruturas rígidas: nunca desenhar pelo, penugem, juba, cabelo fofo ou silhueta de leão/mico.
- Focinho grande, redondo e rosado `#E89A9A`; rosto redondo e olhos pequenos escuros.
- Cauda preênsil sem pelos, marrom.

## Roupa e acessório

- Jaqueta jeans azul, com patches visíveis vermelho e amarelo, baseada no conceito escolhido em `art/concepts/ourico/escolhido.png`.
- Calça escura e tênis.
- Guitarra vermelha compacta pendurada nas costas.
- O conceito escolhido é referência apenas para roupa e guitarra; usar a anatomia e os espinhos descritos acima.

## Estilo e paleta

- Pixel art real de 64×64, simples e legível, no nível de blocos e escala de `art/pixel/juba/parado.png` e `art/pixel/seu_capivas/parado.png`.
- Cada pixel lógico deve formar um bloco quadrado, grande e visível na ampliação; formas grandes de cor chapada, 2–3 tons por material e contorno contínuo de 1 px `#2A0F12`.
- Evitar detalhe fino, antialiasing, pixels soltos e ruído. O personagem deve ocupar só parte do quadro.
- Paleta principal: espinhos creme `#E9D9A6` e pontas `#6B5A3A`; focinho rosado `#E89A9A`; jaqueta jeans azul; patches vermelho e amarelo; calça escura; guitarra vermelha; contorno `#2A0F12`; fundo chapado `#FF00FF`.

## Folhas de sprites

- `base.png`: 1024×1024, um sprite lógico de 64×64 ampliado 16×, centrado e completo.
- `parado.png`: 1536×1024, grade 3×2 de células 512×512. As quatro primeiras células contêm o mesmo desenho de 64×64 ampliado 8×, com loop sutil de respiração (peito sobe/desce 1 px); pés na mesma linha e mesma altura em todos os quadros. Células 5 e 6 vazias.
- Fundo sólido `#FF00FF`, sem chão, cenário, efeitos, texto ou sombra projetada.
