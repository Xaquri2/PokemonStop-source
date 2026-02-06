if (!inactive and charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charCounter++
	if (charCounter >= 2)
	{
		charCounter = 0
		charNumber++
		if (charNumber >= string_length(ds_list_find_value(textList, currentText)))
		{
			alarm[2] = 100
		}
	}
}
if (instance_number(ImportantElementParent) > 0 and alarm[2] > 0) alarm[2]++

if (expGainValue > 0 and expGaining)
{
	if (alarm[2] > 0) alarm[2]++
	
	alarm[3] = 5
	var level = GetLevel(playerPkmn)
	if (expGainValue == 1 or GetExp(playerPkmn)+1 >= GetExpLevelFloor(101, GetGrowth(playerPkmn))) expGaining = false

	AddExp(playerPkmn, 1)
	expGainValue--

	var levelNew = GetLevel(playerPkmn)
	if (levelNew > level and !leveledUp) leveledUp = true
	if (leveledUp and expGainValue <= 0) ds_list_insert(textList, currentText+1, string_concat("Your Pokemon leveled up to Lvl ", levelNew))

	var newMoveName = LearnsMoveAt(GetName(playerPkmn), levelNew)
	if (leveledUp and ds_list_find_index(listLevelUpMoves, newMoveName) == -1)
	{
		var moveList = GetMoves(playerPkmn)
		if (newMoveName != "")
		{
			var youWinText = ""
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "You win!")
			{
				ds_list_delete(textList, ds_list_size(textList)-1)
				youWinText = "You win!"
			}

			if (ds_list_size(moveList) < 4)
			{
				ds_list_add(textList, string_concat("Your Pokemon learned ", newMoveName, "!"))
				LearnMove(playerPkmn, newMoveName, ds_list_size(moveList)-1)
			}
			else
			{
				ds_list_add(listLevelUpMoves, newMoveName)
				ds_list_add(textList, string_concat("Your Pokemon wants to learn ", newMoveName, "."),
				"However, it already knows four moves", "Would you like to replace one?")
			}

			if (youWinText != "") ds_list_add(textList, youWinText)
		}
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
	var target = -1
	while (target == -1)
	{
		for (var i = 0; i < instance_number(BattleEntityObject); i++)
		{
			var attempt = instance_find(BattleEntityObject, i)
			if ((attempt.player and whoAttacked == "Enemy") or (!attempt.player and whoAttacked == "Player"))
			{
				target = attempt
				break
			}
		}
	}

	alarm[3] = 5

	if (whoAttacked == "Player") DealDamage(1, true)
	else if (whoAttacked == "Enemy") DealDamage(1, false)
	damageValue -= 1

	if (damageValue == 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30
	}

	if (whoAttacked == "Player" and GetHealth(enemyPkmn) <= 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30

		target.currentPkmn++
		enemyPkmn = nextPkmn
		nextPkmn = -1
	}
	else if (whoAttacked == "Enemy" and GetHealth(playerPkmn) <= 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30

		target.currentPkmn++
		playerPkmn = nextPkmn
		nextPkmn = -1
	}
}
