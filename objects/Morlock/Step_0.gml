event_inherited();

if (HasFlag(battleFlag)) instance_destroy()
else
{
	var player = instance_find(PlayerObject, 0)
	if (instance_exists(player) and point_distance(x,y,player.x,player.y) <= detectRange)
	{
		move_towards_point(player.x,player.y,walkSpeed)
		var spd = speed
		speed = 0
	
		hspeed = lengthdir_x(spd, point_direction(x,y,player.x,player.y))
		vspeed = lengthdir_y(spd, point_direction(x,y,player.x,player.y))

		if (RoomHasGravity())
		{
			if (vspeed < 3) vspeed += 1.5
		}
	
		if instance_exists(collision_rectangle(bbox_left+hspeed,bbox_top,
		bbox_right+hspeed,bbox_bottom,TiltedFloor,false,true))
		{
			if !instance_exists(collision_rectangle(x+hspeed,bbox_top-2,
			x+hspeed,bbox_bottom-5,TiltedFloor,false,true))
			{
				y -= 2
			}
			else hspeed = 0
		}
		if instance_exists(collision_rectangle(bbox_left,bbox_top+vspeed,
		bbox_right,bbox_bottom+vspeed,TiltedFloor,false,true))
		{
			vspeed = 0
		}

		if (point_distance(x,y,player.x,player.y) <= global.torchRange and global.torch and global.torchPower > 0)
		{
			move_towards_point(player.x,player.y,-walkSpeed)
		}
	}
	else
	{
	
	}

	if (!player.canWalk) speed = 0
}