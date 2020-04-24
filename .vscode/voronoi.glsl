// uniform vec2 iResolution;
// uniform vec2 iMouse;
// uniform float iTime;

void main(){
    vec2 st=gl_FragCoord.xy/iResolution.xy;
    st.x *= iResolution.x/iResolution.y;

    vec3 color = vec3(.0);
    vec2 point[5];
    point[0]=vec2(.83,.75);
    point[1]=vec2(.60,.07);
    point[2]=vec2(.28,.64);
    point[3]=vec2(.31,.26);
    point[4]=iMouse.xy/iResolution.xy;
    
    float m_dist=1.;
    
    for(int i=0;i<5;i++){
        float dist=distance(st,point[i]);
        
        // Keep the closer distance
        m_dist=min(m_dist,dist);
    }

    color += m_dist;
    gl_FragColor = vec4(color,1.0);
    
}