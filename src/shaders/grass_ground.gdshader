shader_type spatial;

group_uniforms Albedo;
uniform vec3 base_color: source_color;
const float NOISE_SCALE = .01;
uniform float roughness: hint_range(0.0, 1.0) = 1.0;
uniform float specular: hint_range(0.0, 1.0, 0.01) = 0.2;

group_uniforms Lighting;
uniform float light_strength: hint_range(0.0, 1.0) = .25;
uniform float step_blur: hint_range(0.0, 0.1) = .015;
uniform float cutoff_light: hint_range(0.0, 1.0) = .2;
uniform float weight_light: hint_range(0.0, 1.0) = .3;
uniform float cutoff_penumbra: hint_range(0.0, 1.0) = .1;
uniform float weight_penumbra: hint_range(0.0, 1.0) = .15;

global uniform sampler2D grass_albedo_texture;


void fragment() {
	vec3 vertex = (inverse(VIEW_MATRIX) * vec4(VERTEX,1)).xyz;
	ALBEDO = texture(grass_albedo_texture, (vertex.xz) * NOISE_SCALE).xyz;
	
	SPECULAR = specular;
	ROUGHNESS = roughness;
}

void light() {
	float diffuse = 1.0;
	float diffuse_light = smoothstep(cutoff_light-step_blur, cutoff_light+step_blur, diffuse) * weight_light;
	float diffuse_penumbra = smoothstep(cutoff_penumbra-step_blur, cutoff_penumbra+step_blur, diffuse) * weight_penumbra;
	
	diffuse = (diffuse_light + diffuse_penumbra) * light_strength;
	
	DIFFUSE_LIGHT += diffuse * ATTENUATION * LIGHT_COLOR / PI;
    SPECULAR_LIGHT += diffuse * ATTENUATION * LIGHT_COLOR / PI;
}
