shader_type canvas_item;

uniform float screen_width = 320.0;
uniform float screen_height = 240.0;
uniform float vignette_radius = 1.0;

void fragment() {
	// Slightly offset the center to account for the player's position in the scene
	vec2 center = vec2(0.5, 0.48);
	float aspect_ratio = screen_width / screen_height;
	float distance_from_center = distance(center, vec2(mix(center.x, UV.x, aspect_ratio), UV.y));
	COLOR.a = step(vignette_radius, distance_from_center);
}