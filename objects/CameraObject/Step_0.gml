if (player != noone)
{
	x = lerp(x, player.x, 0.2)
	y = lerp(y, player.y, 0.2)
}
else
{
	var attempt = instance_find(PlayerObject, 0)
	if (instance_exists(attempt)) player = attempt
}