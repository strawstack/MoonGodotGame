shader_type spatial;

uniform vec4 color: source_color;
uniform sampler2D noise;

void vertex() {

}

void fragment() {
	vec3 tex = texture(noise, UV).xyz;
	if (tex.x > 0.3 && tex.x < 0.32) {
		ALBEDO = vec3(0,0,0);
		// EMISSION = vec3(1,1,1);
	} else {
		ALBEDO = mix(color.xyz, tex, 0.5);
	}

}

//void light() {
//	// Called for every pixel for every light affecting the material.
//	// Uncomment to replace the default light processing function with this one.
//}
