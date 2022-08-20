//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;

uniform float blurAmount;
uniform float sigma;
uniform vec2 texelSize;
uniform vec2 blurVector;


float weight(float pos) {
	return exp(-(pos * pos) / (2.0 * sigma * sigma));
}

void main()
{
	vec4 blurredCol = vec4(0.0);
	float kernel = blurAmount * 2.0 + 1.0;
	
	float offset, weight_sample, weight_total = 0.0;
	
	for (offset = -blurAmount; offset <= blurAmount; offset++) {
		weight_sample = weight(offset / kernel);
		weight_total += weight_sample;
			
		blurredCol += texture2D( gm_BaseTexture, v_vTexcoord + offset * texelSize * blurVector ) * weight_sample;
	}
	
    gl_FragColor = v_vColour * (blurredCol / weight_total);
}
