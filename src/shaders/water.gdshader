shader_type spatial;

uniform vec3 color1: source_color;
uniform vec3 color2: source_color;

uniform float scale = .05;

uniform sampler2D waves_noise;


void vertex() {
}

vec2 wave_uv(vec2 uv , float time_x_add, float time_x_mult, float time_y_add, float time_y_mult, float _scale, float speed) {
	float uv_x = uv.x * _scale + sin(TIME * speed + time_x_add) * time_x_mult;
	float uv_y = uv.y * _scale + sin(TIME * speed + time_y_add) * time_y_mult;
	return vec2(uv_x, uv_y);
}

void fragment() {
	vec2 uv_global = (INV_VIEW_MATRIX * vec4(VERTEX,1)).xz;
	
	vec2 uv1 = wave_uv(uv_global, 0, .1, .5, .05, .4, .5) * scale;
	float noise1 = texture(waves_noise, uv1).x;
	
	vec2 uv2 = wave_uv(uv_global, .2, .05, .2, .03, .8, .3) * scale;
	float noise2 = texture(waves_noise, uv2 * 2.).x;
	
	float noise = (noise1 + noise2) / 2.;
	
	ALBEDO = mix(color1, color2, noise);
}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
