if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charNumber = string_length(ds_list_find_value(textList, currentText))
	charCounter = 0
}
else
{
	//Make sound when moving to next text or closing
	if (currentText+1 >= ds_list_size(textList))
	{
		if (instance_exists(actionNPC) and !ds_list_empty(actionNPC.trainerTeam) and ds_list_find_index(global.beatenTrainers, actionNPC.name) == -1) 
		{
			startBattle = true
		}
		else
		{
			player.alarm[1] = 1
		}
		
		if (item != "") AddItem(item, itemCount)
		instance_destroy(id)
	}
	else
	{
		//Make sound only when moving to next text (wont work when closing)
		currentText++
		charCounter = 0
		charNumber = 0
	}
}