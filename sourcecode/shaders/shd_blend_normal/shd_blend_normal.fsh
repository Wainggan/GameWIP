
varying vec4 v_color;
varying vec2 v_coord;
varying vec2 v_screen;
uniform sampler2D u_destination;

void main()
{
	
	//Sample the source and destination textures
	vec4 src = texture2D(gm_BaseTexture, v_coord) * v_color;
	vec4 dst = texture2D(u_destination, v_screen);
	
	vec4 col;
	col.a = src.a + dst.a * (1.0 - src.a);
	col.rgb = src.rgb + dst.rgb * (1.0 - src.a);
	col.rgb = col.rgb / col.a;

	gl_FragColor = col;
}
