if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charNumber = string_length(ds_list_find_value(textList, currentText))
	charCounter = 0
}
else
{
	if (instance_number(ImportantElementParent) == 0 and alarm[3] < 0)
	{
		if (currentText+1 >= ds_list_size(textList))
		{
			alarm[0] = 15
		}
		else
		{
			if (alarm[1] < 0)
			{
				currentText++
				charCounter = 0
				charNumber = 0
				var newText = ds_list_find_value(textList, currentText)
				var count = string_count("used", newText)
				if (count > 0) 
				{
					whoAttacked = "Player"
					alarm[1] = GetMoveAnimationTime(moveName)
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
						if (enemy.currentPkmn == 0)
						{
							enemy.hspeed = enemy.moveSpeed
							enemy.alarm[0] = 100
							enemy.alarm[1] = 1
						}
						else
						{
							enemy.alarm[2] = 1
						}
					}
				}
				else if (string_count("Go!", text) > 0)
				{
					var player = -1
					for (var i = 0; i < instance_number(BattleEntityObject); i++)
					{
						player = instance_find(BattleEntityObject, i)
						if (player.player) break
					}
	
					if (player != -1)
					{
						player.hspeed = player.moveSpeed
						player.alarm[0] = 100
						player.alarm[1] = 1
					}
				}
				else if (string_count("opposing", ds_list_find_value(textList, currentText+1)) > 0
				and string_count("used", ds_list_find_value(textList, currentText+1)) == 0)
				{
					var enemyPkmnEntity = -1
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						var attempt = instance_find(BattlePokemonObject, i)
						if (!attempt.playerTeam)
						{
							enemyPkmnEntity = attempt
							break
						}
					}
			
					if (enemyPkmnEntity != -1)
					{
						alarm[3] = 120
						enemyPkmnEntity.alarm[1] = 120
					}
				}
				else if (string_count("opposing", ds_list_find_value(textList, currentText+1)) > 0
				and string_count("used", ds_list_find_value(textList, currentText+1)) > 0)
				{
					whoAttacked = "Enemy"
					alarm[1] = GetMoveAnimationTime(moveName)
				}
			}
		}
	}
}