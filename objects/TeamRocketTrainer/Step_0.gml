if (!triggered)
{
	if (moveType == "Vertical")
	{
		if (moveDir > 0)
		{
			vspeed = 1
			lineSightDir = "Down"
		}
		else
		{
			vspeed = -1
			lineSightDir = "Up"

		}
	}
	else if (moveType == "Horizontal")
	{
		if (moveDir > 0)
		{
			hspeed = 1
			lineSightDir = "Right"
		}
		else
		{
			hspeed = -1
			lineSightDir = "Left"

		}
	}
	
	if (collision_rectangle(bbox_left,bbox_top+vspeed,bbox_right,bbox_bottom+vspeed,CollisionObject,false,true) != noone)
	{
		moveDir *= -1
		alarm[3] = walkTime
	}
	
	startX = bbox_left
	startY = bbox_top
	finalX = bbox_right
	finalY = bbox_bottom
	
	switch (lineSightDir)
	{
		case "Up":
			startY -= lineSight
			break
		case "Down":
			finalY += lineSight
			break
		case "Right":
			finalX += lineSight
			break
		case "Left":
			startX -= lineSight
			break
	}
}

event_inherited();