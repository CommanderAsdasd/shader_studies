//https://www.youtube.com/watch?v=yxNnRSefK94
// Read about raymarching
// NOTE
// Matrix of rotation


float map(vec3 p) {
    
    vec3 q = fract(p) * 2.0 - 1.0;
 
    return length(q) - 0.25;
}


float trace(vec3 o, vec3 r) {
    
    float t = 0.0;
    for (int i = 0; i < 32; i++) {
        vec3 p = o + r * t;
        float d = map(p);
        t += d * 0.5;
    }
    return t;
}


void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normalized pixel coordinates (from 0 to 1)
    vec2 uv = fragCoord/iResolution.xy;
    
    uv = uv * 2.0 - 1.0;
    uv.x *= iResolution.x / iResolution.y;

    // Time varying pixel color
    vec3 col = 0.5 + 0.5*cos(iTime+uv.xyx+vec3(0,2,4));
    
    vec3 r = normalize(vec3(uv, 1.0));
    
    float the = iTime * 0.25;
    r.xz *= mat2(cos(the), -sin(the), sin(the), cos(the));
    
    vec3 o = vec3(0.0, iTime, iTime);
    float t = trace(o, r);
    
    float fog = 1.0 / (1.0 + t * t * 0.1);
    
    vec3 fc = vec3(fog);

    // Output to screen
    fragColor = vec4(fc,1.0);
}