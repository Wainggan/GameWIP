//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float colorAmount;
uniform vec3 colorTarget;

void main()
{
	vec4 texColor = texture2D( gm_BaseTexture, v_vTexcoord ) * v_vColour;
    gl_FragColor = vec4(mix(texColor.rgb, colorTarget, colorAmount), texColor.a);
}
