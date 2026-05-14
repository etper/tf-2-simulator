shader_type canvas_item;

uniform float saturation = 0.0;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    float gray = (tex.r + tex.g + tex.b) / 3.0;

    vec3 color = mix(vec3(gray), tex.rgb, saturation);

    COLOR = vec4(color, tex.a);
}