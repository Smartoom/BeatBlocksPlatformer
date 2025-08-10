shader_type canvas_item;

uniform sampler2D cut_out_mask;
uniform float scale : hint_range(0,1.0);
uniform vec2 position_on_screen=vec2(0.5,0.5);

void fragment() {
	float s = scale*100.0;
	vec2 offset = position_on_screen * (1.0-s);
	vec4 mask_color = texture(cut_out_mask, UV * s + offset);
	COLOR.a = 1.0 - mask_color.a;
}