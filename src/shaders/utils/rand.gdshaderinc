float randf(float seed) {
    return fract(sin(seed * 91.3458) * 47453.5453);
}

float randf(vec2 seed) {
    return fract(sin(dot(seed.xy, vec2(12.9898, 78.233))) * 43758.5453123);
}

float randf(vec3 seed) {
    return fract(sin(dot(seed, vec3(12.9898, 78.233, 91.3458))) * 43758.5453123);
}

int randi_range(float seed, int min_val, int max_val) {
	return min_val + int(randf(seed) * (float(max_val - min_val) + .999));
}

int randi_range(vec2 seed, int min_val, int max_val) {
	return min_val + int(randf(seed) * (float(max_val - min_val) + .999));
}

int randi_range(vec3 seed, int min_val, int max_val) {
	return min_val + int(randf(seed) * (float(max_val - min_val) + .999));
}