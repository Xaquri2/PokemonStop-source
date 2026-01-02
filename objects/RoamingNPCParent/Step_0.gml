event_inherited();
if (state == "Walk")
{
	if (canWalk = false)
	{
		state = "Idle"
		walkCoords = []

		speed = 0
		image_xscale = 1
		sprite_index = idleSprite
	}
	else
	{
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
			sprite_index = idleSprite
			alarm[0] = random_range(60*3, 60*6)
		}
	}
}

if (speed != 0)
{
	if (abs(vspeed) > abs(hspeed))
	{
		if (vspeed > 0) sprite_index = walkDownSprite
		else sprite_index = walkUpSprite
	}
	else
	{
		sprite_index = walkRightSprite
		if (hspeed > 0) image_xscale = 1
		else image_xscale = -1
	}
	
	if (collision_rectangle(bbox_left+hspeed,bbox_top+vspeed,bbox_right+hspeed,bbox_bottom+vspeed,CollisionParent,false,true))
	{
		state = "Idle"
		walkCoords = []

		speed = 0
		image_xscale = 1
		sprite_index = idleSprite
		alarm[0] = random_range(60*3, 60*6)
	}
}
