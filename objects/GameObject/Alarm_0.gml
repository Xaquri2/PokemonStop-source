player = instance_find(PlayerObject, 0)
if (!instance_exists(player)) player = instance_create_layer(loadX, loadY, "Instances", PlayerObject)
else
{
	player.x = loadX
	player.y = loadY
}