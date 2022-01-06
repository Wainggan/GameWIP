//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	vec4 base_col = texture2D(gm_BaseTexture, v_vTexcoord);
	base_col.rgb = mix(vec3(0.5, 0.5, 1.0), base_col.rgb, v_vColour.a);
    gl_FragColor = vec4(base_col.rgb, 1.0);
}
