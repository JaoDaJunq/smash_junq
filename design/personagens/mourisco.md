# Mourisco · ficha

> Concept escolhido em 28/10/2026: **1 · vôlei de praia** (`art/concepts/mourisco/escolhido.png`). Kit da rodada 11 (`design/proposta-rodada11.md`), programado em `game/scripts/characters/mourisco.gd` e `bola_volei.gd`.

| | |
|---|---|
| **id** (pasta) | `mourisco` |
| **Bicho** | gato-mourisco (jaguarundi), felino de corpo comprido, pelo liso e cauda longa |
| **Grupo · Tipo** | Felinos · **Versátil** |
| **Profissão / papel** | Jogador de **vôlei de praia**: bom de grupo, comemora tudo gritando |
| **Personalidade** | Atleta, animado, gritão. A bola é o personagem |
| **Acessório de assinatura** | **Bola de vôlei** (fica desenhada na mão dele), faixa verde na cabeça, regata amarela e short verde |
| **Silhueta** | Corpo comprido e baixo, cauda grossa e longa para trás, bola na mão da frente |
| **Cores** | pelo `#80563F` · regata `#F1B914` · short e faixa `#187638` · contorno vinho `#2a0f12` |
| **Altura no sprite** | ~50 px de 64 |
| **Barrinhas (1–5)** | Velocidade 3 · Força 3 · Peso 3 · Volta ao palco 4 |

Peso 98, andar 335, correr 580, ar 420, pulo 1000. Quadros do sprite com margem de 8 px (`center_x` = 40).

## Mecânica própria: a bola de vôlei
Depois do saque a bola fica no palco, quicando (`BolaVolei`). **Qualquer lutador** bate nela com um golpe (a área de acerto do golpe encosta na bola); quem bateu por último é o dono. Bola **viva** (rápida, de golpe forte) machuca quem não é o dono (dano 3 a 9%, cresce com a velocidade); bola **mansa** (levantamento, toque, tapa) não machuca. Cada golpe do Mourisco rebate de um jeito: levantar (sem dano), cortar (viva) ou rebater. Só existe uma bola por Mourisco; some depois de 14 s sem ninguém bater ou ao sair do palco.

## Golpes

| Golpe | Ideia (dano / efeito na bola) |
|---|---|
| Jab 1 · 2 · 3 | tapa 2,5%, tapa, manchete (o 3º lança). Na bola: tapa e manchete levantam sem machucar |
| Forte frente | **cortada no chão** 8,5%; na bola: cortada viva para a frente |
| Forte cima | **toque para cima (levantamento)** 5%; na bola: sobe reta, sem dano |
| Forte baixo | **peixinho rasteiro** 6%, com passinho; na bola: bola viva rasteira |
| Aéreos | neutro: giro de bloqueio 4,5% · frente: cortada 7,5% (bola viva) · trás: chute de bicicleta 8,5% (bola viva para trás) · cima: bloqueio de braços 6% · baixo: cortada para baixo 8% (crava; bola viva para baixo) |
| Especial neutro | **Saque**: joga a bola para cima (mão levantada, quadro 8); **apertar Especial de novo** dá a cortada na direção segurada (sem alavanca: para a frente e um pouco para baixo), bola viva a 1250 px/s. O golpe do braço dá 3%. A bola fica no palco |
| Especial lado | **Manchete** 4% (12 quadros ativos): **devolve projétil** que chega na frente (dobra 15% de velocidade e passa a ser dele; único refletor do elenco) e rebate a bola (viva, 1000 px/s) |
| Especial cima | **Levantada e cortada**: salto de 365 px (recuperação, fica sem ação depois). Aperta Especial/Ataque no caminho e ele **crava** para baixo a 1500 px/s: 11%, lança para baixo (meteoro; mata fora do palco). Sem apertar, no topo é só um golpe de 4% |
| Especial baixo | **Peixinho** 7%: mergulho rasante de ~200 px com areia; se a bola está a menos de 170 px, ele a levanta (sem dano) |
| Agarrão e arremesso | padrão do jogo |

## Extras
- **Projétil / efeito próprio:** a bola (`bola_volei.png`, 2 quadros que giram) e a areia do peixinho (`fx_areia_mergulho.png`, 3 quadros).
- **Comemoração (3 poses):** grita com o punho para o alto.
- **Descanso na plataforma:** girando a bola no dedo.
- **Pendurado na borda:** com uma mão.
- **Ideia para depois:** o carteiro e o chef de cozinha podem virar roupas alternativas (escolha de roupa na seleção).
