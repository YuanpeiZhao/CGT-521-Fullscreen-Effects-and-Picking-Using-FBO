#version 400

uniform sampler2D texture;
uniform int pass;
uniform int blur;

out vec4 fragcolor;           
in vec2 tex_coord;
      
void main(void)
{   
	if(pass == 1)
	{
		fragcolor = texture2D(texture, tex_coord);
	}
	else if(pass == 2)
	{
		//Lab assignment: Use texelFetch function and gl_FragCoord instead of using texture coordinates when reading from texture.
		vec4 color = texelFetch(texture, ivec2(gl_FragCoord.xy), 0);
		vec4 above = texelFetch(texture, ivec2(gl_FragCoord.xy + vec2(0.0f, 1.0f)), 0);
		vec4 below = texelFetch(texture, ivec2(gl_FragCoord.xy - vec2(0.0f, 1.0f)), 0);
		vec4 right = texelFetch(texture, ivec2(gl_FragCoord.xy + vec2(1.0f, 0.0f)), 0);
		vec4 left  = texelFetch(texture, ivec2(gl_FragCoord.xy - vec2(1.0f, 0.0f)), 0);

		fragcolor = (left - right)*(left - right) + (above - below)*(above - below);

	}
	else
	{
		fragcolor = vec4(1.0, 0.0, 1.0, 1.0); //error
	}

}




















