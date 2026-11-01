shader_type spatial;
render_mode unshaded, fog_disabled, blend_add, cull_disabled, depth_test_disabled;

uniform sampler2D depth_texture: hint_depth_texture;

instance uniform vec3 color: source_color;
instance uniform float strength = 1.;
instance uniform float hardness = 1.;


void fragment() {
	// Manually do depth test
	vec3 scene_clip_pos = vec3(SCREEN_UV * 2.0 - 1.0, texture(depth_texture, SCREEN_UV).r);
	vec4 scene_view_pos = INV_PROJECTION_MATRIX * vec4(scene_clip_pos, 1.0);
	scene_view_pos.xyz /= scene_view_pos.w;
	float scene_dist = length(scene_view_pos.xyz);
	float dist = length(VERTEX);
	dist = min(dist, scene_dist);
	
	// Subtract front and add back facing for soft border effect
	dist  = pow(dist, hardness) * strength;
	dist *= FRONT_FACING ? -1. : 1.;
	
	ALBEDO = color * dist;
}