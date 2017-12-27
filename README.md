Bijan Hamidi
CPSC 486
Shadows

—Summary—
This project renders shadows using OpenGL.  Shadows are accomplished by using buffers to store attributes of vertexes then propagated through the graphics pipeline and shaded according to buffer attributes to create the effect.

This effect is accomplished by first rendering the scene from the lights point of view.  This is an off-screen render.  From this perspective the scene is generated in memory and the depth buffer is used to store these values in a shadow map.  

Once the first render pass has completed we then render from the perspective of the camera.  All vertices are transformed as normal through the graphics pipeline with the addition of a varying vec4 shadowPosition and a uniform shadowMap. These values are used to check the position of the vertex and see if the current vertex is closer than the one in the shadow map.  Shadow is then applied if the current vertex is not one that has been seen before.  

—Overview, Experience, and Lessons Learned—
Since OpenGL does not have FBO core in version 2.1 I had started with an online tutorial that I found featuring windows.h (This project was done by following an online tutorial 
http://fabiensanglard.net/shadowmapping/index.php).  This tutorial was heavily referenced from on many different forums so I thought it would be a good place to get started.  After following the instructions of the tutorial I started to explore the method of how the frame buffer object was created.  I had done research on how to create buffers which I understood as three basic steps.  
1. Generating the buffers and passing by reference an ID.
2. Creating a binding a point to the buffer which helps to link the data to the ID of that buffer.
	-In the case of this tutorial the binding point is GL_FRAMEBUFFER_EXT
3. Copy vertex/pixel attributes to the buffer with glBufferData. 
	- glFramebufferTexture2DEXT
Overall I found the use of the windows extension to be excessive.  While this method did produce results, I was not happy with this tutorial as I did not want to use this method to create a FBO as it required a lot of setup to create the FBO which is very unnecessary from other FBO examples that I have seen.  
My next goal was to try and remove the windows.h dependency.  I noted to properly use FBOs it would require a newer version of openGL.  However, I wanted to keep 2.1 for my work environment since I am used to that and I was concerned about other projects I am working on using 2.1, so I decided to try using 2.1’s pixel buffer object.  From here I found some helpful information at http://songho.ca/opengl/gl_vbo.html#create which explained vertex buffers which pixel buffers are derived from.  Unfortunately, I had many issues in my attempt that I could not resolve in time. 





