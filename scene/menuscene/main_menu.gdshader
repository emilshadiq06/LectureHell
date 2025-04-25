shader_type canvas_item;

uniform float amount = 0.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	
	color.rgb += amount/100.0;
	
	COLOR = color;
}
