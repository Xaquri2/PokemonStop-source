if (keyboard_check_pressed(vk_enter)) 
{
	if (mode == "Choosing")
	{
		if (currentOption == 0)
		{
			mode = "Moves"
		}
	}
	else if (mode == "Moves")
	{
		var battle = instance_find(BattleObject, 0)
		var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
		battleText.playerPkmn = battle.playerPkmn
		battleText.enemyPkmn = battle.enemyPkmn
		battleText.whoAttacked = "Player"
		var superEffStr = ""
		
		var pName = GetName(battle.playerPkmn)
		var pLevel = GetLevel(battle.playerPkmn)
		var playerStats = GetPokemonFinalStats(pName, pLevel)
		
		var eName = GetName(battle.enemyPkmn)
		var eLevel = GetLevel(battle.enemyPkmn)
		var enemyStats = GetPokemonFinalStats(eName, eLevel)
		
		if (GetSpeedStat(playerStats) > GetSpeedStat(enemyStats))
		{
			//Player Move
			var moveName = ds_list_find_value(GetMoves(battle.playerPkmn), currentOption)
			var damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)		
			battleText.moveName = moveName
			battleText.playerDamage = damage
			
			if (damage > 0 and IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
			else if (damage > 0 and IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "
		
			ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."))
			
			if (floor(random_range(0,101)) <= GetMoveAccurancy(moveName)) 
			{
				if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
				if (floor(random_range(0,101)) <= GetMoveEffectChance(moveName))
				{
					var effectChance = GetMoveEffectChance(moveName)
					ds_list_add(battleText.textList, DealEffect(GetMoveEffect(moveName), effectChance, playerPkmn, enemyPkmn))
				}
			}
			else ds_list_add(battleText.textList, "But it missed!")
			
			if (GetHealth(battle.enemyPkmn) > damage)
			{
				//Enemy Move
				moveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
				damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
				battleText.moveName = moveName
				battleText.enemyDamage = damage
				
				superEffStr = ""
				if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
				else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
				ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."),
				string_concat(superEffStr, "It deals ", damage, " damage!"))
		
				if (GetHealth(battle.playerPkmn) <= 0) ds_list_add(battleText.textList, 
				string_concat(GetName(battle.playerPkmn)," fainted!"))
			}
		}
		else if (GetSpeedStat(enemyStats) > GetSpeedStat(playerStats))
		{
			//Enemy Move
			var moveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
			var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
			battleText.moveName = moveName
			battleText.enemyDamage = damage
			
			if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
			else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
			ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."),
			string_concat(superEffStr, "It deals ", damage, " damage!"))
		
			if (GetHealth(battle.playerPkmn) > damage)
			{
				//Player Move
				moveName = ds_list_find_value(GetMoves(battle.playerPkmn), currentOption)
				damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)		
				battleText.moveName = moveName
				battleText.playerDamage = damage
				
				superEffStr = ""
				if (IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
				else if (IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "
		
				ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."),
				string_concat(superEffStr, "It deals ", damage, " damage!"))
		
				if (GetHealth(battle.enemyPkmn) <= 0) ds_list_add(battleText.textList, 
				string_concat("The opposing ", GetName(battle.enemyPkmn)," fainted!"))
			}
		}
		instance_destroy(id)
	}
}

if (mode == "Choosing" or mode == "Moves")
{
	if (keyboard_check_pressed(ord("W"))) currentOption -= 2
	if (keyboard_check_pressed(ord("S"))) currentOption += 2
	if (keyboard_check_pressed(ord("A"))) 
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
	if (keyboard_check_pressed(ord("D"))) 
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
}

if (currentOption < 0) currentOption += 4
if (currentOption > 3) currentOption -= 4