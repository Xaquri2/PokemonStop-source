//draw_sprite_stretched(sprite_index, floor(image_index), 0, 0, 916, 916);
var gw = display_get_gui_width();
var gh = display_get_gui_height();

draw_sprite_stretched(
    sprite_index,
    floor(image_index),
    0, 0,
    gw, gh
);
