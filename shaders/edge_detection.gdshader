shader_type spatial;
render_mode unshaded, fog_disabled;

uniform sampler2D depth_texture : hint_depth_texture, repeat_disable;
// uniform sampler2D normal_rough_texture : hint_normal_roughness_texture;

float linear_depth(vec2 uv, mat4 inv_projection_matrix) {
	float depth_raw = texture(depth_texture, uv).x;
	return 1.0 / (depth_raw * inv_projection_matrix[2].w + inv_projection_matrix[3].w);
}

void vertex() {
	POSITION = vec4(VERTEX.xy, 1.0, 1.0);
}

void fragment() {
	float depth = linear_depth(SCREEN_UV, INV_PROJECTION_MATRIX);
	float offset = 0.0001;
	float border_up    = linear_depth(SCREEN_UV - vec2(0, offset), INV_PROJECTION_MATRIX) - depth;
	float border_down  = linear_depth(SCREEN_UV + vec2(0, offset), INV_PROJECTION_MATRIX) - depth;
	float border_left  = linear_depth(SCREEN_UV - vec2(offset, 0), INV_PROJECTION_MATRIX) - depth;
	float border_right = linear_depth(SCREEN_UV + vec2(offset, 0), INV_PROJECTION_MATRIX) - depth;
	float outline = clamp(border_up + border_down + border_left + border_right, 0.0, 1.0);
	outline = smoothstep(0, 0.01, outline); // Adjust the threshold for edge detection
	ALBEDO = outline * vec3(0.0);
	ALPHA = outline;

	// vec4 normal_rough = texture(normal_rough_texture, SCREEN_UV);
	// vec3 normals_view_raw = normal_rough.xyz; // Normals in view space, in [0.0, 1.0] range
	// ALBEDO.rgb = normals_view_raw;
}
