if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charNumber = string_length(ds_list_find_value(textList, currentText))
	charCounter = 0
}
else
{
	if (currentText+1 >= ds_list_size(textList))
	{
		instance_destroy(id)
	}
	else
	{
		currentText++
		charCounter = 0
		charNumber = 0
	}
	
	var text = ds_list_find_value(textList, currentText)
	if (string_count(" sent out ", text) > 0)
	{
		var enemy = -1
		for (var i = 0; i < instance_number(BattleEntityObject); i++)
		{
			enemy = instance_find(BattleEntityObject, i)
			if (enemy.player) enemy = -1
			else break
		}
		
		if (enemy != -1)
		{
			enemy.hspeed = enemy.moveSpeed
			enemy.alarm[0] = 100
		}
	}
	else if (string_count("Go!", text) > 0)
	{
		var player = -1
		for (var i = 0; i < instance_number(BattleEntityObject); i++)
		{
			player = instance_find(BattleEntityObject, i)
			if (!player.player) player = -1
			else break
		}
		
		if (player != -1)
		{
			player.hspeed = player.moveSpeed
			player.alarm[0] = 100
		}
	}
}