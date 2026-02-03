// Inherit the parent event
event_inherited();


/// obj_tektite : Draw
// //draw_sprite(sprite_index, image_index, x, y - z);

/// obj_tektite : Draw

// draw shadow on ground
if (sprite_shadow != noone) {
    draw_sprite(sprite_shadow, 0, x, y);
}

// draw tektite lifted by z
draw_sprite(sprite_index, image_index, x, y - z);



