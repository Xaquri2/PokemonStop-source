// how far each side of the square is
segment_length = 64;

// movement speed (pixels per step) – tweak as you like
move_speed = 1.5;

// 0 = right, 1 = down, 2 = left, 3 = up
move_dir = 0;

// first leg: move to the right
target_x = x + segment_length;
target_y = y;

// sprite for moving right
sprite_index = PacGhostOverworldSprite;
image_xscale = 1;
