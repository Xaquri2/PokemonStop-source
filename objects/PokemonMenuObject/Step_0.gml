if (keyboard_check_pressed(ord("E")) and canInteract) 
{
	if (bagMenu != noone)
	{
		bagMenu.hasSelected = false
		instance_destroy(id)
	}
	else
	{
		if (summaryMode)
		{
			moveIndex = 0
			summaryMode = false
		}
		else
		{
			if (!switchMode)
			{
				menu.active = true
				instance_destroy(id)
			}
			else 
			{
				switchIndex = -1
				switchMode = false
			}
		}
	}
}

if (keyboard_check_pressed(vk_enter) and canInteract)
{
	if (switchMode)
	{
		var temp = ds_list_find_value(global.playerParty, selectedIndex)
		ds_list_set(global.playerParty, selectedIndex, ds_list_find_value(global.playerParty, switchIndex))
		ds_list_set(global.playerParty, switchIndex, temp)
		
		switchMode = false
	}
	else
	{
		if (!summaryMode and !switchMode and !itemUse)
		{
			canInteract = false
			var options = instance_create_layer(x,y,layer,PokemonMenuOptionsObject)
			options.xOffset = view_get_wport(0)*0.14
			options.yOffset = view_get_hport(0)*(0.1+(0.14*selectedIndex))
			options.menu = id
			options.depth = depth-1
		
			var pkmnInfo = GetPartyMemberInfo(global.playerParty, selectedIndex)
			ds_list_add(options.optionList, "Summary", "Switch")
			if (CanEvolve(global.playerParty, selectedIndex)) ds_list_add(options.optionList, "Evolve")
		}
		else if (itemUse)
		{
			var healValue = GetHealValue(itemName)
			if (healValue != -1)
			{
				if (instance_number(PlayerObject) > 0)
				{
					HealPokemon(global.playerParty, selectedIndex, healValue, true)
					var player = instance_find(PlayerObject, 0)
					player.alarm[0] = 5
				}
				else
				{
					var battleMenu = instance_find(BattleMenuObject, 0)
					battleMenu.mode = "Choosing"
					
					var playerPkmn = -1
					var enemyPkmn = -1
					for (var i = 0; i < instance_number(BattlePokemonObject); i++)
					{
						var attempt = instance_find(BattlePokemonObject, i)
						if (!attempt.playerTeam) enemyPkmn = attempt
						else playerPkmn = attempt
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
						ds_list_add(battleText.textList, string_concat("You used a ", itemName))

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
	
					HealPokemon(global.playerParty, selectedIndex, 20, true)
					instance_destroy(battleMenu)
				}
				
				instance_destroy(id)
			
				ConsumeItem(bagMenu.selectedCategory, bagMenu.selectedItem, 1)
				if (bagMenu != noone) instance_destroy(bagMenu)
			}
		}
	}
}

if (!summaryMode and canInteract)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
}
else if (summaryMode)
{
	if (keyboard_check_pressed(ord("W"))) moveIndex -= 2
	if (keyboard_check_pressed(ord("S"))) moveIndex += 2
	if (keyboard_check_pressed(ord("A"))) 
	{
		if (moveIndex % 2 == 0) moveIndex += 1
		else moveIndex -= 1
	}
	if (keyboard_check_pressed(ord("D"))) 
	{
		if (moveIndex % 2 == 0) moveIndex += 1
		else moveIndex -= 1
	}
}

if (moveIndex < 0) moveIndex += 4
if (moveIndex > 3) moveIndex -= 4

if (selectedIndex == ds_list_size(global.playerParty)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(global.playerParty)-1