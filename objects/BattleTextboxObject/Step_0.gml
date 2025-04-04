if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charCounter++
	if (charCounter >= 2) 
	{
		charCounter = 0
		charNumber++
	}
}

if (expGainValue > 0 and expGaining)
{
	alarm[3] = 5
	if (expGainValue-1 > 0)
	{
		AddExp(playerPkmn, 1)
		expGainValue -= 1
	}
	else
	{
		AddExp(playerPkmn, expGainValue)
		expGainValue = 0
		expGaining = false
	}
		
	var entity = -1
	for (var i = 0; i < instance_number(BattleEntityObject); i++)
	{
		var attempt = instance_find(BattleEntityObject, i)
		if (attempt.player)
		{
			entity = attempt
			ds_list_set(attempt.team, attempt.currentPkmn, playerPkmn)
			ds_list_set(global.playerParty, attempt.currentPkmn, playerPkmn)
		}
	}
		
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if (attempt.playerTeam) 
		{
			attempt.pkmnInfo = playerPkmn
			ds_list_set(attempt.team, entity.currentPkmn, playerPkmn)
		}
	}
}