event_inherited();
if (canFreePlayer)
{
	if (instance_number(BadgeObject) == 0)
	{
		ds_list_clear(textList)
		var player = instance_find(PlayerObject, 0)
		player.alarm[1] = 1
		canFreePlayer = false
	}
}