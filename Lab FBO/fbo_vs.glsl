#version 430            
uniform mat4 PVM;
uniform int pass;

in vec3 pos_attrib;
in vec2 tex_coord_attrib;
in vec3 normal_attrib;

out vec2 tex_coord;  
out flat int id;

vec3 offset[9] = {
vec3( 0.0, 0.0, 0.0),
vec3( 0.5, 0.0, 0.0),
vec3(-0.5, 0.0, 0.0),
vec3(0.0,  0.5, 0.0),
vec3(0.0, -0.5, 0.0),
vec3(0.5, 0.5, 0.0),
vec3(0.5, -0.5, 0.0),
vec3(-0.5, 0.5, 0.0),
vec3(-0.5, -0.5, 0.0)
};

void main(void)
{
	if(pass == 1 || pass == 2)
	{
		gl_Position = PVM*vec4(pos_attrib + offset[gl_InstanceID], 1.0);
		tex_coord = tex_coord_attrib;
		id = gl_InstanceID;
	}
	else
	{
		gl_Position = vec4(pos_attrib + offset[gl_InstanceID], 1.0);
		tex_coord = 0.5*pos_attrib.xy + vec2(0.5);
		id = gl_InstanceID;
	}
}