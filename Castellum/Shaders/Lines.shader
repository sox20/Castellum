shader_type spatial;
render_mode specular_disabled;

uniform vec3 color;

float lines(vec2 fc, float dist, float width) {
	return floor(abs(mod((fc.x+fc.y)/dist,1.))+width/dist);
}

void fragment() {
	ALBEDO = color;
}

void light() {
	float avg_att = (ATTENUATION.x + ATTENUATION.y + ATTENUATION.z)/3f;
	if(avg_att<.2){
		DIFFUSE_LIGHT = lines(FRAGCOORD.xy,30,10f) * ALBEDO;
	}
	else
	{
		DIFFUSE_LIGHT = ALBEDO;
	}
	SPECULAR_LIGHT = vec3(0);

}