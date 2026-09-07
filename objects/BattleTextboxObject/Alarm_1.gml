alarm[3] = 5
damaging = true
if (whoAttacked == "Player")
{
	if (!recoil) damageValue = playerDamage
	else damageValue = eRecoilDamage
}
else if (whoAttacked == "Enemy")
{
	if (!recoil) damageValue = enemyDamage
	else damageValue = pRecoilDamage
}

var target = noone
for (var i = 0; i < instance_number(BattleEntityObject); i++)
{
	var attempt = instance_find(BattleEntityObject, i)
	if ((attempt.player and whoAttacked == "Enemy") or (!attempt.player and whoAttacked == "Player"))
	{
		target = attempt
		break
	}
}
if (target == noone)
{
	damaging = false
	alarm[0] = 1
	exit
}

if (GetMoveCategory(moveName) != "Status")
{
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if (attempt.playerTeam and whoAttacked == "Enemy")
		{
			attempt.flash = true
			attempt.alarm[3] = 20
		}
		else if (!attempt.playerTeam and whoAttacked == "Player")
		{
			attempt.flash = true
			attempt.alarm[3] = 20
		}
	}
}

if (!recoil)
{
	if (whoAttacked == "Player" and GetHealth(enemyPkmn)-playerDamage <= 0)
	{
		var name = GetName(enemyPkmn)
		var level = GetLevel(enemyPkmn)
		var battle = instance_find(BattleObject, 0)
		var experience = GetEXPYield(name, level, 1, false, false)
		expGainValue = experience

		ds_list_add(textList, string_concat("The opposing ", name, " fainted"))
		ds_list_add(textList, string_concat("Your Pokemon gained ", experience, " EXP"))

		var nextEnemyIndex = target.currentPkmn+1
		var hasNextEnemy = nextEnemyIndex >= 0 and nextEnemyIndex < ds_list_size(target.team)
		if (hasNextEnemy)
		{
			nextPkmn = ds_list_find_value(target.team, nextEnemyIndex)
			hasNextEnemy = nextPkmn != undefined
		}

		if (!hasNextEnemy)
		{
			endBattle = true
			target.currentPkmn = noone
			var hasGainedItems = GetTrainerLoot(GetTrainerRank(battle.enemyName))
			if (hasGainedItems) ds_list_add(textList, "You earned some items!")
			ds_list_add(textList, "You win!")
		}
		else
		{
			battle.enemyPkmn = nextPkmn
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat(battle.enemyName, " sent out ", name))
		}
	}
	if (whoAttacked == "Enemy" and GetHealth(playerPkmn)-enemyDamage <= 0)
	{
		var name = GetName(playerPkmn)
		var battle = instance_find(BattleObject, 0)
		ds_list_add(textList, string_concat(name, " fainted"))

		nextPkmnIndex = GetFirstHealthyPokemonExcept(target.currentPkmn)
		target.switchIndex = -1
		if (nextPkmnIndex == -1)
		{
			if (global.pikminCount > 0)
			{
				nextPkmn = ds_list_find_value(battle.pikminList, 0)
				ds_list_delete(battle.pikminList, 0)
				AddPokemon(GetName(nextPkmn), GetLevel(nextPkmn), GetGender(nextPkmn))
				global.pikminCount--
				
				name = GetName(nextPkmn)
				ds_list_add(textList, string_concat("Go! ", name, "!"))
			}
			else
			{
				endBattle = true
				defeat = true
				target.currentPkmn = noone
				ds_list_add(textList, "You lose!")
			}
		}
		else
		{
			nextPkmn = ds_list_find_value(target.team, nextPkmnIndex)
			battle.playerPkmn = nextPkmn
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat("Go! ", name, "!"))
		}
	}
}
else
{
	for (var i = currentText+1; i < ds_list_size(textList); i++)
	{
		ds_list_delete(textList, i)
	}

	if (whoAttacked == "Player" and GetHealth(enemyPkmn)-eRecoilDamage <= 0)
	{
		var name = GetName(enemyPkmn)
		var level = GetLevel(enemyPkmn)
		var battle = instance_find(BattleObject, 0)
		var experience = GetEXPYield(name, level, 1, false, false)
		expGainValue = experience

		ds_list_add(textList, string_concat("The opposing ", name, " fainted"))
		ds_list_add(textList, string_concat("Your Pokemon gained ", experience, " EXP"))

		var nextEnemyIndex = target.currentPkmn+1
		var hasNextEnemy = nextEnemyIndex >= 0 and nextEnemyIndex < ds_list_size(target.team)
		if (hasNextEnemy)
		{
			nextPkmn = ds_list_find_value(target.team, nextEnemyIndex)
			hasNextEnemy = nextPkmn != undefined
		}

		if (!hasNextEnemy)
		{
			endBattle = true
			target.currentPkmn = noone
			ds_list_add(textList, "You win!")
		}
		else
		{
			battle.enemyPkmn = nextPkmn
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat(battle.enemyName, " sent out ", name))
		}
	}
	if (whoAttacked == "Enemy" and GetHealth(playerPkmn)-pRecoilDamage <= 0)
	{
		var name = GetName(playerPkmn)
		var battle = instance_find(BattleObject, 0)
		ds_list_add(textList, string_concat(name, " fainted"))

		nextPkmnIndex = GetFirstHealthyPokemonExcept(target.currentPkmn)
		target.switchIndex = -1
		if (nextPkmnIndex == -1)
		{
			if (global.pikminCount > 0)
			{
				nextPkmn = ds_list_find_value(battle.pikminList, 0)
				ds_list_delete(battle.pikminList, 0)
				AddPokemon(GetName(nextPkmn), GetLevel(nextPkmn), GetGender(nextPkmn))
				global.pikminCount--
				
				name = GetName(nextPkmn)
				ds_list_add(textList, string_concat("Go! ", name, "!"))
			}
			else
			{
				endBattle = true
				defeat = true
				target.currentPkmn = noone
				ds_list_add(textList, "You lose!")
			}
		}
		else
		{
			nextPkmn = ds_list_find_value(target.team, nextPkmnIndex)
			battle.playerPkmn = nextPkmn
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat("Go! ", name, "!"))
		}
	}
}
