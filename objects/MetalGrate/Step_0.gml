// Inherit the parent event
event_inherited();
if (moving) {
	x = lerp(x, target_x, 0.050);
	y = lerp(y, target_y, 0.050);

	// snap when close so it doesn't "float" forever
	if (point_distance(x, y, target_x, target_y) < 0.5) {
	    x = target_x;
	    y = target_y;
		moving = false;
	}


}