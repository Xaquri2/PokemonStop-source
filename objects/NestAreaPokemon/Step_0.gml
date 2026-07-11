depth = -y

if (RoomHasGravity())
{
	if (vspeed < 3) vspeed += 1.5
}

#region Collision
var collidedTile = collision_rectangle(bbox_left+hspeed, bbox_bottom+vspeed,
bbox_right+hspeed, bbox_top+vspeed, CollisionParent, false, true)

if (instance_exists(collidedTile))
{
	if (collidedTile.object_index == TiltedFloor)
	{
		if (hspeed != 0) y -= 1
	}
	else
	{
		hspeed = 0
		vspeed = 0
	}
}

if (x+hspeed > room_width or x-hspeed < 0 or collision_rectangle(bbox_left+hspeed, bbox_bottom, bbox_right+hspeed, bbox_top, CollisionParent, false, true) != noone) hspeed = 0
if (y+vspeed > room_height or y-vspeed < 0 or collision_rectangle(bbox_left, bbox_bottom+vspeed, bbox_right, bbox_top+vspeed, CollisionParent, false, true) != noone) vspeed = 0
#endregion

if (state == "Walk")
{
	if (canWalk = false)
	{
		state = "Idle"
		walkCoords = []

		speed = 0
		image_xscale = abs(image_xscale)
		sprite_index = idleSprite
	}
	else
	{
		if (point_distance(x, y, walkCoords[0], walkCoords[1]) > 10)
		{
			move_towards_point(walkCoords[0], walkCoords[1], walkSpeed)
		}
		else
		{
			if (grassCounter < 3) 
			{
				var newGrass = GetNextNearestGrass()
				grassCounter++
				walkCoords = [newGrass.x+newGrass.sprite_width/2,newGrass.y+newGrass.sprite_height/2]
			}
			else
			{
				state = "Idle"
				walkCoords = []
				grassCounter = 0
				ds_list_clear(grassList)
				
				speed = 0
				image_xscale = abs(image_xscale)
				sprite_index = idleSprite
				alarm[0] = random_range(60*minWalkTimerValue, 60*maxWalkTimerValue)
			}
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
		if (hspeed > 0) image_xscale = abs(image_xscale)
		else image_xscale = -abs(image_xscale)
	}
	
	if (collision_rectangle(bbox_left+hspeed,bbox_top+vspeed,bbox_right+hspeed,bbox_bottom+vspeed,CollisionParent,false,true))
	{
		state = "Idle"
		walkCoords = []

		speed = 0
		image_xscale = abs(image_xscale)
		sprite_index = idleSprite
		alarm[0] = random_range(60*3, 60*6)
	}
	
	CheckForInterruptions()
}

if (room == NestAreaRoom)
{
	var grass = collision_point(bbox_left+sprite_width/2,bbox_bottom,GrassObject,false,true)
	if (grass != noone)
	{
		if (currentGrassSpot != grass)
		{
			currentGrassSpot = grass
			if 1 == 1//(irandom(1) == 1)
			{
				//if (image_alpha == 0) image_alpha = 1
				//else image_alpha = 0
			
				repeat(3)
				{
					var grassPart = instance_create_depth(grass.x, grass.y, grass.depth+1,GrassParticle)
					grassPart.hspeed = random_range(-1,1)
					grassPart.vspeed = random_range(-2,-1)
				}
			}
		}
		else
		{
			if (alarm[10] == -1)
			{
				alarm[10] = 60*2
			}
		}
	}
	else
	{
		currentGrassSpot = noone
		image_alpha = 1
	}
}