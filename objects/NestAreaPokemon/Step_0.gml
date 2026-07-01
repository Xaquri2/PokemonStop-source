event_inherited();

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
				if (image_alpha == 0) image_alpha = 1
				else image_alpha = 0
			
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