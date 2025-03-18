if (whoAttacked == "Player") DealDamage(GetDamage(playerPkmn, enemyPkmn, moveName), true)
else if (whoAttacked == "Enemy") DealDamage(GetDamage(playerPkmn, enemyPkmn, moveName), false)
//The issue is that whoAttacked is always ""

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

if (GetHealth(enemyPkmn) == 0) 
{
	if (whoAttacked == "Player")
	{
		var name = GetName(enemyPkmn)
		var battle = instance_find(BattleObject, 0)
		ds_list_add(textList, string_concat("The opposing ", name, " fainted"))
	
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
	else if (whoAttacked == "Enemy")
	{
		var name = GetName(playerPkmn)
		var battle = instance_find(BattleObject, 0)
		ds_list_add(textList, string_concat(name, " fainted"))
	
		target.currentPkmn++
		playerPkmn = ds_list_find_value(target.team, target.currentPkmn)
		battle.playerPkmn = playerPkmn
	
		if (target.currentPkmn >= ds_list_size(target.team)) 
		{
			endBattle = true
			target.currentPkmn = -1
			ds_list_add(textList, "You lose!")
		}
		else 
		{
			name = GetName(playerPkmn)
			ds_list_add(textList, string_concat("Go, ", name, "!"))
		}
	}
}

whoAttacked = ""
alarm[4] = 30