shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D depth_texture : hint_depth_texture, filter_linear_mipmap;
uniform sampler2D normal_rough_texture : hint_normal_roughness_texture, filter_nearest;

float linear_depth(vec2 uv, mat4 inv_projection_matrix) {
	float depth_raw = texture(depth_texture, uv).x;
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
	float offset_size = 0.001;

	vec2 offset[4];
	offset[0] = SCREEN_UV + vec2(0.0, -1.0) * offset_size; // top
	offset[1] = SCREEN_UV + vec2(0.0, 1.0) * offset_size; // bottom
	offset[2] = SCREEN_UV + vec2(-1.0, 0.0) * offset_size; // left
	offset[3] = SCREEN_UV + vec2(1.0, 0.0) * offset_size; // right

	float depth = linear_depth(SCREEN_UV, INV_PROJECTION_MATRIX);
	float depth_border = 0.0;
	for (int i = 0; i < offset.length(); i++) {
		depth_border += clamp(linear_depth(offset[i], INV_PROJECTION_MATRIX) - depth, 0.0, 1.0);
	}
	depth_border = smoothstep(0, 0.1, depth_border); // Adjust the threshold for edge detection

	vec3 normal = texture(normal_rough_texture, SCREEN_UV).xyz * 2.0 - 1.0;
	float normal_border = 0.0;
	for (int i = 0; i < offset.length(); i++) {
		vec3 offset_normal = texture(normal_rough_texture, offset[i]).xyz * 2.0 - 1.0;
		normal_border += normal_edge_indicator(normal, offset_normal, depth_border);
	}
	normal_border = smoothstep(0.2, 0.2, normal_border);
	
	float outline = normal_border + depth_border;
	ALBEDO = outline * vec3(0.0);
	ALPHA = outline;
}
