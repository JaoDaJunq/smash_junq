// Paleta trocada do ESPELHO (P1 e P2 com o mesmo lutador): gira a matiz
// (+150° por padrão) e escurece de leve as cores do P2, deixando o contorno
// escuro e os pretos como estão (só pixels com brilho acima de ~0,2 mudam).
// nitido = true repete o pixel nítido do pixel_nitido.gdshader (sprite da luta,
// filtro linear); false lê a textura direto (retratos e artes da interface).
shader_type canvas_item;

uniform float hue_shift = 0.4167;   // fração da volta (150 / 360)
uniform float darken = 0.86;        // multiplica o brilho das cores trocadas
uniform float sat_boost = 1.0;
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
	vec3 swapped = hsv2rgb(vec3(fract(hsv.x + hue_shift), clamp(hsv.y * sat_boost, 0.0, 1.0), hsv.z * darken));
	// contorno escuro e pretos ficam; cinzas/brancos quase sem cor também
	float keep = 1.0 - smoothstep(0.16, 0.30, hsv.z);
	c.rgb = mix(swapped, c.rgb, keep);
	COLOR = c * tint;
}
