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
	if (expGainValue == 1) expGaining = false
	var level = GetLevel(playerPkmn)
	
	AddExp(playerPkmn, 1)
	expGainValue--
	
	var levelNew = GetLevel(playerPkmn)
	if (levelNew > level)
	{
		ds_list_insert(textList, currentText+1, string_concat("Your Pokemon leveled up to Lvl ", levelNew))
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

if (damageValue > 0 and damaging)
{
	alarm[3] = 5
	if (damageValue == 1) 
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30
	}
	if (whoAttacked == "Player") DealDamage(0.2, true)
	else if (whoAttacked == "Enemy") DealDamage(0.2, false)
	damageValue -= 0.2
	
	if (GetHealth(enemyPkmn) <= 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30
	}
}