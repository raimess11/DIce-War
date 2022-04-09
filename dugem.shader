shader_type canvas_item;

void fragment(){
	vec2 uv = UV;
	vec4 color = texture(TEXTURE, UV);
	vec4 non_color_top = texture(TEXTURE,UV + vec2(0.0, 0.05));
	vec4 non_color_bottom = texture(TEXTURE,UV + vec2(0.0, -0.05));
	
	COLOR = vec4(vec3(tan(TIME)*1.0,cos(-TIME)*uv.x, sin(TIME)*uv.y), color.a);
	
	if (non_color_top.a == 1.0 || non_color_bottom.a == 1.0 || texture(TEXTURE,UV + vec2(-0.05, 0.0)).a == 1.0){
			COLOR = vec4(vec3(tan(TIME)*1.0,cos(-TIME)*uv.x, sin(TIME)*uv.y), 1.0);
	}
	
	
	else {
		COLOR = vec4(vec3(0.5),0.0)
		}
	if (non_color_top.a == 0.0 || non_color_bottom.a == 0.0){
		//COLOR = vec4(0.0,0.0,0.0,color.a);
	}
}
