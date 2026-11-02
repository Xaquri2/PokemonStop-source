if (view_current != 1) exit

gpu_push_state()
gpu_set_blendmode(bm_normal)
for (var i = 0; i < array_length(fadingElements); i++)
{
    var element = fadingElements[i]
    if (layer_get_element_type(element) != layerelementtype_sprite) continue
    draw_sprite_ext(layer_sprite_get_sprite(element), layer_sprite_get_index(element),
        layer_sprite_get_x(element), layer_sprite_get_y(element),
        layer_sprite_get_xscale(element), layer_sprite_get_yscale(element),
        layer_sprite_get_angle(element), layer_sprite_get_blend(element),
        layer_sprite_get_alpha(element))
}
gpu_pop_state()
