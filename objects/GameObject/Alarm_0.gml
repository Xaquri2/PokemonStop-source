if (global.morlockTimer > 0 and !instance_exists(Obj_Lighting_City3))
{
	instance_create_depth(0, 0, -1000000, Obj_Lighting_City3)
}
player = instance_find(PlayerObject, 0)
if (!instance_exists(player)) player = instance_create_layer(loadX, loadY, "Instances", PlayerObject)
else
{
	player.x = loadX
	player.y = loadY
}
