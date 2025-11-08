event_inherited();
if (room == Mallet_Town)
if (!instance_exists(player)) player = instance_find(PlayerObject, 0)
else
{
	if (room == Mallet_Town)
	{
		if (player.x >= 540 and player.x <= 800)
		{
			if (point_distance(x,y,player.x,y) < 5) speed = 0
			else move_towards_point(player.x, y, 4)
		}
		else speed = 0
	}
}

if (instance_exists(player) and room == Mallet_Town and
player.hspeed != 0 and (player.x >= 540 and player.x <= 800))
{
	sprite_index = MaryWalkRightSprite
	image_speed = 1//sprite_get_speed(MaryWalkRightSprite)
	
	if (player.hspeed < 0) image_xscale = -1.7
	else image_xscale = 1.7
}
else 
{
	sprite_index = MaryWalkDownSprite
	image_index = 0
	image_speed = 0
	image_xscale = 1
}

if (keyboard_check(vk_shift)) speed = 0