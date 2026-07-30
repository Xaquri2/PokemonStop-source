// Inherit the parent event
event_inherited();

image_speed = 5

if flying == true {
	sprite_index = ZubatFlappingSprite
	image_angle = (180/3.141592653575)*(arccos((point_distance(x,y,PlayerObject.x,y))/(point_distance(x,y,PlayerObject.x,PlayerObject.y))))
	
}
else {
	if (x == xstart) && (y == ystart) {
		sprite_index = ZubatIdleSprite
	}
}
