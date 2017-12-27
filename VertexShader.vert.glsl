varying vec4 ShadowCoord;
varying vec3 myNormal;
varying vec4 myVertex;
//uniform mat4 modelViewMatrix;
//uniform mat4 projectionMatrix;

void main()
{
     	ShadowCoord = gl_TextureMatrix[7] * gl_Vertex;
		gl_Position = ftransform(); //gl_Position = projectionMatrix * modelViewMatrix * gl_Vertex;
		gl_FrontColor = gl_Color;
    
        myNormal = gl_Normal;
        myVertex = gl_Vertex;
}

