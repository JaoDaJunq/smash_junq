// Cor 2 do ESPELHO (P1 e P2 com o mesmo lutador): as cores do P2 ficam as
// mesmas (só um pouco mais escuras) e o CONTORNO escuro vira a cor do P2.
// Antes girava a matiz do corpo todo e parecia bug (revisão 28/10).
// nitido = true repete o pixel nítido do pixel_nitido.gdshader (sprite da luta,
// filtro linear); false lê a textura direto (retratos e artes da interface).
shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(0.36, 0.62, 1.0, 1.0);
uniform float darken = 0.85;        // multiplica o brilho das cores do corpo
uniform bool nitido = true;

varying vec4 tint;  // cor do vértice (flash de dano, transparência)

void vertex() {
	tint = COLOR;
}

vec3 rgb2hsv(vec3 c) {
	vec4 K = vec4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
	vec4 p = mix(vec4(c.bg, K.wz), vec4(c.gb, K.xy), step(c.b, c.g));
	vec4 q = mix(vec4(p.xyw, c.r), vec4(c.r, p.yzx), step(p.x, c.r));
	float d = q.x - min(q.w, q.y);
	float e = 1.0e-10;
	return vec3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

vec3 hsv2rgb(vec3 c) {
	vec4 K = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
	vec3 p = abs(fract(c.xxx + K.xyz) * 6.0 - K.www);
	return c.z * mix(K.xxx, clamp(p - K.xxx, 0.0, 1.0), c.y);
}

void fragment() {
	vec4 c;
	if (nitido) {
		vec2 size = 1.0 / TEXTURE_PIXEL_SIZE;
		vec2 px = UV * size;
		vec2 seam = floor(px + 0.5);
		vec2 dudv = max(fwidth(px), vec2(1e-4));
		px = seam + clamp((px - seam) / dudv, -0.5, 0.5);
		c = texture(TEXTURE, px / size);
	} else {
		c = texture(TEXTURE, UV);
	}
	vec3 hsv = rgb2hsv(c.rgb);
	// contorno escuro (#2A0F12 e pretos) vira a cor do P2; o resto escurece de leve
	float is_line = 1.0 - smoothstep(0.10, 0.18, hsv.z);
	c.rgb = mix(c.rgb * darken, outline_color.rgb, is_line);
	COLOR = c * tint;
}
