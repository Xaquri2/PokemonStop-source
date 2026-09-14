if (ds_list_find_value(textList, currentText+1) != undefined and !catching and !switching and !inactive)
{
	recoil = false
	currentText++
	charCounter = 0
	charNumber = 0

	if (instance_number(ImportantElementParent) == 0 and alarm[3] < 0 and !expGaining)
	{
		var text = ds_list_find_value(textList, currentText)

		if (currentText > ds_list_size(textList))
		{
			if (!endBattle and instance_number(BattleMenuObject) == 0)
			{
				instance_create_layer(x,y,"UIElements",BattleMenuObject)
			}
			instance_destroy(id)
		}
		else if (string_count("learned", text) > 0
		&& string_count("forgot", text) == 0)
		{
		    if (ds_list_size(listLevelUpMoves) > 0)
		    {
		        var newMove = ds_list_find_value(listLevelUpMoves, 0);

		        if (ds_list_find_index(GetMoves(battle.playerPkmn), newMove) == -1)
		        {
		            LearnMove(battle.playerPkmn, newMove, -1);
		        }
		    }
		}
		else if (currentText > 0 and string_count("like to replace", ds_list_find_value(textList, currentText-1)) > 0)
		{
			var optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
			optionMenu.menu = id
			optionMenu.question = "Would you like to replace a move?"
			ds_list_add(optionMenu.optionList, "Yes")
			ds_list_add(optionMenu.optionList, "No")
			optionMenu.newMove = ds_list_find_value(listLevelUpMoves, 0)
			optionMenu.moveList = GetMoves(playerPkmn)

			inactive = true
			visible = false
		}
		else if (string_count("stop learning", ds_list_find_value(textList, currentText-1)) > 0)
		{
			var optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
			optionMenu.menu = id
			optionMenu.question = "Would you like to stop learning a new move?"
			ds_list_add(optionMenu.optionList, "Yes")
			ds_list_add(optionMenu.optionList, "No")
			optionMenu.target = id
			optionMenu.newMove = ds_list_find_value(listLevelUpMoves, 0)
			optionMenu.moveList = GetMoves(playerPkmn)

			inactive = true
			visible = false
		}
		else
		{
			if (alarm[1] < 0)
			{
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
					var enemy = noone
					for (var i = 0; i < instance_number(BattleEntityObject); i++)
					{
						enemy = instance_find(BattleEntityObject, i)
						if (enemy.player) enemy = noone
						else break
					}

					if (enemy != noone)
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
					// A replacement can be sent out before this textbox finishes
					// processing recoil and EXP. Follow the battle's newly active
					// Pokemon so later EXP updates cannot restore the fainted one.
					playerPkmn = battle.playerPkmn

					var player = noone
					for (var i = 0; i < instance_number(BattleEntityObject); i++)
					{
						player = instance_find(BattleEntityObject, i)
						if (player.player) break
					}

					if (player != noone)
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
				else if (string_count("struggled and took", text) > 0 or 
				string_count("failed and they fainted!", text) > 0)
				{
					moveName = "Struggle"
					recoil = true

					if (string_count("opponent", text) != 0)
					{
						whoAttacked = "Player"
						eRecoilDamage = GetRecoilDamage(enemyPkmn, moveName)
					}
					else
					{
						whoAttacked = "Enemy"
						pRecoilDamage = GetRecoilDamage(playerPkmn, moveName)
					}

					alarm[1] = GetMoveAnimationTime(moveName)

					var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
					attackC.alarm[0] = alarm[1]
					attackC.moveName = moveName
					attackC.whoAttacked = whoAttacked
					attackC.particleSpawnTime = floor(alarm[1] / 2)
				}
				else if (string_count("took some damage", text) > 0)
				{
					if (string_count("opponent", text) != 0) moveName = enemyMoveName
					else moveName = playerMoveName
					
					recoil = true

					if (string_count("opponent", text) == 0)
					{
						whoAttacked = "Enemy"
						pRecoilDamage = GetRecoilDamage(playerPkmn, moveName)
					}
					else
					{
						whoAttacked = "Player"
						eRecoilDamage = GetRecoilDamage(enemyPkmn, moveName)
					}

					alarm[1] = GetMoveAnimationTime(moveName)

					var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
					attackC.alarm[0] = alarm[1]
					attackC.moveName = moveName
					attackC.whoAttacked = whoAttacked
					attackC.particleSpawnTime = floor(alarm[1] / 2)
				}
				else if (string_count("opposing", text) == 0 and string_count("fainted", text) > 0) //Player pokémon fainted
				{
					var playerPkmnEntity = noone
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						var attempt = instance_find(BattlePokemonObject, i)
						if (attempt.playerTeam)
						{
							playerPkmnEntity = attempt
							break
						}
					}

					if (playerPkmnEntity != noone)
					{
						alarm[3] = 100
						playerPkmnEntity.alarm[1] = 100
					}
				}
				else if (string_count("opposing", text) > 0 and string_count("fainted", text) > 0) //Enemy pokémon fainted
				{
					var enemyPkmnEntity = noone
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						var attempt = instance_find(BattlePokemonObject, i)
						if (!attempt.playerTeam)
						{
							enemyPkmnEntity = attempt
							break
						}
					}
					
					if (room == RoomBattleGodzilla) {
						GodzillaFainting = true
					}

					if (enemyPkmnEntity != noone)
					{
						alarm[3] = 100
						enemyPkmnEntity.alarm[1] = 100
					}
				}
				else if (string_count("Your Pokemon gained", text) > 0) //Player's pokémon gained EXP
				{
					for (var i = 0; i < ds_list_size(global.playerParty); i++)
					{
						var partyMemberInfo = ds_list_find_value(global.playerParty, i)
						if (partyMemberInfo != playerPkmn)
						{
							if (global.expAll) AddExp(partyMemberInfo, floor(expGainValue/2))
							else if (ds_list_find_index(battle.battleParticipants, partyMemberInfo) != undefined) AddExp(partyMemberInfo, floor(expGainValue/2))
						}
					}
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
					    var name = GetName(enemyPkmn)
					    var level = GetLevel(enemyPkmn)
					    var gender = GetGender(enemyPkmn)
					    var sprite = GetSprite(enemyPkmn)
					    var hp = GetHealth(enemyPkmn)

					    AddPokemonWithHP(name, level, gender, sprite, hp)

					    var experience = GetEXPYield(name, level, 1, false, false)
					    expGainValue = experience
					    ds_list_add(textList, string_concat(
					        "Your Pokemon gained ", experience, " EXP"
					    ))

					    var hasGainedItems = GetTrainerLoot(
					        GetTrainerRank(battle.enemyName)
					    )

					    if (hasGainedItems)
					    {
					        ds_list_add(textList, "You earned some items!")
					    }

					    ds_list_add(textList, "You win!")
					    endBattle = true
					}
				else if (string_count("you're up!", text) > 0)
				{
					var plr = -1
					for (var i = 0; i < instance_number(BattleEntityObject); i++)
					{
						var attempt = instance_find(BattleEntityObject, i)
						if (attempt.player) plr = attempt
					}
					// Keep currentPkmn on the Pokemon that is actually on the field.
					// The spawn event commits the new index after validating it.
					plr.switchIndex = switchIndex
					plr.alarm[2] = 30
				}
				else if (string_count("You lose!", text) > 0)
				{
					for (var i = 0; i < ds_list_size(battle.playerTeam); i++)
					{
						HealPokemon(battle.playerTeam, i, 1000000, true, true, true)
					}
				}
				else if (string_count("opponent is now", text) > 0 and string_count("confused", text) == 0)
				{
					var target = noone
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						target = instance_find(BattlePokemonObject, i)
						if (!target.playerTeam) break
					}

					var effectName = GetMoveEffect(playerMoveName)
					if (whoAttacked == "Enemy") effectName = GetMoveEffect(enemyMoveName)
					
					var status = effectName
					if (status == "RandomStatus")
					{
						var attempt = irandom(3)
						if (attempt == 0) status = "Paralysis"
						if (attempt == 1) status = "Poisoned"
						if (attempt == 2) status = "Burn"
						if (attempt == 3) status = "Sleep"
					}
					
					SetStatus(target.pkmnInfo, status)
					target.status = status
				}
				else if (string_count("pokemon is now", text) > 0 and string_count("confused", text) == 0)
				{
					var target = noone
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						target = instance_find(BattlePokemonObject, i)
						if (target.playerTeam) break
					}

					var effectName = GetMoveEffect(playerMoveName)
					if (whoAttacked == "Enemy") effectName = GetMoveEffect(enemyMoveName)

					var status = effectName
					if (status == "RandomStatus")
					{
						var attempt = irandom(3)
						if (attempt == 0) status = "Paralysis"
						if (attempt == 1) status = "Poisoned"
						if (attempt == 2) status = "Burn"
						if (attempt == 3) status = "Sleep"
					}
					
					SetStatus(target.pkmnInfo, status)

					target.status = status
				}
			}
		}
	}
}
else alarm[0] = 1
