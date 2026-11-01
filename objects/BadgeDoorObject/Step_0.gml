event_inherited();
if (canFreePlayer)
{
	if (instance_number(BadgeObject) == 0)
	{
		ds_list_clear(textList)
		var player = instance_find(PlayerObject, 0)
		player.alarm[1] = 1
		canFreePlayer = false
		
        // Never turn a partial badge animation into an entrance.
        if (HasFlag("MutantBadge") and HasFlag("ShadowBadge") and HasFlag("RobotBadge"))
        {
            ds_list_clear(global.activatedBadges)
            ds_list_add(global.activatedBadges, "MutantBadge", "ShadowBadge", "RobotBadge")
            var warp = instance_create_layer(x,y,"Instances",WarpObject)
            with (warp) SetWarpDefaults("MinusOneToTower", "Down", false)
            instance_destroy(id)
        }
    }
}
