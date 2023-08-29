//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
/*
uniform sampler2D overlayTexture;

varying vec2 v_vTexcoord;

float overlay( float S, float D ) {
    return float( D > 0.5 ) * ( 2.0 * (S + D - D * S ) - 1.0 )
    + float( D <= 0.5 ) * ( ( 2.0 * D ) * S );
}

void main() {
    vec4 D = texture2D( gm_BaseTexture, v_vTexcoord );  //destination color
    vec4 S = texture2D( overlayTexture, v_vTexcoord );  //source color

    gl_FragColor = vec4(
        mix(
            vec3( overlay( S.r, D.r ), overlay( S.g, D.g ), overlay( S.b, D.b ) ),
            D.rgb,
            1.0 - S.a
        ),
        D.a
    );
}*/

void main()
{
	
	
	
	// For 'a' base layer, 'b' top layer.
	
	vec4 base = texture2D( gm_BaseTexture, v_vTexcoord );
	vec4 col = base;
	
	if (base.r < 0.5) {
		col.r = 2.0 * base.r * v_vColour.r;
	} else {
		col.r = 1.0 - 2.0 * (1.0 - base.r) * (1.0 - v_vColour.r);
	}
	if (base.g < 0.5) {
		col.g = 2.0 * base.g * v_vColour.g;
	} else {
		col.g = 1.0 - 2.0 * (1.0 - base.g) * (1.0 - v_vColour.g);
	}
	if (base.b < 0.5) {
		col.b = 2.0 * base.r * v_vColour.b;
	} else {
		col.b = 1.0 - 2.0 * (1.0 - base.b) * (1.0 - v_vColour.b);
	}
	
	col.rgb = mix(base.rgb, col.rgb, v_vColour.a);
	col.a = base.a;
	
    gl_FragColor = col;
}
