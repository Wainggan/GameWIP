//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float iTime;

void main()
{
	float posx = sin(iTime * 0.06 + v_vTexcoord.y * 100.0) / 512.0 * 2.0;
	posx += sin(iTime * 0.12 + v_vTexcoord.y * 200.0) / 512.0 * 1.0;
	float posy = sin(iTime * 0.02 + v_vTexcoord.x * 20.0) / 512.0 * 1.0;
	
    gl_FragColor = v_vColour * texture2D( gm_BaseTexture, v_vTexcoord + vec2(posx, posy) );
}
