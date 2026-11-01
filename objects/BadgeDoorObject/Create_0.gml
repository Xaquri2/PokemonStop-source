event_inherited()
canFreePlayer = false

// Earned badges are authoritative, including for saves made before this fix.
var hasAllBadges = HasFlag("MutantBadge") and HasFlag("ShadowBadge") and HasFlag("RobotBadge")
if (hasAllBadges and HasFlag("TowerDoorHasOpened"))
{
    var warp = instance_create_layer(x,y,"Instances",WarpObject)
    with (warp) SetWarpDefaults("MinusOneToTower", "Down", false)
    instance_destroy(id)
}
else
{
    ds_list_add(textList, "You try to open it...")
    if (hasAllBadges)
    {
        ds_list_add(textList, "...the badges begin to resonate!")
    }
    else
    {
        ds_list_add(textList, "...but the door doesn't open.")
    }
}
