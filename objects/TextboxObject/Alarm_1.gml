if (instance_exists(actionNPC) and !ds_list_empty(actionNPC.trainerTeam) and ds_list_find_index(global.beatenTrainers, actionNPC.name) == -1)
{
	if (actionNPC.object_index != Morlock) 
	{
		startBattle = true
	}
}
else
{
	player.alarm[1] = 1
}

if (item != "") AddItem(item, itemCount)
instance_destroy(id)
