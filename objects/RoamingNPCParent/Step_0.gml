event_inherited();
if (state == "Walk")
{
	if (canWalk = false)
	{
		state = "Idle"
		walkCoords = []
		
		speed = 0
		image_xscale = 1
		sprite_index = Human2IdleSprite
	}
	
	if (point_distance(x, y, walkCoords[0], walkCoords[1]) > 10)
	{
		move_towards_point(walkCoords[0], walkCoords[1], 1)	
	}
	else
	{
		state = "Idle"
		walkCoords = []
		
		speed = 0
		image_xscale = 1
		sprite_index = Human2IdleSprite
		alarm[0] = random_range(60*6, 60*10)
	}
}
else if (state == "Idle")
{
	alarm[0] = -1
}

if (speed != 0)
{
	if (abs(vspeed) > abs(hspeed))
	{
		if (vspeed > 0) sprite_index = Human2WalkDownSprite
		else sprite_index = Human2WalkUpSprite
	}
	else
	{
		sprite_index = Human2WalkRightSprite
		if (hspeed > 0) image_xscale = 1
		else image_xscale = -1
	}
}