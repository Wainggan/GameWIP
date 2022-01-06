 //
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform float fxStrength;
uniform float aspect;
uniform sampler2D texWaves;

void main()
{
	vec2 offset = (texture2D(texWaves, v_vTexcoord).rg - 0.5) * 2.0 * fxStrength;
	offset.x /= aspect;
	vec4 out_col = texture2D(gm_BaseTexture, v_vTexcoord + offset);
    gl_FragColor = out_col;
}
