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
				var text = ds_list_find_value(textList, currentText)
				if (string_count("used", text) > 0) 
				{
					if (string_count("opposing", text) == 0) whoAttacked = "Player"
					alarm[1] = GetMoveAnimationTime(moveName)
				}

				if (string_count(" sent out ", text) > 0) //Enemy pokémon released
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
				else if (string_count("Go!", text) > 0) //Player pokémon released
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
				else if (string_count("opposing", text) == 0 //Player pokémon fainted
				and string_count("fainted", text) > 0) 
				{
					var playerPkmnEntity = -1
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						var attempt = instance_find(BattlePokemonObject, i)
						if (attempt.playerTeam)
						{
							playerPkmnEntity = attempt
							break
						}
					}
			
					if (playerPkmnEntity != -1)
					{
						alarm[3] = 100
						playerPkmnEntity.alarm[1] = 100
					}
				}
				else if (string_count("opposing", text) > 0 //Enemy pokémon fainted
				and string_count("fainted", text) > 0) 
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
						alarm[3] = 100
						enemyPkmnEntity.alarm[1] = 100
					}
				}
				else if (string_count("opposing", text) > 0 //Oponent attack
				and string_count("used", text) > 0)
				{
					whoAttacked = "Enemy"
					moveName = ChooseMove(enemyPkmn, playerPkmn)
					alarm[1] = GetMoveAnimationTime(moveName)
				}
			}
		}
	}
}