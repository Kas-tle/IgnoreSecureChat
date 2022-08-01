#version 150

// Modifications by Godlander

in vec3 Position;
in vec4 Color;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;

out vec4 vertexColor;

bool rougheq(vec3 a, vec3 b) {
    return all(lessThan(abs(a - b), vec3(0.01)));
}
int toint(ivec3 v) {
    return v.x<<16 | v.y<<8 | v.z;
}

void main() {
    vertexColor = Color;
    //remove bars on left side of chat
    if (Position.x <= 2 && Position.z == 50) { //only check 2 gui pixels on left edge of screen, at depth 50
        switch (toint(ivec3(Color.rgb*255))) {
            //hex colors pulled from decompiled game so theyr accurate
            case 0xE6AF49:
            case 0x77B3E9:
            case 0xA0A0A0:
            case 0xE84F58:
            case 0xEAC864:
                vertexColor = vec4(0); //set to invisible
            break;
        }
    }
    //scrollbar
    vec3 pos = Position;
    if (Position.z == 0 && Color.a < 1) {
        //remove blue part
        if (rougheq(Color.rgb, vec3(51,51,170)/255.)) {vertexColor = vec4(0);}
        //move gray part 2 gui pixels to the right
        if (rougheq(Color.rgb, vec3(204)/255.)) {pos.x += 2; vertexColor = vec4(0.7);}
    }
    gl_Position = ProjMat * ModelViewMat * vec4(pos, 1.0);
}