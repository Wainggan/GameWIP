uniform float iGlobalTime; 
uniform vec2 iResolution; 
varying vec2 fragCoord; 
precision highp float;

#define AA 1.0

float hash( float n ){
    return fract(sin(n)*43758.5453);
}
float smin(float a, float b, float k) {
  float h = clamp(0.5 + 0.5*(a-b)/k, 0.0, 1.0);
  return mix(a, b, h) - k*h*(1.0-h);
}


vec3 getPixel(vec2 p, float time) {
    
    float colOut = 1.0;
    
    for (float i = 0.0; i < 32.0; i += 1.0) {
    
        //float rnd = i * 3.141 * 2.0 + 0.412;
        
        //vec2 pos = vec2(sin(iGlobalTime / 2.0 * 0.9212 + rnd * 0.6512), cos(iGlobalTime / 2.0 * 1.0442 + rnd * 0.1264)) / 3.0;
        float rnd = i*(3.141 * 2.0 + .4123);
		vec2 pos = vec2(sin(time*0.95 + rnd*3.131), cos(time*1.05 + rnd*5.763));
		pos *= vec2(sin(time*1.05 + i*i*3.141/7.131), cos(time*.95 + i*(i-1.0)*3.141/4.235));
        
        
        float dist = distance(p, pos);
        colOut = smin(colOut, dist, 0.47);
    }
    
    vec3 col = vec3(colOut);
    
    if (colOut <= 0.14) {
        
        if (colOut <= 0.09) {
            col = vec3(0.44, 0.1, 0.36);
        } else {
            col = vec3(0.93, 0.5, 0.8);
        }
        
    } else {
        float c = (1.0-colOut) * 0.9;
        col = vec3(c * 0.5, c / 2.0, c * 0.8);
    }
    
    return clamp(col, 0.0, 1.0);
}
vec3 render(vec2 p) {
    vec3 average = vec3(0.0);
    
    for (float i = 0.0; i <= 3.0; i += 1.) { 
        float scale = 1.8 - i * 0.2;
        float x = -1.1;//0.9;
        float y = 0.6;
    
        average += getPixel( vec2(p*scale +  vec2(x * scale, y * scale)  ), iGlobalTime / 50.0 + i * i * 2.5221);
    }
    vec3 col = average / 1.6;
    
    return clamp(col, 0.0, 1.0);
}



void main( void )
{
    
    vec3 average = vec3(0.0);
    for (float y = 0.0; y < 1.0; y += 1.0 / AA) {
        for (float x = 0.0; x < 1.0; x += 1.0 / AA) {
            vec2 p = (fragCoord + vec2(x, y) - iResolution.xy*.5) / iResolution.y;
            
            average += render(p);
        }
    }
    vec3 col = average / (AA * AA);
    

    gl_FragColor = vec4(col, 1.0);
}