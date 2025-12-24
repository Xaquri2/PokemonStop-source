// Inherit the parent event
event_inherited();

// Move toward the current target
var dx   = target_x - x;
var dy   = target_y - y;
var dist = point_distance(x, y, target_x, target_y);

if (dist > 0) {
    x += (dx / dist) * move_speed;
    y += (dy / dist) * move_speed;
}

// Have we reached (or passed) the target this step?
if (dist <= move_speed) {
    // snap exactly to the corner
    x = target_x;
    y = target_y;

    // advance to next direction around the square
    move_dir = (move_dir + 1) mod 4;

    switch (move_dir) {
        case 0: // RIGHT
            target_x = x + segment_length;
            target_y = y;
            sprite_index = TeamRocketWalkDownSprite;
            image_xscale = 1; // normal
            break;

        case 1: // DOWN
            target_x = x;
            target_y = y + segment_length;
            sprite_index = TeamRocketWalkDownSprite;
            image_xscale = 1;
            break;

        case 2: // LEFT
            target_x = x - segment_length;
            target_y = y;
            sprite_index = TeamRocketWalkDownSprite;
            image_xscale = -1; // flip horizontally
            break;

        case 3: // UP
            target_x = x;
            target_y = y - segment_length;
            sprite_index = TeamRocketWalkDownSprite;
            image_xscale = 1;
            break;
    }
}

