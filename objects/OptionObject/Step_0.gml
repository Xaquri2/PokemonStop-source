if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(vk_up))
{
	currentOption--
	if (currentOption < 0) currentOption = ds_list_size(optionList)-1
}
if (keyboard_check_pressed(ord("S")) or keyboard_check_pressed(vk_down))
{
	currentOption++
	if (currentOption >= ds_list_size(optionList)) currentOption = 0
}

if (keyboard_check_pressed(ord("D")) and buying and
GetItemValue(buyItem)*(buyQuantity+1) <= global.money
and buyQuantity < 999)
{
	buyQuantity++
	alarm[0] = quickIncrementValue
}

if (keyboard_check_pressed(vk_right) and buying and
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

if (keyboard_check_pressed(vk_left) and buying and buyQuantity > 1)
{
	buyQuantity--
}

if (alarm[0] > 0 and !keyboard_check(ord("D"))) alarm[0] = -1
if (alarm[1] > 0 and !keyboard_check(ord("A"))) alarm[1] = -1

if (keyboard_check_pressed(ord("E")))
{
	if (instance_exists(menu))
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
		}
	}
	else
	{
		var player = instance_find(PlayerObject, 0)

		if (instance_exists(player))
		{
			//player.talking = false
			//player.canWalk = true
			player.alarm[1] = 1
		}
	}

	instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter))
{
	if (ds_list_find_value(optionList, currentOption) == "Buy")
	{
		var itemName = ds_list_find_value(menu.itemList, menu.selectedItem)
		AddItem(itemName, buyQuantity)
		instance_destroy(id)
		menu.optionMenu = noone
		audio_play_sound(snd_button,1,0)

		global.money -= GetItemValue(buyItem)*buyQuantity
	}

	if (ds_list_find_value(optionList, currentOption) == "Use")
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
					if (string_count("Torch Fuel", itemName) > 0)
					{
						global.torchPower += GetHealValue(itemName)
						global.torchPower = clamp(global.torchPower, 0, 1)
							
						var player = instance_find(PlayerObject, 0)
						var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
						ds_list_add(dialogue.textList, string_concat("You used the ", itemName, "!"))

						player.talking = true

						if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
							
						instance_destroy(menu)
						instance_destroy(id)
					}
					else if (string_count("Area Key", itemName) > 0)
					{
						var game = instance_find(GameObject, 0)
						game.areaKeyInfo = itemName
						
						var player = instance_find(PlayerObject, 0)
						var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
						ds_list_add(dialogue.textList, string_concat("You used the ", itemName, "!"), 
						string_concat("Only for 10 minutes though!"))

						player.talking = true

						if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
							
						instance_destroy(menu)
						instance_destroy(id)
					}
					else if (itemName == "Skyview Potion")
					{
						global.morlockTimer = 60*60*10
						
						var player = instance_find(PlayerObject, 0)
						var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
						ds_list_add(dialogue.textList, string_concat("You used the ", itemName, "! And you transformed into a Morlock!"), "Only for 10 minutes though!")

						player.talking = true

						if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
							
						instance_destroy(menu)
						instance_destroy(id)
					}
					else
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

	if (ds_list_find_value(optionList, currentOption) == "Switch")
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
			for (var i = 0; i < instance_number(BattlePokemonObject); i++) //Find enemy pokémon

			{
				var attempt = instance_find(BattlePokemonObject, i)
				if (!attempt.playerTeam)
				{
					enemyPkmn = attempt
					break
				}
			}
			
			var battle = instance_find(BattleObject, 0)
			if (playerPkmn.pkmnInfo != ds_list_find_value(battle.playerTeam, menu.selectedIndex))
			{
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
			}
			else
			{
				instance_destroy(battleMenu)
				instance_create_layer(x,y,"UIElements",BattleMenuObject)
			}
			
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

	if (ds_list_find_value(optionList, currentOption) == "Wake it up")
	{
		target.alarm[1] = 100
		instance_destroy(id)
	}

	if (ds_list_find_value(optionList, currentOption) == "Exit" or ds_list_find_value(optionList, currentOption) == "Leave")
	{
		{
    if (instance_exists(menu))
    {
        var battleMenu = menu.menu;

        if (instance_exists(battleMenu))
        {
            battleMenu.mode = "Choosing";
            battleMenu.visible = true;
        }

        instance_destroy(menu);
    }

    instance_destroy();
    exit;
}
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

	if (string_count("want", question) > 0 and (string_count("Pokemon", question) > 0 or string_count("Pokémon", question) > 0))
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
		if (ds_list_find_value(optionList, currentOption) == "Get lost, loser!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Shut up! I'm going away anyways...")
			ds_list_add(dialogue.nameList, "Mary")

			player.talking = true
			ds_list_add(global.flags, "MaryRejected")
			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		if (ds_list_find_value(optionList, currentOption) == "Why don't you join me?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Fine! Whatever...")
			ds_list_add(dialogue.nameList, "Mary")
			ds_list_add(dialogue.iconList, MaryWalkDownSprite)
			
			ds_list_add(global.flags, "MaryRivalBattle1")
		    global.followerType = "Mary"
		    instance_destroy(Mary)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
			
			
		}

		instance_destroy(id)
	}
	
	//Sphinx// 
	
	if (question == "A creature w/ one voice & becomes 4-footed & 2-footed & 3-footed?!")
	{
		if (ds_list_find_value(optionList, currentOption) == "Humans.")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Correct. You may pass.")
			ds_list_add(dialogue.nameList, "Sphinx")
			ds_list_add(dialogue.iconList, SphinxSprite)

			Sphinx.RiddleSolved = true 
			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		if (ds_list_find_value(optionList, currentOption) == "Dogs.")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Incorrect.","Foolish mortal! Dogs never become three-footed!!","Unless they lose a leg, I suppose..","Still!! That does NOT count!!")
			ds_list_add(dialogue.nameList, "Sphinx","Sphinx","Sphinx","Sphinx")
			ds_list_add(dialogue.iconList, SphinxSprite,SphinxSprite,SphinxSprite,SphinxSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "A Table.")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Incorrect.","Foolish mortal! Tables don't speak with one voice! They don't have ANY voice AT ALL!!")
			ds_list_add(dialogue.nameList, "Sphinx","Sphinx")
			ds_list_add(dialogue.iconList, SphinxSprite,SphinxSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		instance_destroy(id)
	}
	
	//Nebogipfel// 
	
	if (question == "Question this weird Morlock!" or question == "More Questions for Nebogipfel")
	{
		if (ds_list_find_value(optionList, currentOption) == "Who are you?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "Oh, uh, excuse me — I am Called Neb —",
			"Uh, not sure you can pronounce this in your language? —","Nebogipfel.",
			"I’ve been curious about Humans for a long time - how you live, how you... think...",
			"To that end I taught myself your language... just spying from afar.")
			ds_list_add(dialogue.nameList, "Morlock","Morlock","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,
			NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			//if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		if (ds_list_find_value(optionList, currentOption) == "You sure you’re not gonna eat me?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "Oh, yes, very sure. You have nothing to fear from me. ",
			" I’ve come to detest what the other Morlocks do to your people. ",
			"I’ve been curious about Humans for a long time - how you live, how you... think...",
			"To that end I taught myself your language... just spying from afar.")
			ds_list_add(dialogue.nameList, "Morlock","Morlock","Morlock","Morlock")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			//if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Pleased to meet you, I’m Gash!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "Ah, I… am … (what’s the word?) pleased also! Upon meeting you. ",
			"I’ve been curious about Humans for a long time - how you live, how you... think...",
			"To that end I taught myself your language... just spying from afar.")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			//if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		
		
		if (ds_list_find_value(optionList, currentOption) == "(Next)")
		{
			var player = instance_find(PlayerObject, 0)
			player.alarm[1] = -1
			
			var optionMenu = instance_create_layer(20, 20, "UserInterface", OptionObject);
		    optionMenu.question = "More Questions for Nebogipfel";
			optionMenu.referenceNPC = referenceNPC

		    ds_list_add(optionMenu.optionList, "What is this place?")
			ds_list_add(optionMenu.optionList, "What do you do here?")
			ds_list_add(optionMenu.optionList, "Why are the other Morlocks trying to eat me?")
			ds_list_add(optionMenu.optionList, "(Even more questions)")
		}
		
		if (ds_list_find_value(optionList, currentOption) == "What is this place?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "Well, uh, this is my home.",
			"As you can see, it doubles as my lab.",
			"I’m a bit of a scientist, you see.")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			//if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "What do you do here?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "I do all sorts of experiments here - chemistry, physics, whatever.",
			"The others have forgotten most of the Old Knowledge, except the parts needed to keep the machines running, but I can’t get enough of it!")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			//if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Why are the other Morlocks trying to eat me?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "You’re our primary food source. We need to eat, you know.",
			"I know, that doesn’t make it right.",
			"The others justify it in their minds by convincing themselves humans aren’t truly people.",
			"Ironically, we were once human… though the memory of that existence has faded from us like a dream.",
			"The younger ones like me were never human, as we were born to Morlock parents.")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			//if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		var a = ds_list_find_value(optionList, currentOption)
		if (ds_list_find_value(optionList, currentOption) == "(Even more questions)")
		{
			var player = instance_find(PlayerObject, 0)
			player.alarm[1] = -1
			
			var optionMenu = instance_create_layer(20, 20, "UserInterface", OptionObject);
		    optionMenu.referenceNPC = referenceNPC
		    optionMenu.question = "More Questions for Nebogipfel";

		    ds_list_add(optionMenu.optionList, "Are you a Pokémon Trainer too?", "Can you help me find the Gym Leader here...?")
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Are you a Pokémon Trainer too?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Glagash, no!",
			"Look, it’s not just Morlock society that I differ from…",
			"This whole society, Morlock, Human, or otherwise…",
			"is built around the idea of CATCHING and TRAINING POKÉMON.",
			"Every city is built around Gyms and Pokecenters, every child dreams of being a trainer, and I…",
			"Well, I began to question that. WHY should it be that way??")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		if (ds_list_find_value(optionList, currentOption) == "Can you help me find the Gym Leader here...?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Simply head North once you exit my home and follow the path, you’ll get there eventually!")
			ds_list_add(dialogue.nameList, "Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "I mean, why not?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "We Morlocks eat humans. We treat you like your lives, your thoughts, don’t matter.",
			"Isn’t training Pokémon the same thing?",
			"You attack these creatures, you capture them by force, and you force them to work for you.",
			"To FIGHT for you. Fighting, violence, AGAINST THEIR WILL.",
			"and THAT’s what we want our entire world built around?",
			"Not art, not science, not curiosity about the universe,",
			"But around forcing creatures to fight each other??")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Cuz it’s great!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Is it, though?", 
			"We Morlocks eat humans. We treat you like your lives, your thoughts, don’t matter.",
			"Isn’t training Pokémon the same thing?",
			"You attack these creatures, you capture them by force, and you force them to work for you.",
			"To FIGHT for you. Fighting, violence, AGAINST THEIR WILL.",
			"and THAT’s what we want our entire world built around?",
			"Not art, not science, not curiosity about the universe,",
			"But around forcing creatures to fight each other??")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel",
			"Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,
			NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "That’s not true! You build a BOND with them!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "That doesn’t change the fact that they don’t have a CHOICE.",
			"I hope that, perhaps in your journeys, you’ll learn to see all sentient beings as THE SAME…",
			"Humans, Morlocks, Pokémon, … even sentient ROBOTS…",
			"Anyway...", "Sorry to rant, that’s just what I think.")
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "I guess I can see your point...")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Thank you.", "Sorry to rant, that’s just what I think.")
			
			ds_list_add(dialogue.nameList, "Nebogipfel", "Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite, NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Interesting perspective — I’d like to learn more about it!"
		or ds_list_find_value(optionList, currentOption) == "I dunno man, I don’t buy it")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Well, I learned these idea through EXPERIENCE. I think you should, too.",
			"And I have just the thing to help!",
			"Right now, you see us MORLOCKS only as vicious creatures. Enemies.",
			"One might say you DEHUMANIZE us.",
			"But perhaps if you could live as a Morlock, even just for one day, that would change.",
			"I can make a potion that would TURN YOU INTO A MORLOCK…",
			"Only temporarily, of course. And only if you want to try it.",
			"The other Morlocks would think you’re one of us, and let you pass…",
			"So that would help you get past them, to reach the Gym Leader.",
			"More importantly… it would let you understand our language…",
			"So, you could speak to other Morlocks, and see what they’re like.",
			"NOT as creatures, not as enemies, but as PEOPLE.",
			"That is how I had to relearn what humans are:",
			"Listening to them. Hearing what they’re like, in their own words.",
			"What do you think, you wanna try it?")
			
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel",
			"Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel",
			"Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite
			,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite
			,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "No way! I’m not turning into one of you disgusting creatures")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Ouch.",
			"As someone who’s longed to talk to a real human for years… that hurts.",
			"But I suppose I understand. We do eat humans, after all.",
			"I might have once reacted the same to a creature who eats Morlocks.",
			"Go in peace. If you change your mind, you know where to find me.")
			
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Uh, no thanks… I’m not ready to change into something else")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Quite understandable.", "Bring me one of those, and I’ll make the potion for you.")
			
			ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel")
			ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "Yes please!") or (ds_list_find_value(optionList, currentOption) == "I got the Skyview Mushroom. Make me a POTION!!")
		{
			if (HasItem("Skyview Mushroom"))
			{
				var player = instance_find(PlayerObject, 0)
				var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
				dialogue.actionNPC = referenceNPC
				
				AddItem("Skyview Potion", 1)
				RemoveItem("Skyview Mushroom", 1)
				
				ds_list_add(dialogue.textList, "Ooh, excellent, this is exciting! What an experiment!",
				"Okay, here goes!!",
				"Let’s see… two tablespoons of Glaktar… one goshgash of frashgist..",
				"Some of my own blood for DNA… Ow! …",
				"and one Skyview Mushroom!",
				"There we go! Your potion! Drink when ready!")
			
				ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel",
				"Nebogipfel","Nebogipfel","Nebogipfel")
				ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,
				NebogipfelSprite,NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

				player.talking = true

				if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
			}
			else
			{
				var player = instance_find(PlayerObject, 0)
				var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
				dialogue.actionNPC = referenceNPC
			
				ds_list_add(dialogue.textList, "Ooh, excellent, this is exciting! What an experiment!",
				"Oh, one thing though, I just remembered I’m missing an important ingredient: a SKYVIEW MUSHROOM.",
				"Bring me one of those, and I’ll make the potion for you.")
			
				ds_list_add(dialogue.nameList, "Nebogipfel","Nebogipfel","Nebogipfel")
				ds_list_add(dialogue.iconList, NebogipfelSprite,NebogipfelSprite,NebogipfelSprite)

				player.talking = true

				if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
			}
		}
		
		instance_destroy(id)
	}
	
	// sdcdscdsds //

	if (question == "Pull it?")
	{
		var player = instance_find(PlayerObject, 0)
		player.alarm[1] = 1
		
		switch (currentOption)
		{
			case 0: // yes
				global.pikminCount++
				instance_destroy(referenceNPC)
				instance_destroy(id)
				
				break
				
			case 1: // No
				instance_destroy(id)
				break
		}

		
	}
	
	if (question == "Start the Gym Battle?" or question == "Start the Battle?")
	{
		if (currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			dialogue.startBattle = true
			
			ds_list_add(dialogue.textList, "Alright, let's begin!")

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

			ds_list_add(dialogue.textList, "Alright, i'll be here whenever you're ready.")

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}

		instance_destroy(id)
	}
	
	if (question == "Heal Pokémon?")
	{
		if (currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Alright, let me heal them...")
			ds_list_add(dialogue.nameList, "Nurse Joy")
			ds_list_add(dialogue.iconList, NurseJoySprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
			
			instance_destroy(id)
		}
	}
	
	if (string_count("Gorbertron", question) > 0)
	{
		var player = instance_find(PlayerObject, 0)
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		
		switch (currentOption)
		{
			case 0:
				dialogue.name = referenceNPC.name
				dialogue.actionNPC = referenceNPC
			
				ds_list_add(dialogue.textList, "Ah, you like the accoutrements on my desk!", 
				"Thank you, I pride myself on my decor.", 
				"Well, on your right is a toy model… and then we have my pet, Captain Tribble.")
				ds_list_add(dialogue.nameList, "Gorbertron","Gorbertron","Gorbertron")
				ds_list_add(dialogue.iconList, GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP,)

				player.talking = true

				if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
				break
			case 1:
				dialogue.name = referenceNPC.name
				dialogue.actionNPC = referenceNPC
			
				ds_list_add(dialogue.textList, "The Morlocks were human once... But the forces of evolution and mutation have changed us. Bettered us.",
				"We are no longer slaves to the Sun; we can work much longer hours...", "You think we should mourn our lost humanity? Such arrogance! Why should we? We are so much more.")
				ds_list_add(dialogue.nameList, "Gorbertron","Gorbertron","Gorbertron")
				ds_list_add(dialogue.iconList, GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP,)

				player.talking = true

				if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
				break
			case 2:
				dialogue.name = referenceNPC.name
				dialogue.actionNPC = referenceNPC
			
				ds_list_add(dialogue.textList, "An advanced form of Morlock. Unlike the other Morlocks... I’ve gained certain abilities. I can move objects with my mind!")
				ds_list_add(dialogue.nameList, "Gorbertron")
				ds_list_add(dialogue.iconList, GorbertronSprite_CLOSEUP)

				player.talking = true

				if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
				break
			case 3:
				dialogue.name = referenceNPC.name
				dialogue.actionNPC = referenceNPC
			
				ds_list_add(dialogue.textList, "This entire place is devoted to one goal: human evolution. You see, Morlocks are the better forms of humans, and I'm devoted to mutating humans into greater forms.",
				"If we can bring human-types up to their next stage, humans can become the ULTIMATE POKéMON. By experimenting with evolution, we can achieve godlike status",
				"and YOU WILL NOT GET IN MY WAY!!.", "That said... Are you ready to challenge me?")
				ds_list_add(dialogue.nameList, "Gorbertron","Gorbertron","Gorbertron","Gorbertron")
				ds_list_add(dialogue.iconList, GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP,GorbertronSprite_CLOSEUP)

				player.talking = true

				if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
				break
		}
		
		instance_destroy(id)
	}
	
	if (question == "Do you know what this place is?")
	{
		if (currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.nameList, "Lilium","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,)
			
			ds_list_add(dialogue.textList, "Well, yes… but also much more than that.",
			"This is a TIME-SPACE AXIS…", 
			"Specifically, the most powerful and sensitive IN THE WORLD.",
			"That means: this is essentially a telescope for looking out at the MULTIVERSE.",
			"Each of the platforms in this room represents a different universe in the MULTIVERSE.",
			"The motions of the platforms reflect the actual motions of the universes relative to one another.",
			"You will of course recognize Palkia and Dialga?")

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "This is a TIME-SPACE AXIS…", 
			"Specifically, the most powerful and sensitive IN THE WORLD.",
			"That means: this is essentially a telescope for looking out at the MULTIVERSE.",
			"Each of the platforms in this room represents a different universe in the MULTIVERSE.",
			"The motions of the platforms reflect the actual motions of the universes relative to one another.",
			"You will of course recognize Palkia and Dialga?")
			ds_list_add(dialogue.nameList, "Lillium","Lillium","Lillium","Lillium","Lillium","Lillium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP)


			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		instance_destroy(id)
	}
	
	if (question == "Do you know who Dialga and Palkia is?")
	{
		var player = instance_find(PlayerObject, 0)
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.name = referenceNPC.name
		dialogue.actionNPC = referenceNPC
			
		if (currentOption == 0)
		{
			ds_list_add(dialogue.textList, "Yes, Palkia and Dialga… representing Time and Space, respectively.")
			ds_list_add(dialogue.nameList, "Lilium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP)
			
		}
		else
		{
			ds_list_add(dialogue.textList, "They’re two Pokémon seen in other regions… which were gods of sorts.", "Gods of Time and Space, respectively.")
			ds_list_add(nameList, "Lilium","Lilium")
			ds_list_add(iconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP)
		}

		player.talking = true

		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		
		ds_list_add(dialogue.textList, "And, of course, ARCEUS on the topmost platform… the mighty Pokémon who created this ENTIRE UNIVERSE.",
		"Each of them resides in their own universe, which is why you see them here on different platforms.",
		"Hnhh… you mortals wouldn’t care about things like this; this is all beyond your comprehension.",
		"But, we do live in a multiverse;",
		"And you are, right now, standing on the platform which represents the universe we currently inhabit.",
		"You see, like Palkia and Dialga, I was created by ARCEUS.",
		"He wanted me to simply observe, but how could I just observe when such misery existed and I had the knowledge to prevent it?", 
		"I therefore have devoted myself to BETRAYING the trust of Arceus, and BRINGING his knowledge to the people!",
		"To… to EMPOWER you to …",
		"…Not die so much.")
		ds_list_add(dialogue.nameList, "Lilium","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium","Lilium")
		ds_list_add(dialogue.iconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP)
	
		instance_destroy(id)
	}
	
	if (question == "React to Lilium's monologue.")
	{
		if (currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Such a limited viewpoint! It’s easy to condemn that which you don’t understand.",
			"I’m trying to help you, you schmuck!", "You guys always complain when you’re suffering… but then somehow *I’M* the bad guy for trying to alleviate it?",
			"Self-righteous trainers like you are quick to condemn me, but then when you get the power I’m trying to offer, you’d all use it to save yourselves when dying.",
			"Enough chatter! Let’s resolve this.", "That said... Are you ready to challenge me?")
			ds_list_add(dialogue.nameList, "Lilium","Lilium","Lilium","Lilium","Lilium","Lilium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC

			ds_list_add(dialogue.textList, "You’re welcome! I’m glad you approve.", "That is the reason for my experiments of converting people into BOOs and UMBRIANs", 
			"And converting animals into UMBREONs and so on.", "That is how I plan to ELEVATE humanity to the next level;", 
			"For only in that form can your minds process the information I wish to bestow.", "That said... Are you ready to challenge me?")
			ds_list_add(dialogue.nameList, "Lilium","Lilium","Lilium","Lilium","Lilium","Lilium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP,LilySprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		instance_destroy(id)
	}
	
	if (question == "React to Lilium's offer.")
	{
		if (currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			ds_list_add(dialogue.textList, "Done.")
			ds_list_add(dialogue.nameList, "Lilium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			ds_list_add(dialogue.textList, "You’ll be back. Sooner than you think, I bet.")
			ds_list_add(dialogue.nameList, "Lilium")
			ds_list_add(dialogue.iconList, LilySprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		instance_destroy(id)
	}
	
	if (question == "Did you bring inferior pokémon?")
	{
		var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "The mechanical is the way of the future. I aim to replace all life with Mechanics.", 
			"I will create the TRUE heirs to humanity", "who, like Greek mythology, are our betters and will conquer us in the end.")
			ds_list_add(dialogue.nameList, "The Collector","The Collector","The Collector")
			ds_list_add(dialogue.iconList, TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
			
			instance_destroy(id)
	}
	
	if (question == "React to the Collector.")
	{
		if (ds_list_find_value(optionList, currentOption) == "But YOU'RE biological!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "...For now.")
			ds_list_add(dialogue.nameList, "The Collector")
			ds_list_add(dialogue.iconList, TheCollectorSprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else if (ds_list_find_value(optionList, currentOption) == "So, you’re “inferior” then!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Until I get an upgrade, yes!",
			"it is an accident of my creation and soon enough I will be one of them as well.", 
			"I'm a future robot, you see.")
			ds_list_add(dialogue.nameList, "The Collector","The Collector","The Collector")
			ds_list_add(dialogue.iconList, TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		if (ds_list_find_value(optionList, currentOption) == "You’re pathetic.")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "At least I admit my patheticness!!", 
			"That’s it – I’ll show you the power of the Mechanical!!", "That said... Are you ready to challenge me?")
			ds_list_add(dialogue.nameList, "The Collector","The Collector","The Collector")
			ds_list_add(dialogue.iconList, TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else if (ds_list_find_value(optionList, currentOption) == "You’re insane! You’ve gone mad!")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Am I? Have I?", 
			"Or are you just afraid you’ve become OBSOLETE?!",
			"Time for you to feel the power of Robotics!!",
			"That said... Are you ready to challenge me?")
			ds_list_add(dialogue.nameList, "The Collector","The Collector","The Collector","The Collector")
			ds_list_add(dialogue.iconList, TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP)

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else if (ds_list_find_value(optionList, currentOption) == "A noble aim! I admire your ambition.")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "That’s right!! Glad you understand.",
			"That understanding will be nice for you to enjoy… BEFORE YOUR DOOM!!",
			"That said... Are you ready to challenge me?")
			ds_list_add(dialogue.nameList, "The Collector","The Collector","The Collector")
			ds_list_add(dialogue.iconList, TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP,TheCollectorSprite_CLOSEUP)

			
			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		instance_destroy(id)
	}
	
	if (question == "React to Zoovac's plan.")
	{
		if (ds_list_find_value(optionList, currentOption) == "And what plan is that…?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Why, the same as your plan!", "You... of course are a Pokémon trainer, are you not?")
			ds_list_add(dialogue.iconList, ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP)
			ds_list_add(dialogue.nameList, "Zoovac","Zoovac")
			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		else if (ds_list_find_value(optionList, currentOption) == "What’s your favorite color?")
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "What?? Green, what does that have to do with anything?",
			"Stay focused, Gash! This is important.", "Anyway, my plan is the same as your plan!",
			"You... of course are a Pokémon trainer, are you not?")
			ds_list_add(dialogue.iconList, ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP)
			ds_list_add(dialogue.nameList, "Zoovac","Zoovac","Zoovac","Zoovac")

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		instance_destroy(id)
	}
	
	if (question == "Are you a Pokémon trainer?")
	{
		var player = instance_find(PlayerObject, 0)
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.name = referenceNPC.name
		dialogue.actionNPC = referenceNPC
			
		ds_list_add(dialogue.textList, "And what do Pokémon Trainers do??")
		ds_list_add(dialogue.iconList, ZoovacSprite_CLOSEUP)
		ds_list_add(dialogue.nameList, "Zoovac")
		

		player.talking = true

		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		
		instance_destroy(id)
	}
	
	if (question == "What do Pokémon trainers do?")
	{
		var player = instance_find(PlayerObject, 0)
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.name = referenceNPC.name
		dialogue.actionNPC = referenceNPC
			
		ds_list_add(dialogue.textList, "That’s right!", "And how do we do that? What did you do to your Charmander to turn it into a Charmandalorian?")
		ds_list_add(dialogue.iconList, ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP)
		ds_list_add(dialogue.nameList, "Zoovac","Zoovac")
		player.talking = true

		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		
		instance_destroy(id)
	}
	
	if (question == "How did you evolve your Charmander?")
	{
		if (currentOption == 0)
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Yes, exactly right. You trained your Pokémon hard, and that is exactly what I mean to do to humanity!!", 
			"And how do we do that? What did you do to your Charmander to turn it into a Charmandalorian?")
			ds_list_add(dialogue.iconList, ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP)
			ds_list_add(dialogue.nameList, "Zoovac","Zoovac")

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
			
			instance_destroy(id)
		}
		else
		{
			var player = instance_find(PlayerObject, 0)
			var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
			dialogue.name = referenceNPC.name
			dialogue.actionNPC = referenceNPC
			
			ds_list_add(dialogue.textList, "Exactly – You evolved your Pokémon with rare candy and that is exactly what I mean to do to humanity!!", 
			"You see, I am the ultimate Pokémon trainer…!",
			"HUMANITY are my Pokémon!",
			"You guys trained Pokémon, but I am to you as you are to Pokémon.",
			"I am going to train you,",
			"Level you up,",
			"Evolve you,",
			"UNTIL I CAN BE THE VERY BEST!!!",
			"…",
			"You wouldn't understand, but this is necessary.",
			"There are threats from other regions that we need to be ready for.",
			"This is the only way to protect this world and I will not stop until I achieve that goal!",
			"That said... Are you ready to challenge me?")
			ds_list_add(dialogue.iconList, ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,
			ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,
			ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,
			ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,
			ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,
			ZoovacSprite_CLOSEUP,ZoovacSprite_CLOSEUP,
			ZoovacSprite_CLOSEUP,)
			ds_list_add(dialogue.nameList, "Zoovac","Zoovac",
			"Zoovac","Zoovac","Zoovac",
			"Zoovac","Zoovac","Zoovac",
			"Zoovac","Zoovac","Zoovac",
			"Zoovac","Zoovac")

			player.talking = true

			if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
		}
		
		instance_destroy(id)
	}
}

/*
Sphinx
if (ds_list_find_value(optionList, currentOption) == "Humans.")
{
    var player = instance_find(PlayerObject, 0);
    var dialogue = instance_create_depth(x, y, -9999999999999, TextboxObject);
    dialogue.actionNPC = referenceNPC;

	ds_list_add(dialogue.textList, "iuashjoidjcoi")

    player.talking = true;
    if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue);

    instance_destroy(id); // important: close the option menu
}
*/