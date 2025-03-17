if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charNumber = string_length(ds_list_find_value(textList, currentText))
	charCounter = 0
}
else
{
	if (currentText+1 >= ds_list_size(textList))
	{
		var player = instance_find(PlayerObject, 0)
		if (!ds_list_empty(actionNPC.trainerTeam)) 
		{
			player.talking = false
			player.canWalk = false
			player.battle = true
			var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
			battleObj.enemyTeam = actionNPC.trainerTeam
			battleObj.enemySprite = object_get_sprite(actionNPC.object_index)
			battleObj.enemyName = name
		}
		else
		{
			player.alarm[1] = 1
		}
		instance_destroy(id)
	}
	else
	{
		currentText++
		charCounter = 0
		charNumber = 0
	}
}