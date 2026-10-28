# Bandeira · ficha

> Concept escolhido em 28/10/2026: **1 · dedetizador** (`art/concepts/tamandua/escolhido.png`). Kit da rodada 11 (`design/proposta-rodada11.md`), programado em `game/scripts/characters/bandeira.gd` e `nuvem_veneno.gd`.

| | |
|---|---|
| **id** (pasta) | `tamandua` |
| **Bicho** | tamanduá-bandeira: focinho comprido, garras grandes e cauda enorme em forma de bandeira |
| **Grupo · Tipo** | Garrudos · **Forte** |
| **Profissão / papel** | **Dedetizador**: macacão claro, bomba de veneno nas costas e mangueira na mão. Come as formigas que devia matar |
| **Personalidade** | Calmo, profissional, fala como técnico ("é praga, senhor") |
| **Acessório de assinatura** | **Bomba de veneno amarela nas costas com mangueira** e máscara |
| **Silhueta** | Cauda enorme e peluda, focinho longo, postura curvada de garras |
| **Cores** | pelo creme `#E8C581` · pelo escuro e cauda `#402522` · macacão `#D8C7A6` · faixa e equipamento `#E89A05` · contorno vinho `#2a0f12` |
| **Altura no sprite** | ~56 px de 64 (cauda grande) |
| **Barrinhas (1–5)** | Velocidade 2 · Força 4 · Peso 4 · Volta ao palco 3 |

Peso 115, andar 280, correr 500, ar 370, pulo 980. Quadros do sprite com margem de 12 px (`center_x` = 44).

## Mecânica própria: come praga
A **língua engole projéteis** dos outros (pipoca, castanha, coquinho, nota...) e cada um cura **2%** (nunca abaixo de 0%). Também aparece como "tosse": a **nuvem de veneno** derruba o escudo de quem está dentro.

## Golpes

| Golpe | Ideia (dano) |
|---|---|
| Jab 1 · 2 · 3 | garrada 3,2%, garrada, focinhada (o 3º lança) |
| Forte frente | **jato de mangueira curto** (bico da bomba), 10%, alcance 96 px, com efeito `fx_jato` |
| Forte cima | **cauda-bandeira abanando para cima**, 8%, acerta bem acima da cabeça |
| Forte baixo | **focinho varrendo rente ao chão**, 7% |
| Aéreos | neutro: giro de cauda 5,5% · frente: garras 8,5% · trás: cauda abanando 9% · cima: focinho para cima 7,5% · baixo: pisão com botina 10% (crava) |
| Especial neutro | **Nuvem de veneno**: borrifa uma nuvem (raio 78 px) que fica **3 s** no lugar; quem está dentro **tosse (não segura o escudo)** e toma **1% a cada 0,5 s**. O dono não sofre. Só uma nuvem por vez |
| Especial lado | **Língua**: língua de ~140 px; **engole projétil e cura 2%**; se pega o adversário, **puxa um pouco** (3,5%) |
| Especial cima | **Escalada de garra**: crava as garras e sobe como numa árvore (~240 px, constante), 5%; **agarra a borda de mais longe** (alcance 140×110 px, contra 70×50 do normal) durante e 1,6 s depois |
| Especial baixo | **Abraço de tamanduá**: lento (18 quadros), segura (passa pelo escudo), **aperta 4 vezes (2,5% cada)** e joga com 6% (total ~16%). Quem é segurado pode apertar botões para se soltar mais cedo. Se erra, fica vulnerável |
| Agarrão e arremesso | padrão do jogo |

## Extras
- **Projétil / efeito próprio:** `fx_jato` (4 quadros, jato da mangueira) e `fx_nuvem_veneno` (4 quadros: nasce, enche, enche, dissipa).
- **Comemoração (3 poses):** borrifa a "área" satisfeito.
- **Descanso na plataforma:** lambendo formigas de um formigueiro.
- **Pendurado na borda:** com uma mão.
