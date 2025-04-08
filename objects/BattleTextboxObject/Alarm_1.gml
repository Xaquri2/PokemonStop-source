var a = playerDamage

alarm[3] = 5
damaging = true
if (whoAttacked == "Player") damageValue = playerDamage
else if (whoAttacked == "Enemy") damageValue = enemyDamage

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

for (var i = 0; i < instance_number(BattlePokemonObject); i++)
{
	var attempt = instance_find(BattlePokemonObject, i)
	if (attempt.playerTeam and whoAttacked == "Enemy") 
	{
		attempt.flash = true
		attempt.alarm[3] = 60
	}
	else if (!attempt.playerTeam and whoAttacked == "Player")
	{
		attempt.flash = true
		attempt.alarm[3] = 60
	}
}

if (whoAttacked == "Player" and GetHealth(enemyPkmn)-playerDamage == 0) 
{
	var name = GetName(enemyPkmn)
	var level = GetLevel(enemyPkmn)
	var battle = instance_find(BattleObject, 0)
	var experience = GetEXPYield(name, level, 1, false, false)
	expGainValue = experience
	
	ds_list_add(textList, string_concat("The opposing ", name, " fainted"))
	ds_list_add(textList, string_concat("Your Pokemon gained ", experience, " EXP"))
		
	target.currentPkmn++
	enemyPkmn = ds_list_find_value(target.team, target.currentPkmn)
	battle.enemyPkmn = enemyPkmn
	
	if (target.currentPkmn >= ds_list_size(target.team)) 
	{
		endBattle = true
		enemy.currentPkmn = -1
		ds_list_add(textList, "You win!")
	}
	else 
	{
		name = GetName(enemyPkmn)
		ds_list_add(textList, string_concat(battle.enemyName, " sent out ", name))
	}
}
if (whoAttacked == "Enemy" and GetHealth(playerPkmn)-enemyDamage == 0) 
{
	var name = GetName(playerPkmn)
	var battle = instance_find(BattleObject, 0)
	ds_list_add(textList, string_concat(name, " fainted"))
	
	target.currentPkmn++
	playerPkmn = ds_list_find_value(target.team, target.currentPkmn)
	battle.playerPkmn = playerPkmn
	a = target.player
	if (target.currentPkmn >= ds_list_size(target.team)) 
	{
		endBattle = true
		target.currentPkmn = -1
		ds_list_add(textList, "You lose!")
	}
	else 
	{
		name = GetName(playerPkmn)
		ds_list_add(textList, string_concat("Go! ", name, "!"))
	}
}