
varying vec4 v_color;
varying vec2 v_coord;
varying vec2 v_screen;
uniform sampler2D u_destination;

void main()
{
	//Sample the source and destination textures
	vec4 src = texture2D(gm_BaseTexture, v_coord) * v_color;
	vec4 dst = texture2D(u_destination, v_screen);
	
	vec4 col = src;
	if (dst.r < 0.5) {
		col.r = 2.0 * dst.r * src.r;
	} else {
		col.r = 1.0 - 2.0 * (1.0 - dst.r) * (1.0 - src.r);
	}
	if (dst.g < 0.5) {
		col.g = 2.0 * dst.g * src.g;
	} else {
		col.g = 1.0 - 2.0 * (1.0 - dst.g) * (1.0 - src.g);
	}
	if (dst.b < 0.5) {
		col.b = 2.0 * dst.r * src.b;
	} else {
		col.b = 1.0 - 2.0 * (1.0 - dst.b) * (1.0 - src.b);
	}
	
	col.rgb = mix(dst.rgb, col.rgb, src.a);
	col.a = src.a + dst.a * (1.0 - src.a);
	
    gl_FragColor = col;
}
