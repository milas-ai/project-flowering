shader_type spatial;

group_uniforms Albedo;
uniform vec3 base_color: source_color;

group_uniforms Diffuse;
uniform float diffuse_strength: hint_range(0.0, 1.0) = .25;
uniform float diffuse_blur: hint_range(0.0, 0.1) = .015;
uniform float light_cutoff: hint_range(0.0, 1.0) = .2;
uniform float light_strength: hint_range(0.0, 1.0) = .3;
uniform float penumbra_cutoff: hint_range(0.0, 1.0) = .1;
uniform float penumbra_strength: hint_range(0.0, 1.0) = .15;

group_uniforms Specular;
uniform float specular_strength: hint_range(0.0, 1.0) = .1;
uniform float specular_power: hint_range(0.0, 10.0) = 10;
uniform float specular_blur: hint_range(0.0, 0.5) = .015;
uniform float cutoff_specular: hint_range(0.0, 1.0) = .1;

void fragment() {
	ALBEDO = base_color;
}

void light() {
	// DIFFUSE
	float diffuse = max(dot(NORMAL, LIGHT), 0.0);
	// Smoothstep to toon shade light and penumbra areas
	float diffuse_light = smoothstep(light_cutoff-diffuse_blur, light_cutoff+diffuse_blur, diffuse) * light_strength;
	float diffuse_penumbra = smoothstep(penumbra_cutoff-diffuse_blur, penumbra_cutoff+diffuse_blur, diffuse) * penumbra_strength;
	// diffuse will still be used in specular, so keep it
	float diffuse_final = (diffuse_light + diffuse_penumbra) * diffuse_strength;
	
	// SPECULAR
	float specular = max(dot(NORMAL, normalize(VIEW+LIGHT)), 0.0);
	// Specular exponential curve
	specular = pow(specular, specular_power);
	// Smmooth step to toon shade
	specular = smoothstep(cutoff_specular-specular_blur, cutoff_specular+specular_blur, specular);
	specular *= specular_strength;
	// apply it on according to lit areas
	specular *= diffuse;
	
	DIFFUSE_LIGHT += diffuse_final * ATTENUATION * LIGHT_COLOR / PI;
	SPECULAR_LIGHT += specular * ATTENUATION * LIGHT_COLOR / PI;
}