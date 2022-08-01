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
            //hex colors pulled from decompiled game so they're accurate
            case 0xE84F58:
                vertexColor = vec4(0); //set to invisible
            break;
        }
    }
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);
}