shader_type canvas_item;

uniform float posterization_level : hint_range(2, 16) = 10.0;
uniform float pre_effect_gamma : hint_range(1.0, 10.0) = 1.167;
uniform float post_effect_gamma : hint_range(1.0, 10.0) = 1.067;

void fragment() {
	COLOR.rgb = pow(COLOR.rgb, vec3(1.0 / pre_effect_gamma));

	float greyscale = max(COLOR.r, max(COLOR.g, COLOR.b));
	float lower_level = floor(greyscale * posterization_level) / posterization_level;
	float upper_level = ceil(greyscale * posterization_level) / posterization_level;
	float final_greyscale = abs(greyscale - lower_level) < abs(greyscale - upper_level) ? lower_level : upper_level;
	COLOR.rgb *= final_greyscale / greyscale;
	
	COLOR.rgb = pow(COLOR.rgb, vec3(post_effect_gamma));
}