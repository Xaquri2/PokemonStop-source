if (ds_list_find_value(textList, currentText+1) != undefined and !catching and !switching)
{
	currentText++
	charCounter = 0
	charNumber = 0

	if (instance_number(ImportantElementParent) == 0 and alarm[3] < 0 and !expGaining)
	{
		if (currentText+1 > ds_list_size(textList))
		{
			alarm[0] = 15
		}
		else
		{
			if (alarm[1] < 0)
			{
				var text = ds_list_find_value(textList, currentText)
				if (string_count("used", text) > 0) //Player and enemy attacks
				{
					if (string_count("You", text) > 0)
					{
						whoAttacked = "Enemy" //This is for playing the animation on the player's pokémon
						moveName = playerMoveName
					}
					else
					{
						if (string_count("opposing", text) == 0) 
						{
							whoAttacked = "Player"
							moveName = playerMoveName
						}
						else
						{
							whoAttacked = "Enemy"
							moveName = enemyMoveName
						}
						alarm[1] = GetMoveAnimationTime(moveName)
			
						var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
						attackC.alarm[0] = alarm[1]
						attackC.moveName = moveName
						attackC.whoAttacked = whoAttacked
						attackC.particleSpawnTime = floor(alarm[1] / 2)
					}
				}
				if (string_count("poison damage", text) > 0) //Poison damage
				{
					var otherEntity = "Enemy"
					var name = GetName(playerPkmn)
					var level = GetLevel(playerPkmn)
					
					var rawDamage = GetHPStat(GetPokemonFinalStats(name, level))/16
					enemyDamage = clamp(floor(rawDamage), 1, 1000000)
					
					if (string_count("opponent", text) > 0)
					{
						name = GetName(enemyPkmn)
						level = GetLevel(enemyPkmn)
						otherEntity = "Player"
						
						rawDamage = GetHPStat(GetPokemonFinalStats(name, level))/16
						playerDamage = clamp(floor(rawDamage), 1, 1000000)
					}

					whoAttacked = otherEntity
					alarm[1] = GetMoveAnimationTime(moveName)

					var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
					attackC.alarm[0] = alarm[1]
					attackC.moveName = "Poison"
					attackC.whoAttacked = otherEntity
					attackC.particleSpawnTime = floor(alarm[1] / 2)
				}
				if (string_count("burn damage", text) > 0) //Burn damage
				{
					var otherEntity = "Enemy"
					var name = GetName(playerPkmn)
					var level = GetLevel(playerPkmn)
					
					var rawDamage = GetHPStat(GetPokemonFinalStats(name, level))/16
					enemyDamage = clamp(floor(rawDamage), 1, 1000000)
					
					if (string_count("opponent", text) > 0)
					{
						name = GetName(enemyPkmn)
						level = GetLevel(enemyPkmn)
						otherEntity = "Player"
						
						rawDamage = GetHPStat(GetPokemonFinalStats(name, level))/16
						playerDamage = clamp(floor(rawDamage), 1, 1000000)
					}

					whoAttacked = otherEntity
					alarm[1] = GetMoveAnimationTime(moveName)

					var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
					attackC.alarm[0] = alarm[1]
					attackC.moveName = "Burn"
					attackC.whoAttacked = otherEntity
					attackC.particleSpawnTime = floor(alarm[1] / 2)
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
						if (player.currentPkmn == 0)
						{
							player.hspeed = player.moveSpeed
							player.alarm[0] = 100
							player.alarm[1] = 1
						}
						else
						{
							player.alarm[2] = 1
						}
					}
				}
				else if (string_count("opposing", text) == 0 and string_count("fainted", text) > 0) //Player pokémon fainted
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
				else if (string_count("opposing", text) > 0 and string_count("fainted", text) > 0) //Enemy pokémon fainted
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
				else if (string_count("Your Pokemon gained", text) > 0) //Player's pokémon gained EXP
				{
					expGaining = true
					alarm[3] = 5
				}
				else if (string_count("lowered", text) > 0)
				{
					if (string_count("foe", text) > 0)
					{
						for (var i = 0; i < instance_number(BattlePokemonObject); i++)
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (!attempt.playerTeam)
							{
								var statEff = instance_create_layer(attempt.x,attempt.y,"Particles",StatBoostObject)
								statEff.boosting = false
							}
						}
					}
					else
					{
						for (var i = 0; i < instance_number(BattlePokemonObject); i++)
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (attempt.playerTeam)
							{
								var statEff = instance_create_layer(attempt.x,attempt.y,"Particles",StatBoostObject)
								statEff.boosting = false
							}
						}
					}
				}
				else if (string_count("raised", text) > 0)
				{
					if (string_count("foe", text) > 0)
					{
						for (var i = 0; i < instance_number(BattlePokemonObject); i++)
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (!attempt.playerTeam)
							{
								var statEff = instance_create_layer(attempt.x,attempt.y,"Particles",StatBoostObject)
								statEff.boosting = true
							}
						}
					}
					else
					{
						for (var i = 0; i < instance_number(BattlePokemonObject); i++)
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (attempt.playerTeam)
							{
								var statEff = instance_create_layer(attempt.x,attempt.y,"Particles",StatBoostObject)
								statEff.boosting = true
							}
						}
					}
				}
				else if (string_count("caught", text) > 0)
				{
					endBattle = true
					var name = GetName(enemyPkmn)
					var level = GetLevel(enemyPkmn)
					var gender = GetGender(enemyPkmn)
					var sprite = GetSprite(enemyPkmn)
					var hp = GetHealth(enemyPkmn)
					AddPokemonWithHP(name, level, gender, sprite, hp)
				}
				else if (string_count("up!", text) > 0)
				{
					var plr = -1
					for (var i = 0; i < instance_number(BattleEntityObject); i++)
					{
						var attempt = instance_find(BattleEntityObject, i)
						if (attempt.player) plr = attempt
					}
					plr.currentPkmn = switchIndex
					plr.switchIndex = switchIndex
					plr.alarm[2] = 30
				}
			}
		}
	}
}
else alarm[0] = 1