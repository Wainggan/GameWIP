
varying vec4 v_color;
varying vec2 v_coord;
varying vec2 v_screen;
uniform sampler2D u_destination;

void main()
{
	
	//Sample the source and destination textures
	vec4 src = texture2D(gm_BaseTexture, v_coord) * v_color;
	vec4 dst = texture2D(u_destination, v_screen);
	
	vec4 col = dst;
	
	// invert background
	vec4 col1 = max(col, vec4(src.a)) - min(col, vec4(src.a));
	col = mix(col, col1, 0.7);
	
	// multiply
	vec4 col2 = col * (src * 0.7 + 0.2);
	col = col2;
	
	// screen
	vec4 col3 = src + col - src * col;
	col = mix(col, col3, 0.3);
	
	// addition
	vec4 col4 = col + (src * 0.2);
	col = col4;
	
	// gamma light
	vec4 col5 = pow(dst, src);
	col = mix(col, col5, 0.1);
	
	// normal
	vec4 col6 = src;
	col = mix(col, src, 0.1);
	
	// transparency
	vec4 col7 = mix(col, dst, 0.25);
	col = col7;
	
	col.rgb = mix(dst.rgb, col.rgb, src.a);
	col.a = src.a + dst.a * (1.0 - src.a);

	gl_FragColor = col;
}
