shader_type spatial;

uniform vec3 color1: source_color;
uniform vec3 color2: source_color;

uniform float scale = .02;

uniform sampler2D waves_noise;

vec2 wave_uv(vec2 uv , float time_x_add, float time_y_add, float x_amplitude, float y_amplitude, float _scale, float speed, float scroll_speed) {
	float uv_x = TIME * scroll_speed + uv.x * _scale + (sin(TIME * speed + time_x_add) * x_amplitude);
	float uv_y = TIME * scroll_speed + uv.y * _scale + (sin(TIME * speed + time_y_add) * y_amplitude);
	return vec2(uv_x, uv_y);
}

void fragment() {
	vec2 uv_global = (INV_VIEW_MATRIX * vec4(VERTEX,1)).xz;
	
	float time_x_add;
	float time_y_add;
	float x_amplitude;
	float y_amplitude;
	float _scale;
	float speed;
	float scroll_speed;
	
	time_x_add = 0.;
	time_y_add = 1.;
	x_amplitude = 1.5;
	y_amplitude = 1.2;
	_scale = .2;
	speed = .5;
	scroll_speed = .2;
	vec2 uv1 = wave_uv(uv_global, time_x_add, time_y_add, x_amplitude, y_amplitude, _scale, speed, scroll_speed) * scale;
	float noise1 = texture(waves_noise, uv1).x;
	
	time_x_add = 1.;
	time_y_add = .4;
	x_amplitude = .7;
	y_amplitude = .4;
	_scale = .6;
	speed = 1.;
	scroll_speed = .3;
	vec2 uv2 = wave_uv(uv_global, time_x_add, time_y_add, x_amplitude, y_amplitude, _scale, speed, scroll_speed) * scale;
	float noise2 = texture(waves_noise, uv2 * 2.).x;
	
	float noise = (noise1 + noise2) / 2.;
	
	ALBEDO = mix(color1, color2, noise);
}