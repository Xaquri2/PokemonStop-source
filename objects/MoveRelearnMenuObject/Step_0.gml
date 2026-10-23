if (moveList != noone and ds_list_empty(moveList))
{
	instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter))
{
	ds_list_replace(GetMoves(pkmnInfo), replaceIndex, ds_list_find_value(moveList, currentMove))
	if instance_exists(PlayerObject) 
	{
		PlayerObject.canWalk = true
		PlayerObject.menuOpen = false
		instance_destroy(MenuObject)
		instance_destroy(id)
	}
}
else
{
	if (moveList != noone and !ds_list_empty(moveList))
	{
		if (keyboard_check_pressed(ord("W"))) currentMove--
		if (keyboard_check_pressed(ord("S"))) currentMove++

		if (currentMove < 0) currentMove = ds_list_size(moveList)-1
		if (currentMove >= ds_list_size(moveList)) currentMove = 0
	}
}