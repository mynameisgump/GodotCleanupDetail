shader_type spatial;
//render_mode cull_disabled;  

uniform sampler2D noise;
uniform float floorThreshhold = 1;
uniform float floorValue = 0.07;
uniform float cavityThreahold = 1.14;
uniform float cavityValue = 1.4;

void vertex()
{
    vec4 textur = texture(noise, UV);
    float value = textur.r;
    value += sqrt(value);
    if(value < floorThreshhold)
    {
        value = floorValue + value;
    }
    else if(value < cavityThreahold)
    {
        value = cavityValue;
    }
    VERTEX += vec3(0,value,0);
}
