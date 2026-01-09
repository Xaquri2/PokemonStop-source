event_inherited()
canFreePlayer = false

if (ds_list_size(global.activatedBadges) != 3)
{
	ds_list_add(textList, "You try to open it...")
	if ((HasFlag("MutantBadge") and ds_list_find_index(global.activatedBadges, "MutantBadge") == -1)
	or (HasFlag("ShadowBadge") and ds_list_find_index(global.activatedBadges, "ShadowBadge") == -1)
	or (HasFlag("RobotBadge") and ds_list_find_index(global.activatedBadges, "RobotBadge") == -1))
	{
		ds_list_add(textList, "...the badges begin to resonate!")
		if (HasFlag("MutantBadge") and ds_list_find_index(global.activatedBadges, "MutantBadge") != -1)
		{
			ds_list_add(global.activatedBadges, "MutantBadge")
		}
		if (HasFlag("ShadowBadge") and ds_list_find_index(global.activatedBadges, "MutantBadge") != -1)
		{
			ds_list_add(global.activatedBadges, "ShadowBadge")
		}
		if (HasFlag("RobotBadge") and ds_list_find_index(global.activatedBadges, "MutantBadge") != -1)
		{
			ds_list_add(global.activatedBadges, "RobotBadge")
		}
	}
	else
	{
		ds_list_add(textList, "...but the door doesn't open.")
	}
}
else
{
	var warp = instance_create_layer(x,y,layer,WarpObject)
	with (warp) SetWarpDefaults("MinusOneToTower", "Down", false)
}