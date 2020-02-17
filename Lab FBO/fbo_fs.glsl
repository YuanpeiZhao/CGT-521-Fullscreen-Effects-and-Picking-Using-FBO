#version 430

uniform sampler2D texture;
uniform int pass;
uniform int blur;
uniform int edgeDetect;
uniform int pickedID;

out vec4 fragcolor;           
in vec2 tex_coord;
in flat int id;

vec3 IDToColor(int id){
	return vec3((id+1)/10.0f);
}

int ColorToID(vec3 color){
	return int(color.r * 10.0f)-1;
}
      
void main(void)
{   
	if(pass == 1)
	{
		if(pickedID == id){
			fragcolor = 2.0f * texture2D(texture, tex_coord);
		}
		else{
			fragcolor = texture2D(texture, tex_coord);
		}
	}

	else if(pass == 2)
	{
		fragcolor = vec4(IDToColor(id), 1.0f);
	}

	else if(pass == 3)
	{
		//Lab assignment: Use texelFetch function and gl_FragCoord instead of using texture coordinates when reading from texture.

		if(edgeDetect == 0){
			fragcolor = texelFetch(texture, ivec2(gl_FragCoord.xy), 0);
		}
		else{
			vec4 color = texelFetch(texture, ivec2(gl_FragCoord.xy), 0);
			vec4 above = texelFetch(texture, ivec2(gl_FragCoord.xy + vec2(0.0f, 1.0f)), 0);
			vec4 below = texelFetch(texture, ivec2(gl_FragCoord.xy - vec2(0.0f, 1.0f)), 0);
			vec4 right = texelFetch(texture, ivec2(gl_FragCoord.xy + vec2(1.0f, 0.0f)), 0);
			vec4 left  = texelFetch(texture, ivec2(gl_FragCoord.xy - vec2(1.0f, 0.0f)), 0);

			fragcolor = (left - right)*(left - right) + (above - below)*(above - below);
		}
	}
	else
	{
		fragcolor = vec4(1.0, 0.0, 1.0, 1.0); //error
	}

}




















