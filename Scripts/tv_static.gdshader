shader_type spatial;
render_mode unshaded, cull_disabled;

uniform float noise_scale : hint_range(10.0, 500.0) = 200.0;  // controls pixel density
uniform float contrast : hint_range(0.0, 2.0) = 1.5;      
uniform float flicker_speed : hint_range(0.1, 5.0) = 0.5; 
uniform sampler2D text_texture : source_color;  // your Krita PNG
uniform float text_blend : hint_range(0.0, 1.0) = 0.8; // text visibility

float rand(vec2 co) {
    return fract(sin(dot(co.xy, vec2(12.9898, 78.233))) * 43758.5453);
}

void fragment() {
    // Use UV coordinates scaled for pixel density
    vec2 uv = UV * 50.0;

    // Flicker time step
    float t = floor(TIME * flicker_speed); 
    float noise = rand(floor(uv) + vec2(t, t * 0.33));
    noise = pow(noise, contrast);

    // Text overlay
    vec4 text_col = texture(text_texture, UV); 
    float text_mask = text_col.a; // alpha channel
    float combined = mix(noise, text_mask, text_blend);

    ALBEDO = vec3(combined);
}
