shader_type canvas_item;

struct Ball {
	vec2 position;
	float radius;
	vec4 color;
};


// sampler2D abused as array.
uniform sampler2D balls;
uniform vec2 resolution;
uniform int count = 2;

uniform float sharpness = 0.98;
uniform float threshold = 0.0;
uniform float alpha = 1.0;


float map(float value, float min1, float max1, float min2, float max2) {
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}


Ball get_ball(in int index) {
	float normalized_index = float(index) / float(count - 1);
	
	vec4 color = texture(balls, vec2(normalized_index, 0.0));
	vec3 shape = texture(balls, vec2(normalized_index, 1.0)).xyz;
	
	shape.x = map(shape.x, 0.0, 1.0, 0.0, resolution.x);
	shape.y = map(shape.y, 0.0, 1.0, resolution.y, 0.0);
	shape.z = map(shape.z, 0.0, 1.0, 0.0, resolution.x);
	
	return Ball(shape.xy, shape.z, color);
}


void fragment() {
	float v = 0.0;
	vec4 color = vec4(v);
	
	for (int i = 0; i < count; i++) {
		Ball ball = get_ball(i);
		
		vec2 delta = abs(FRAGCOORD.xy - ball.position);
		float r = ball.radius;
		float dx = delta.x;
		float dy = delta.y;

		float f = r*r / (dx*dx + dy*dy + 1e-20);
		f = smoothstep(min(threshold, 1.0), 1.0, f);
		
		v += f;
		color.xyz += ball.color.xyz * f;
	}

	float t = smoothstep(min(sharpness, 1.0), 1.0, v);
	
	color.xyz /= v;
	color.a = alpha;
	color = mix(vec4(0.0), color, t);
	
	COLOR = color;
}
