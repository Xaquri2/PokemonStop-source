
hover_time += 1;

// gentle left/right
x_offset = -cos(hover_time * hover_speed) * hover_height;
y_offset = -sin(hover_time * hover_speed) * hover_height;

// apply the hovering movement by offsetting from the object's base Y
y = ystart + y_offset;
x = xstart + x_offset;
