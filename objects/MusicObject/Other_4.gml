var battle = instance_find(BattleObject, 0)
if (instance_exists(battle))
{
	if (video_get_status() != video_status_playing)
	{
		alarm[0] = 2
	}
}
else
{
	alarm[0] = 2
}