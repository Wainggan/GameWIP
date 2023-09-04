//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	
	// For 'a' base layer, 'b' top layer.
	
	vec4 base = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 col = base;
	
	if (base.r < 0.5) {
		col.r = base.r * (base.r + 0.5) * v_vColour.r;
	} else {
		col.r = base.r / (base.r + 0.5) * v_vColour.r;
	}
	if (base.g < 0.5) {
		col.g = base.g * (base.g + 0.5) * v_vColour.g;
	} else {
		col.g = base.g / (base.g + 0.5) * v_vColour.g;
	}
	if (base.b < 0.5) {
		col.b = base.b * (base.b + 0.5) * v_vColour.b;
	} else {
		col.b = base.b / (base.b + 0.5) * v_vColour.b;
	}
	
	col.rgb = mix(base.rgb, col.rgb, v_vColour.a);
	col.a = base.a;
	
    gl_FragColor = col;

}
