// Pixel art nítido em qualquer zoom: cada pixel do sprite continua um bloco
// reto, e só a emenda entre blocos é suavizada (no máximo 1 pixel de tela).
// Evita pixels de tamanhos desiguais e o "tremido" quando a câmera aproxima e
// afasta em escalas quebradas. Usar com filtro de textura linear.
shader_type canvas_item;

varying vec4 tint;  // cor do vértice (flash de dano, transparência)

void vertex() {
	tint = COLOR;
}

void fragment() {
	vec2 size = 1.0 / TEXTURE_PIXEL_SIZE;
	vec2 px = UV * size;
	vec2 seam = floor(px + 0.5);
	vec2 dudv = max(fwidth(px), vec2(1e-4));
	px = seam + clamp((px - seam) / dudv, -0.5, 0.5);
	COLOR = texture(TEXTURE, px / size) * tint;
}
