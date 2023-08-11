//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;

uniform vec4 u_color;
uniform vec2 u_pixelSize;
uniform float u_thickness;


void main()
{
	
	float base = texture2D( gm_BaseTexture, v_vTexcoord ).a;
	float a = 0.0;
	a += texture2D( gm_BaseTexture, v_vTexcoord - vec2(u_pixelSize.x, 0.0) * u_thickness ).a;
	a += texture2D( gm_BaseTexture, v_vTexcoord + vec2(u_pixelSize.x, 0.0) * u_thickness ).a;
	a += texture2D( gm_BaseTexture, v_vTexcoord - vec2(0.0, u_pixelSize.y) * u_thickness ).a;
	a += texture2D( gm_BaseTexture, v_vTexcoord + vec2(0.0, u_pixelSize.y) * u_thickness ).a;
	a = min(a, 1.0);
	
    gl_FragColor = mix(texture2D( gm_BaseTexture, v_vTexcoord ), u_color, max(a - base, base - a));
}
