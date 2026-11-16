vec3 rgb2hsv(vec3 rgb) {
	vec3 hsv;
	float min_rgb = min(min(rgb.r, rgb.g), rgb.b);
	float max_rgb = max(max(rgb.r, rgb.g), rgb.b);
	
	hsv.z = max_rgb;
	
	float delta = max_rgb - min_rgb;
	if (delta < 0.00001) return vec3(0., 0., hsv.z);
	
	if(max_rgb > 0.0) hsv.y = (delta / max_rgb); // prevent division by 0
	else return vec3(0., 0., hsv.z);
	
	if(rgb.r >= max_rgb) hsv.x = (rgb.g - rgb.b) / delta;	// between yellow & magenta
	else if(rgb.g >= max_rgb) hsv.x = 2. + (rgb.b - rgb.r) / delta;  // between cyan & yellow
	else hsv.x = 4. + (rgb.r - rgb.g) / delta;  // between magenta & cyan
	
	//hsv.x *= 60.;// degrees
	if(hsv.x < 0.)
		hsv.x += 360.0;
	
	return hsv;
}


vec3 hsv2rgb(vec3 hsv) {
	vec3 rgb;
	
	float h = hsv.x / 360.;
	float s = hsv.y / 100.;
	float v = hsv.z / 100.;
	
	int i = int(floor(h * 6.));
	float f = h * 6. - float(i);
	float p = v * (1. - s);
	float q = v * (1. - f * s);
	float t = v * (1. - (1. - f) * s);
	
	switch (i % 6) {
		case 0: rgb.r = v; rgb.g = t; rgb.b = p; break;
		case 1: rgb.r = q; rgb.g = v; rgb.b = p; break;
		case 2: rgb.r = p; rgb.g = v; rgb.b = t; break;
		case 3: rgb.r = p; rgb.g = q; rgb.b = v; break;
		case 4: rgb.r = t; rgb.g = p; rgb.b = v; break;
		case 5: rgb.r = v; rgb.g = p; rgb.b = q; break;
	}
	
	return rgb * 255.;
}