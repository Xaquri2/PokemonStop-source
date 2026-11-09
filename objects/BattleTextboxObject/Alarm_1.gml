// Later messages can still refer to the Pokemon that fainted earlier this turn.
var damagedPokemon = whoAttacked == "Player" ? enemyPkmn : playerPkmn
if (GetHealth(damagedPokemon) <= 0)
{
	damaging = false
	damageValue = 0
	exit
}

alarm[3] = 5
damaging = true
if (whoAttacked == "Player")
{
	if (!recoil) damageValue = playerDamage
	else damageValue = eRecoilDamage
	if (BattleObject.Fluxxed2) damageValue *= random_range(0.8,1.2)
}
else if (whoAttacked == "Enemy")
{
	if (!recoil) damageValue = enemyDamage
	else damageValue = pRecoilDamage
	if (BattleObject.Fluxxed2) damageValue *= random_range(0.8,1.2)
}

// HP is removed one point per tick. Use that same whole-number total when
// predicting knockouts, including fractional recoil/traps and Flux modifiers.
damageValue = max(0, ceil(damageValue))

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
		if (attempt.playerTeam and whoAttacked == "Enemy" and playerDamage > 0)
		{
			attempt.flash = true
			attempt.alarm[3] = 20
		}
		else if (!attempt.playerTeam and whoAttacked == "Player" and enemyDamage > 0)
		{
			attempt.flash = true
			attempt.alarm[3] = 20
		}
	}
}

if (!recoil)
{
	if (whoAttacked == "Player" and GetHealth(enemyPkmn)-damageValue <= 0)
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
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat(battle.enemyName == "Mary2" ? "Mary" : battle.enemyName, " sent out ", name))
		}
	}
	if (whoAttacked == "Enemy" and GetHealth(playerPkmn)-damageValue <= 0)
	{
		var name = GetName(playerPkmn)
		var battle = instance_find(BattleObject, 0)
		var delayEnemyFaintUser = GetMoveEffect(enemyMoveName) == "FaintUser"

		// Voltorb's self-damage text is normally already next in the queue.
		// If its attack also KOs the player, resolve the player's faint and
		// replacement first so the old on-field entity is actually removed.
		if (delayEnemyFaintUser)
		{
			for (var i = ds_list_size(textList)-1; i > currentText; i--)
			{
				ds_list_delete(textList, i)
			}
		}

		ds_list_add(textList, string_concat(name, " fainted"))

		nextPkmnIndex = GetFirstHealthyPokemonExcept(target.currentPkmn)
		target.switchIndex = -1
		if (nextPkmnIndex == -1)
		{
			if (global.pikminCount > 0)
			{
				nextPkmn = ds_list_find_value(battle.pikminList, 0)
				ds_list_delete(battle.pikminList, 0)
				if (ds_list_size(global.playerParty) == 6) battle.currentPikmin = nextPkmn
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
				if (!delayEnemyFaintUser) ds_list_add(textList, "You lose!")
			}
		}
		else
		{
			nextPkmn = ds_list_find_value(target.team, nextPkmnIndex)
			battle.playerPkmn = nextPkmn
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat("Go! ", name, "!"))
		}

		if (delayEnemyFaintUser)
		{
			ds_list_add(textList, "The opponent took some damage!")
			if (endBattle and defeat) ds_list_add(textList, "You lose!")
		}
	}
}
else
{
	// Surviving recoil must not erase a knockout already queued by the attack.
	// On a recoil KO, cancel remaining actions but retain pending faint/EXP/send-out
	// messages for the other side (both Pokemon can faint on the same turn).
	if (GetHealth(damagedPokemon)-damageValue <= 0)
	{
		var resolutionStart = ds_list_size(textList)
		for (var i = currentText+1; i < ds_list_size(textList); i++)
		{
			if (string_count("fainted", ds_list_find_value(textList, i)) > 0)
			{
				resolutionStart = i
				break
			}
		}
		for (var i = resolutionStart-1; i > currentText; i--)
			ds_list_delete(textList, i)
	}

	if (whoAttacked == "Player" and GetHealth(enemyPkmn)-damageValue <= 0)
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
			name = GetName(nextPkmn)
			ds_list_add(textList, string_concat(battle.enemyName == "Mary2" ? "Mary" : battle.enemyName, " sent out ", name))
		}
	}
	if (whoAttacked == "Enemy" and GetHealth(playerPkmn)-damageValue <= 0)
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
