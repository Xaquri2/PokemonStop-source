// Inherit the parent event
//event_inherited();


/// obj_tektite : Draw
// //draw_sprite(sprite_index, image_index, x, y - z);


/// obj_tektite : Draw

var leap_scale   = 1.6;  // <— change this number to resize the airborne sprite
var shadow_scale = 0.7;  // <— size of the shadow

// draw shadow
draw_sprite_ext(sprite_shadow, 0, x, y,
                shadow_scale, shadow_scale,
                0, c_black, 0.6);

// draw leaping body
draw_sprite_ext(sprite_index, image_index, x, y - z,
                leap_scale, leap_scale,
                image_angle, image_blend, image_alpha);




