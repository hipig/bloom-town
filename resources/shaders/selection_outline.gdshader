shader_type canvas_item;

uniform float outline_width : hint_range(0, 5) = 0.0;
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec2 uv = UV;
    vec4 color = texture(TEXTURE, uv);
    
    // 采样周围的像素来检测边缘
    float alpha = color.a;
    float outline_alpha = 0.0;
    
    for (int x = -2; x <= 2; x++) {
        for (int y = -2; y <= 2; y++) {
            vec2 offset = vec2(float(x), float(y)) * outline_width * 0.01;
            vec4 neighbor = texture(TEXTURE, uv + offset);
            if (neighbor.a > 0.0 && alpha == 0.0) {
                outline_alpha = 1.0;
            }
        }
    }
    
    if (outline_alpha > 0.0 && alpha == 0.0) {
        COLOR = outline_color;
    } else {
        COLOR = color;
    }
}