uniform sampler2D ShadowMap;
varying vec4 ShadowCoord;
varying vec3 myNormal;
varying vec4 myVertex;
uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat4 normalMatrix;
uniform vec4 light0_position;
uniform vec4 light0_color;

vec4 ComputeLight(const in vec3 eyeV, const in vec3 direction, const in vec4 lightcolor, const in vec3 normal, const in vec3 halfvec){
    
    vec3 w = vec3(1, 1, 1);
    vec3 p = vec3(20, 2, 1);//vec3(1, 1, 1);//vec3(20, 2, 1);
    
    //R = 2 * (I . N) * N - I
    float nDotL = dot(normal, direction);
    vec3 reflection = normalize((2.0 * normal * nDotL) - direction);
    
    float eDotR = dot (eyeV, reflection);//halfvec);
    float myColor1 = w.x * pow( ((eDotR+1.0)/2.0), p.x );//for each color
    float myColor2 = w.y * pow( ((eDotR+1.0)/2.0), p.y );//for each color
    float myColor3 = w.z * pow( ((eDotR+1.0)/2.0), p.z );//for each color
    vec4 retval = vec4(floor(myColor1+0.5), floor(myColor2+0.5), floor(myColor3+0.5), 0);//add computed colors into vector
    return retval;
    
}

void main()
{
    
    const vec3 eyepos = vec3(32,20,0);
    vec4 _mypos = modelViewMatrix * myVertex;
    vec3 mypos = _mypos.xyz / _mypos.w;
    vec3 eyedirn = normalize(vec3(2,0,-10));//eyepos - mypos);
    
    // Compute normal, needed for shading.
    vec4 _normal = normalMatrix * vec4(myNormal, 0.0);
    vec3 normal = normalize(_normal.xyz);
    
    // Light 0, point
    vec3 position0 = light0_position.xyz / light0_position.w;
    vec3 direction0 = normalize (position0 - mypos);
    vec3 half0 = normalize(direction0 + eyedirn);
    vec4 color0 = ComputeLight(eyedirn, direction0, light0_color, normal, half0) ;
  

	vec4 shadowCoordinateWdivide = ShadowCoord / ShadowCoord.w ;
	//self-shadowing
	shadowCoordinateWdivide.z += 0.0005;
	
	
	float distanceFromLight = texture2D(ShadowMap,shadowCoordinateWdivide.st).z;
	
	
 	float shadow = 1.0;
 	if (ShadowCoord.w > 0.0)
 		shadow = distanceFromLight < shadowCoordinateWdivide.z ? 0.5 : 1.0 ; //calculate shadow offset for shading
  	
	
    gl_FragColor =	 shadow * gl_Color;
  
}



