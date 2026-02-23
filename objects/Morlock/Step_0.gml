event_inherited();

var player = instance_find(PlayerObject, 0)
if (instance_exists(player) and point_distance(x,y,player.x,player.y) <= detectRange)
{
	move_towards_point(player.x,player.y,walkSpeed)
	if (point_distance(x,y,player.x,player.y) <= global.torchRange and global.torch and global.torchPower > 0)
	{
		move_towards_point(player.x,player.y,-walkSpeed)
	}
}

if (!player.canWalk) speed = 0