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

if (whoAttacked == "Player" and GetHealth(enemyPkmn)-playerDamage <= 0) 
{
	var name = GetName(enemyPkmn)
	var level = GetLevel(enemyPkmn)
	var battle = instance_find(BattleObject, 0)
	var experience = GetEXPYield(name, level, 1, false, false)
	expGainValue = experience
	
	ds_list_add(textList, string_concat("The opposing ", name, " fainted"))
	ds_list_add(textList, string_concat("Your Pokemon gained ", experience, " EXP"))
		
	nextPkmn = ds_list_find_value(target.team, target.currentPkmn+1)
	battle.enemyPkmn = nextPkmn
	
	if (target.currentPkmn+1 >= ds_list_size(target.team)) 
	{
		endBattle = true
		target.currentPkmn = noone
		ds_list_add(textList, "You win!")
	}
	else 
	{
		name = GetName(nextPkmn)
		ds_list_add(textList, string_concat(battle.enemyName, " sent out ", name))
	}
}
if (whoAttacked == "Enemy" and GetHealth(playerPkmn)-enemyDamage <= 0) 
{
	var name = GetName(playerPkmn)
	var battle = instance_find(BattleObject, 0)
	ds_list_add(textList, string_concat(name, " fainted"))
	
	nextPkmn = ds_list_find_value(target.team, target.currentPkmn+1)
	battle.playerPkmn = nextPkmn
	if (target.currentPkmn+1 >= ds_list_size(target.team)) 
	{
		endBattle = true
		defeat = true
		target.currentPkmn = noone
		ds_list_add(textList, "You lose!")
	}
	else 
	{
		name = GetName(nextPkmn)
		ds_list_add(textList, string_concat("Go! ", name, "!"))
	}
}