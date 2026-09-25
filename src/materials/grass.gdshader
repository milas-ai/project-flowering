shader_type spatial;

uniform vec3 base_color: source_color;
uniform float light_strength: hint_range(0.0, 1.0) = .25;
uniform float step_blur: hint_range(0.0, 0.1) = .015;
uniform float cutoff_light: hint_range(0.0, 1.0) = .2;
uniform float weight_light: hint_range(0.0, 1.0) = .3;
uniform float cutoff_penumbra: hint_range(0.0, 1.0) = .1;
uniform float weight_penumbra: hint_range(0.0, 1.0) = .15;

void fragment() {
	ALBEDO = base_color;
}

void light() {
	float diffuse = max(dot(NORMAL, LIGHT), 0.0);
	float diffuse_light = smoothstep(cutoff_light-step_blur, cutoff_light+step_blur, diffuse) * weight_light;
	float diffuse_penumbra = smoothstep(cutoff_penumbra-step_blur, cutoff_penumbra+step_blur, diffuse) * weight_penumbra;
	
	diffuse = (diffuse_light + diffuse_penumbra) * light_strength;
	
	DIFFUSE_LIGHT += diffuse * ATTENUATION * LIGHT_COLOR / PI;
    SPECULAR_LIGHT += diffuse * ATTENUATION * LIGHT_COLOR / PI;
}
