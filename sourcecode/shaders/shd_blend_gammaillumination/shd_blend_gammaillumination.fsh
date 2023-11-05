
varying vec4 v_color;
varying vec2 v_coord;
varying vec2 v_screen;
uniform sampler2D u_destination;

void main()
{
	
	//Sample the source and destination textures
	vec4 src = texture2D(gm_BaseTexture, v_coord) * v_color;
	vec4 dst = texture2D(u_destination, v_screen);

	vec4 col = 1.0 - pow(1.0 - dst, 1.0 / max(1.0 - src, 0.0001));
	
	col.rgb = mix(dst.rgb, col.rgb, src.a);
	col.a = src.a + dst.a * (1.0 - src.a);

	gl_FragColor = col;
}
