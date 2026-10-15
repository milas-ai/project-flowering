shader_type spatial;
render_mode ambient_light_disabled, specular_disabled;

uniform sampler2D screen_texture : hint_screen_texture, filter_nearest;
uniform sampler2D depth_texture : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D normal_rough_texture : hint_normal_roughness_texture, filter_nearest;

float linear_depth(vec2 uv, mat4 inv_projection_matrix, float zero_roughness_mask) {
	float depth_raw = texture(depth_texture, uv).x * zero_roughness_mask;
	vec3 normalized_device_coordinates = vec3(uv * 2.0 - 1.0, depth_raw);
	vec4 view_space_position = inv_projection_matrix * vec4(normalized_device_coordinates, 1.0);
	view_space_position.xyz /= view_space_position.w;
	return -view_space_position.z;
}

float normal_edge_indicator(vec3 normal, vec3 offset_normal, float depth_border) {
	float normal_difference = dot(normal - offset_normal, vec3(1.0));
	float normal_indicator = clamp(smoothstep(-0.01, 0.01, normal_difference), 0.0, 1.0);
	float depth_indicator = clamp(sign(depth_border * 0.25 + 0.0025), 0.0, 1.0);
	return (1.0 - dot(normal, offset_normal)) * depth_indicator * normal_indicator;
}

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	float edge_opacity = 0.8;
	float offset_size = 1.0 / VIEWPORT_SIZE.x; // Using texel size based on viewport
	float zero_roughness_mask = ceil(texture(normal_rough_texture, SCREEN_UV).a);

	vec2 offset[4];
	offset[0] = SCREEN_UV + vec2(0.0, -1.0) * offset_size; // top
	offset[1] = SCREEN_UV + vec2(0.0, 1.0) * offset_size; // bottom
	offset[2] = SCREEN_UV + vec2(-1.0, 0.0) * offset_size; // left
	offset[3] = SCREEN_UV + vec2(1.0, 0.0) * offset_size; // right

	float depth = linear_depth(SCREEN_UV, INV_PROJECTION_MATRIX, zero_roughness_mask);
	float depth_border = 0.0;
	float inverse_depth_border = 0.5;
	for (int i = 0; i < offset.length(); i++) {
		float offset_depth = linear_depth(offset[i], INV_PROJECTION_MATRIX, zero_roughness_mask);
		depth_border += clamp(offset_depth - depth, 0.0, 1.0);
		inverse_depth_border += clamp(depth - offset_depth, 0.0, 1.0);
	}
	inverse_depth_border = clamp(step(0.9, inverse_depth_border) * 10.0, 0.0, 1.0);
	depth_border = smoothstep(0.25, 0.35, depth_border);

	vec3 normal = texture(normal_rough_texture, SCREEN_UV).xyz * 2.0 - 1.0 * zero_roughness_mask;
	float normal_border = 0.0;
	for (int i = 0; i < offset.length(); i++) {
		vec3 offset_normal = texture(normal_rough_texture, offset[i]).xyz * 2.0 - 1.0 * zero_roughness_mask;
		normal_border += normal_edge_indicator(normal, offset_normal, depth_border);
	}
	normal_border = step(0.2, normal_border);
	normal_border = clamp(normal_border - inverse_depth_border, 0.0, 1.0);

	ALBEDO = texture(screen_texture, SCREEN_UV).rgb;
	ALPHA = clamp(0.1, edge_opacity, (depth_border + normal_border * 5.0));
}

void light() {
	float light_intensity = 1.5;

	vec4 normal = texture(normal_rough_texture, SCREEN_UV) * 2.0 - 1.0;
	float light_alignment = dot(normal.xyz, LIGHT);
	light_alignment = pow(light_alignment, 2.25); // Sharpen transition of light and shadow
	light_alignment = clamp(light_alignment, 0.0, 1.0);

	if (LIGHT_IS_DIRECTIONAL) {
		DIFFUSE_LIGHT += mix(vec3(1.0), light_alignment * LIGHT_COLOR * light_intensity, ALPHA);
	}
}
