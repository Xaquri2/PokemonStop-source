shader_set(Shader1);

// UNIFORMS
shader_set_uniform_f(u_line_color, 0, 0, 0, 1);   // black outline

var tex_w = sprite_get_width(sprite_index);
var tex_h = sprite_get_height(sprite_index);
shader_set_uniform_f(u_pixel_size, 1/tex_w, 1/tex_h);

// thickness, roundness, tolerance
shader_set_uniform_f(u_thk_rn_tol, 8.0, 1.0, 0.0);

// UV bounds for this sprite
var uvs = sprite_get_uvs(sprite_index, image_index);
shader_set_uniform_f(u_uv, uvs[0], uvs[1], uvs[2], uvs[3]);

// DRAW SPRITE
draw_self();

shader_reset();
