event_inherited();
if (canFreePlayer)
{
	if (instance_number(BadgeObject) == 0)
	{
		ds_list_clear(textList)
		var player = instance_find(PlayerObject, 0)
		player.alarm[1] = 1
		canFreePlayer = false
		
		var warp = instance_create_layer(x,y+4,"Instances",WarpObject)
		with (warp) SetWarpDefaults("MinusOneToTower", "Down", false)
	}
}