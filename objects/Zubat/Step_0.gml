// Inherit the parent event
event_inherited();


if (point_distance(x, y, PlayerObject.x,PlayerObject.y) < 400) {
	flying = true;
}
else { 
	flying = false; 
}

if flying == true {
	x = lerp(x, PlayerObject.x, 0.05)
	y = lerp(y, PlayerObject.y, 0.05)
	image_index = ZubatFlappingSprite
}
else {
	if x > xstart {
		x = lerp(x, xstart, 0.05)
	}
	if y > ystart {
		y = lerp(y, ystart, 0.05)
	}
	if x < xstart {
		x = lerp(x, xstart, 0.05)
	}
	if y < ystart {
		y = lerp(y, ystart, 0.05)
	}
	if (x == xstart) && (y == ystart) {
		image_index = ZubatIdleSprite
	}
}
	
