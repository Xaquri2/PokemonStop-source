event_inherited();
if (HasFlag("MaryRivalBattle2")) instance_destroy(self)

//if (HasFlag("MaryRivalBattle1")) {
//	global.followerType = "Mary"
//	instance_destroy(id)
//}
if (room == Mallet_Town)
if (!instance_exists(player)) player = instance_find(PlayerObject, 0)
else
{	if (HasFlag("MaryRejected")) {}
	else {
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
}

if (HasFlag("MaryRejected")) {
	if (x > 575) {
		x = lerp(x,540,0.01)
		sprite_index = MaryWalkRightSprite
		image_speed = 2
		image_xscale = -1.2
	}
	else {
		x = 574
		speed = 0
		sprite_index = MaryWalkDownSprite
		image_speed = 0.5
	}
}
else {
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
}
if (keyboard_check(vk_shift)) speed = 0
