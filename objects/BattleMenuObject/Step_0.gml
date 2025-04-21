if (keyboard_check_pressed(vk_enter)) 
{
	if (mode == "Choosing")
	{
		switch (currentOption)
		{
			case 0:
				mode = "Moves"
				break
			case 1:
				var bag = instance_create_layer(x,y,layer,BagMenuObject)
				bag.menu = id
				bag.battle = true
				mode = "Bag"
				break
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
		
		var playerMoveName = ds_list_find_value(GetMoves(battle.playerPkmn), currentOption)
		var moveName = playerMoveName
		var moveTotalPP = GetMovePP(moveName)
		var moveCurrentPP = (ds_list_find_value(GetMovePPList(battle.playerPkmn), currentOption))
		
		if (moveCurrentPP > 0)
		{	
			ConsumePP(battle.playerPkmn, currentOption)
			var enemyMoveName = ChooseMove(battle.enemyPkmn, battle.playerPkmn)
		
			var pPriority = GetMovePriority(playerMoveName)
			var ePriority = GetMovePriority(enemyMoveName)
		
			if (GetSpeedStat(playerStats) > GetSpeedStat(enemyStats) or pPriority > ePriority)
			{
				//Player Move
				var moveEff = GetMoveEffect(moveName)
				var damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)		
				battleText.playerMoveName = moveName
				battleText.playerDamage = damage
			
				if (damage > 0 and IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
				else if (damage > 0 and IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "
		
				ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."))
			
				var moveAcc = GetMoveAccurancy(moveName)
				var effectAcc = GetMoveEffectChance(moveName)*100
				
				var accRoll = floor(random_range(0,101))
				if (accRoll <= moveAcc) 
				{
					if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
					if (floor(random_range(0,101)) <= effectAcc)
					{
						var effStr = DealEffect(moveEff, effectAcc, playerPkmn, enemyPkmn)
						if (effStr != "") ds_list_add(battleText.textList, effStr)
					}
				}
				else ds_list_add(battleText.textList, "But it missed!")
			
				if (GetHealth(battle.enemyPkmn) > damage)
				{
					//Enemy Move
					moveName = enemyMoveName
					moveEff = GetMoveEffect(moveName)
					damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
					battleText.enemyMoveName = moveName
					battleText.enemyDamage = damage
				
					superEffStr = ""
					if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
					else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
					ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName))
		
					moveAcc = GetMoveAccurancy(moveName)
					effectAcc = GetMoveEffectChance(moveName)*100
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
			else if (GetSpeedStat(enemyStats) > GetSpeedStat(playerStats) or ePriority > pPriority)
			{
				moveName = enemyMoveName
				var moveEff = GetMoveEffect(moveName)
				var damage = GetDamage(battle.enemyPkmn, battle.playerPkmn, moveName)
				battleText.enemyMoveName = moveName
				battleText.enemyDamage = damage
			
				if (IsMoveSuperEffective(moveName, battle.playerPkmn)) superEffStr = "It was super effective! "
				else if (IsMoveNotVeryEffective(moveName, battle.playerPkmn)) superEffStr = "It was not very effective! "
		
				ds_list_add(battleText.textList, string_concat("The opposing ", GetName(battle.enemyPkmn), " used ", moveName, "."))
			
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
		
				if (GetHealth(battle.playerPkmn) > damage)
				{
					//Player Move
					moveName = playerMoveName
					moveEff = GetMoveEffect(moveName)
					damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)		
					battleText.moveName = moveName
					battleText.playerMoveName = moveName
					battleText.playerDamage = damage
				
					superEffStr = ""
					if (IsMoveSuperEffective(moveName, battle.enemyPkmn)) superEffStr = "It was super effective! "
					else if (IsMoveNotVeryEffective(moveName, battle.enemyPkmn)) superEffStr = "It was not very effective! "
		
					ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " used ", moveName, "."),)
				
				    moveAcc = GetMoveAccurancy(moveName)
					effectAcc = GetMoveEffectChance(moveName)*100
					if (floor(random_range(0,101)) <= moveAcc) 
					{
						if (damage > 0) ds_list_add(battleText.textList, string_concat(superEffStr, "It deals ", damage, " damage!"))
						if (floor(random_range(0,101)) <= effectAcc)
						{
							var effStr = DealEffect(moveEff, effectAcc, playerPkmn, enemyPkmn)
							if (effStr != "") ds_list_add(battleText.textList, effStr)
						}
					}
					else ds_list_add(battleText.textList, "But it missed!")
				
					if (GetHealth(battle.enemyPkmn) <= 0) ds_list_add(battleText.textList, 
					string_concat("The opposing ", GetName(battle.enemyPkmn)," fainted!"))
				}
			}
			instance_destroy(id)
		}
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