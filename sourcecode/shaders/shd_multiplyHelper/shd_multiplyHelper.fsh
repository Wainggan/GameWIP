
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

void main()
{
	
	vec4 oc = texture2D( gm_BaseTexture, v_vTexcoord );
	
	vec3 col = mix(vec3(1.0), oc.rgb * v_vColour.rgb, oc.a * v_vColour.a);
	
    gl_FragColor = vec4(col, 1.0);
}
