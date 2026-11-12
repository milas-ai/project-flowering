// NOTE: Shader automatically converted from Godot Engine 4.7.stable's StandardMaterial3D.

shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_burley, specular_schlick_ggx;

uniform float wind_bend_ammount = .3;
uniform float sway_back: hint_range(0.0, 1.0) = .7;

uniform sampler2D texture_albedo : source_color, filter_linear_mipmap, repeat_enable;
uniform sampler2D wind_mask : source_color, filter_linear_mipmap, repeat_enable;

global uniform sampler2D wind_noise_texture;
global uniform vec3 wind_direction;
global uniform float wind_scale;
global uniform float wind_speed;
global uniform float wind_strength;


void vertex() {
	vec3 vertex = (MODEL_MATRIX * vec4(VERTEX,1)).xyz; // use uv as vertex's global .xz
	vertex = vertex * wind_scale - (wind_speed * TIME * wind_direction); // pan UV
	vec3 displacement = texture(wind_noise_texture, vertex.xz).xyz;
	displacement = displacement * (1.0 + sway_back) - sway_back;
	displacement *= wind_bend_ammount * wind_strength;
	displacement.y = 0.;
	float uv_mask = texture(wind_mask, UV).x;
	VERTEX += displacement * uv_mask;
}


void fragment() {
	vec4 albedo_tex = texture(texture_albedo, UV);
	ALBEDO = albedo_tex.rgb;
}
