depth = -y

hover_time += 1;

// gentle up/down
y_offset = sin(hover_time * hover_speed) * hover_height;

// gentle side-to-side rotation
image_angle = sin(hover_time * rock_speed) * rock_angle;

// apply the hovering movement by offsetting from the object's base Y
y = ystart + y_offset;
