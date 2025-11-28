if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")))
{
	if (currentOption == 0) currentOption = 1
	else if (currentOption == 1) currentOption = 0
}

if (keyboard_check_pressed(ord("D")) and buying and 
GetItemValue(buyItem)*(buyQuantity+1) <= global.money
and buyQuantity < 999)
{
	buyQuantity++
	alarm[0] = quickIncrementValue
}

if (keyboard_check_pressed(ord("A")) and buying and buyQuantity > 1) 
{ 
	buyQuantity--
}

if (alarm[0] > 0 and !keyboard_check(ord("D"))) alarm[0] = -1
if (alarm[1] > 0 and !keyboard_check(ord("A"))) alarm[1] = -1

if (keyboard_check_pressed(ord("E"))) 
{
	if (menu.object_index == BattleTextboxObject)
	{
		menu.visible = true
		menu.inactive = false
	}
	else
	{
		menu.optionMenu = noone
		menu.hasSelected = false
		instance_destroy(id)
	}
}

if (keyboard_check_pressed(vk_enter))
{
	if (option1 == "Buy" and currentOption == 0)
	{
		var itemName = ds_list_find_value(menu.itemList, menu.selectedItem)
		AddItem(itemName, buyQuantity)
		instance_destroy(id)
		menu.optionMenu = noone
		
		global.money -= GetItemValue(buyItem)*buyQuantity
	}
	
	if (option1 == "Use" and currentOption == 0)
	{
		var itemInfo = GetItemInfo(menu.selectedCategory, menu.selectedItem)
		var itemName = GetItemName(itemInfo)

		if (IsConsumableItem(itemName))
		{
			if (currentOption == 0)
			{
				if (IsBattleItem(itemName) and instance_number(BattleObject) > 0)
				{
					ConsumeItem(menu.selectedCategory, menu.selectedItem, 1)
					var statChange = GetStatItemChange(itemName)
					if (statChange != -1) var modifier = ds_list_find_value(statChange, 1)
					var itemCat = GetItemCategory(itemName)
			
					if (statChange != -1)
					{
						var playerPkmn = -1
						for (var i = 0; i < instance_number(BattlePokemonObject); i++) //Find player pokémon
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (attempt.playerTeam) 
							{
								playerPkmn = attempt
								break
							}
						}
				
						switch (ds_list_find_value(statChange, 0)) //Add stat modifier
						{
							case "Attack":
								playerPkmn.atk += modifier
								break
							case "Defense":
								playerPkmn.def += modifier
								break
							case "Special Attack":
								playerPkmn.spatk += modifier
								break
							case "Special Defense":
								playerPkmn.spdef += modifier
								break
							case "Speed":
								playerPkmn.spd += modifier
								break
						}
				
						var battleMenu = instance_find(BattleMenuObject, 0)
						battleMenu.mode = "Choosing"
				
						var enemyPkmn = -1
						for (var i = 0; i < instance_number(BattlePokemonObject); i++)
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (!attempt.playerTeam) 
							{
								enemyPkmn = attempt
								break
							}
						}
				
						var battle = instance_find(BattleObject, 0)
						var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
						battleText.playerPkmn = battle.playerPkmn
						battleText.enemyPkmn = battle.enemyPkmn
						var superEffStr = ""
		
						var pName = GetName(battle.playerPkmn)
						var pLevel = GetLevel(battle.playerPkmn)
						var playerStats = GetPokemonFinalStats(pName, pLevel)
						var eName = GetName(battle.enemyPkmn)
						var eLevel = GetLevel(battle.enemyPkmn)
						var enemyStats = GetPokemonFinalStats(eName, eLevel)
		
						var playerMoveName = itemName
						var moveName = playerMoveName	
						var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
		
						var pPriority = 100 //Item usage needs to happen first
						var ePriority = GetMovePriority(enemyMoveName)
				
						var strongEffectStr = ""
						if (string_count("2", itemName) > 0) strongEffectStr = "greatly "
				
						if (GetSpeedStat(playerStats) > GetSpeedStat(enemyStats) or pPriority > ePriority)
						{
							battleText.playerMoveName = moveName
							ds_list_add(battleText.textList, string_concat("You used a ", itemName, 
							". It ", strongEffectStr, "increased your ", ds_list_find_value(statChange, 0), " value!"))

							//Enemy Move
							moveName = enemyMoveName
							var moveEff = GetMoveEffect(moveName)
							var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
							battleText.enemyMoveName = moveName
							battleText.enemyDamage = damage
				
							superEffStr = ""
							if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
							else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
							ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))
		
							var moveAcc = GetMoveAccurancy(moveName)
							var effectAcc = GetMoveEffectChance(moveName)*100
							if (floor(random_range(0,101)) <= moveAcc) 
							{
								if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
								if (floor(random_range(0,101)) <= effectAcc)
								{
									var effStr = DealEffect(moveEff, effectAcc, enemyPkmn, playerPkmn)
									if (effStr != "") ds_list_add(battleText.textList, effStr)
								}
							}
							else ds_list_add(battleText.textList, "But it missed!")
			
							if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList, 
							string_concat(GetName(battle.playerPkmn)," fainted!"))
						}
						instance_destroy(battleMenu)
						instance_destroy(menu)
						instance_destroy(id)
					}
					else if (itemCat == "Balls")
					{
						var playerPkmn = -1
						for (var i = 0; i < instance_number(BattlePokemonObject); i++) //Find player pokémon
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (attempt.playerTeam) 
							{
								playerPkmn = attempt
								break
							}
						}
				
						var battleMenu = instance_find(BattleMenuObject, 0)
						battleMenu.mode = "Choosing"
				
						var enemyPkmn = -1
						for (var i = 0; i < instance_number(BattlePokemonObject); i++)
						{
							var attempt = instance_find(BattlePokemonObject, i)
							if (!attempt.playerTeam) 
							{
								enemyPkmn = attempt
								break
							}
						}
				
						var battle = instance_find(BattleObject, 0)
						var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
						battleText.playerPkmn = battle.playerPkmn
						battleText.enemyPkmn = battle.enemyPkmn
						var superEffStr = ""
		
						var pName = GetName(battle.playerPkmn)
						var pLevel = GetLevel(battle.playerPkmn)
						var playerStats = GetPokemonFinalStats(pName, pLevel)
						var eName = GetName(battle.enemyPkmn)
						var eLevel = GetLevel(battle.enemyPkmn)
						var enemyStats = GetPokemonFinalStats(eName, eLevel)
		
						var playerMoveName = itemName
						var moveName = playerMoveName	
						var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
		
						var pPriority = 100 //Item usage needs to happen first
						var ePriority = GetMovePriority(enemyMoveName)
				
						if (GetSpeedStat(playerStats) > GetSpeedStat(enemyStats) or pPriority > ePriority)
						{
							battleText.playerMoveName = moveName
							ds_list_add(battleText.textList, string_concat("You threw a ", itemName, "!"))
						    if (battle.isWild)
							{
								battleText.timesBobbed = TryCatching(itemName)
								if (battleText.timesBobbed == 3) ds_list_add(battleText.textList, GetCatchingString(battleText.timesBobbed, GetName(battle.enemyPkmn)))
								else
								{
									moveName = enemyMoveName
									var moveEff = GetMoveEffect(moveName)
									var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
									battleText.enemyMoveName = moveName
									battleText.enemyDamage = damage
				
									superEffStr = ""
									if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
									else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
									ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))
		
									var moveAcc = GetMoveAccurancy(moveName)
									var effectAcc = GetMoveEffectChance(moveName)*100
									if (floor(random_range(0,101)) <= moveAcc) 
									{
										if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
										if (floor(random_range(0,101)) <= effectAcc)
										{
											var effStr = DealEffect(moveEff, effectAcc, enemyPkmn, playerPkmn)
											if (effStr != "") ds_list_add(battleText.textList, effStr)
										}
									}
									else ds_list_add(battleText.textList, "But it missed!")
			
									if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList, 
									string_concat(GetName(battle.playerPkmn)," fainted!"))
								}
							}
							else
							{
								ds_list_add(battleText.textList, "You can't catch a trainer pokemon!")
								moveName = enemyMoveName
								var moveEff = GetMoveEffect(moveName)
								var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
								battleText.enemyMoveName = moveName
								battleText.enemyDamage = damage
				
								superEffStr = ""
								if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
								else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
								ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))
		
								var moveAcc = GetMoveAccurancy(moveName)
								var effectAcc = GetMoveEffectChance(moveName)*100
								if (floor(random_range(0,101)) <= moveAcc) 
								{
									if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
									if (floor(random_range(0,101)) <= effectAcc)
									{
										var effStr = DealEffect(moveEff, effectAcc, enemyPkmn, playerPkmn)
										if (effStr != "") ds_list_add(battleText.textList, effStr)
									}
								}
								else ds_list_add(battleText.textList, "But it missed!")
			
								if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList, 
								string_concat(GetName(battle.playerPkmn)," fainted!"))
							}
					
							instance_destroy(battleMenu)
							instance_destroy(menu)
							instance_destroy(id)
						}
					}
				}
				else if (!IsBattleItem(itemName))
				{
					if (currentOption == 0)
					{
						var pkmnMenu = instance_create_depth(x,y,depth-1,PokemonMenuObject)
						pkmnMenu.itemUse = true
						pkmnMenu.itemName = itemName
						pkmnMenu.bagMenu = menu
				
						menu.optionMenu = noone
						instance_destroy(id)
					}
				}
			}
			else
			{
				var battleMenu = menu.menu
				battleMenu.mode = "Choosing"
				battleMenu.visible = true
				instance_destroy(menu)
				instance_destroy(id)
			}
		}
	}
	
	if (option1 == "Switch" and currentOption == 0)
	{
		if (currentOption == 0)
		{	
			var playerPkmn = -1
			for (var i = 0; i < instance_number(BattlePokemonObject); i++) //Find player pokémon
			{
				var attempt = instance_find(BattlePokemonObject, i)
				if (attempt.playerTeam) 
				{
					playerPkmn = attempt
					break
				}
			}
				
			var battleMenu = instance_find(BattleMenuObject, 0)
			battleMenu.mode = "Choosing"
			
			var enemyPkmn = -1
			for (var i = 0; i < instance_number(BattlePokemonObject); i++)
			
			{
				var attempt = instance_find(BattlePokemonObject, i)
				if (!attempt.playerTeam) 
				{
					enemyPkmn = attempt
					break
				}
			}
			var battle = instance_find(BattleObject, 0)
			var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
			var pNameOld = GetName(battle.playerPkmn)
			
			battle.playerPkmn = ds_list_find_value(battle.playerTeam, menu.selectedIndex)
			battleText.switchIndex = menu.selectedIndex
			battleText.playerPkmn = battle.playerPkmn
			battleText.enemyPkmn = battle.enemyPkmn
			
			var superEffStr = ""
			var pName = GetName(battle.playerPkmn)
			var pLevel = GetLevel(battle.playerPkmn)
			var playerStats = GetPokemonFinalStats(pName, pLevel)
			var eName = GetName(battle.enemyPkmn)
			var eLevel = GetLevel(battle.enemyPkmn)
			var enemyStats = GetPokemonFinalStats(eName, eLevel)
		
			var playerMoveName = "Switch"
			var moveName = playerMoveName	
			var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
		
			var pPriority = 100 //Item usage needs to happen first
			var ePriority = GetMovePriority(enemyMoveName)
				
			if (GetSpeedStat(playerStats) > GetSpeedStat(enemyStats) or pPriority > ePriority)
			{
				battleText.playerMoveName = moveName
				ds_list_add(battleText.textList, string_concat(pNameOld, ", come back!"), string_concat(pName, ", you're up!"))

				//Enemy Move
				moveName = enemyMoveName
				var moveEff = GetMoveEffect(moveName)
				var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
				battleText.enemyMoveName = moveName
				battleText.enemyDamage = damage
				
				superEffStr = ""
				if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
				else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
				ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))
		
				var moveAcc = GetMoveAccurancy(moveName)
				var effectAcc = GetMoveEffectChance(moveName)*100
				if (floor(random_range(0,101)) <= moveAcc) 
				{
					if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
					if (floor(random_range(0,101)) <= effectAcc)
					{
						var effStr = DealEffect(moveEff, effectAcc, enemyPkmn, playerPkmn)
						if (effStr != "") ds_list_add(battleText.textList, effStr)
					}
				}
				else ds_list_add(battleText.textList, "But it missed!")
			
				if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList, 
				string_concat(GetName(battle.playerPkmn)," fainted!"))
			}

			instance_destroy(battleMenu)
			instance_destroy(menu)
			instance_destroy(id)
		}
		else
		{
			var battleMenu = menu.menu
			battleMenu.mode = "Choosing"
			battleMenu.visible = true
			instance_destroy(menu)
			instance_destroy(id)
		}
	}
	
	if (option1 == "Wake it up" and currentOption == 0)
	{
		target.alarm[1] = 100
		instance_destroy(id)
	}
	
	if ((option2 == "Exit" or option2 == "Leave") and currentOption == 1) 
	{
		var player = instance_find(PlayerObject, 0)
		player.alarm[1] = 1
		instance_destroy(id)
	}
	
	if (string_count("replace", question) > 0)
	{
		if (currentOption == 0)
		{
			var moveReplace = instance_create_layer(0,0,"UIElements",MoveReplaceObject)
			moveReplace.newMove = newMove
			moveReplace.moveList = moveList
			moveReplace.menu = menu
		}
		else
		{
			menu.inactive = false
			menu.visible = true
		}
		
		instance_destroy(id)
	}
	
	if (string_count("stop learning", question) > 0)
	{
		if (currentOption == 0)
		{
			ds_list_set(menu.textList, ds_list_size(menu.textList)-1, string_concat("You stopped learning ", newMove, "!"))
			ds_list_delete(menu.listLevelUpMoves, 0)
		}
		else if (currentOption == 1)
		{
			var youWinText = ""
			if (ds_list_find_value(menu.textList, ds_list_size(menu.textList)-1) == "You win!") 
			{
				ds_list_delete(menu.textList, ds_list_size(menu.textList)-1)
				youWinText = "You win!"
			}
			
			ds_list_add(menu.textList, string_concat("Your Pokemon wants to learn ", newMove, "."),
			"However, it already knows four moves", "Would you like to replace one?")
			
			if (youWinText != "") ds_list_add(menu.textList, youWinText)
		}
		
		menu.inactive = false
		menu.visible = true
		instance_destroy(id)
	}
	
	if (string_count("want", question) > 0 and string_count("Pokemon", question) > 0)
	{
		if (currentOption == 0)
		{
			AddPokemonSpecific(referenceNPC.pokemonInfo)
			
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.iconList = referenceNPC.iconList
			dialogue.nameList = referenceNPC.nameList
			player.talking = true
			
			ds_list_add(dialogue.textList, string_concat("You got a ", 
			referenceNPC.item, "! They joined the team!"))
			
			instance_destroy(referenceNPC)
			instance_destroy(id)
		}
		else 
		{
			alarm[2] = 1
		}
	}
	
	if (question == "Pick an option.")
	{
		if (option1 == "Get lost, loser!" and currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Shut up! I'm going away anyways...")

			player.talking = true
	
			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (option2 == "Why don't you join me?" and currentOption == 1)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Fine! Whatever...")
	
			player.talking = true
	
			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		instance_destroy(id)
	}
	
	if (question == "Pull it?")
	{
		var player = instance_find(PlayerObject, 0)
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		player.talking = true
		
		switch (currentOption)
		{
			case 0:
				//Do something?
				break
		}
		
		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		instance_destroy(id)
	}
}