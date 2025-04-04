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
	while (expGainValue > 0)
	{
		if (expGainValue-10 > 0)
		{
			AddExp(playerPkmn, 10)
			expGainValue -= 10
		}
		else
		{
			AddExp(playerPkmn, expGainValue)
			expGainValue = 0
		}
	
		for (var i = 0; i < instance_number(BattlePokemonObject); i++)
		{
			var attempt = instance_find(BattlePokemonObject, i)
			if (attempt.playerTeam) attempt.pkmnInfo = playerPkmn
		}
	
		for (var i = 0; i < instance_number(BattleEntityObject); i++)
		{
			var attempt = instance_find(BattleEntityObject, i)
			if (attempt.player)
			{
				ds_list_set(attempt.team, attempt.currentPkmn, playerPkmn)
				ds_list_set(global.playerParty, attempt.currentPkmn, playerPkmn)
			}
		}
	}
}