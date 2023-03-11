//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform sampler2D otherTexture;

void main()
{
	
    vec4 base_tex_col = v_vColour * texture2D(gm_BaseTexture, v_vTexcoord);
    vec4 other_tex_col = v_vColour * texture2D(otherTexture, v_vTexcoord);
    //vec4 final_tex_col = (base_tex_col + other_tex_col) / 2.0;

    gl_FragColor =  other_tex_col;
}
