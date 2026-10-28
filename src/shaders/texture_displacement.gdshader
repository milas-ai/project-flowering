shader_type canvas_item;

uniform float frequency = 2.5;

void vertex() {
	VERTEX.x += sin(VERTEX.y + TIME) * frequency;
	VERTEX.y += cos(VERTEX.x + TIME) * frequency;
}
