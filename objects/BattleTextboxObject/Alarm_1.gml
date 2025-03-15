DealDamage(GetDamage(playerPkmn, enemyPkmn, moveName))

var enemy = -1
while (enemy == -1)
{
	for (var i = 0; i < instance_number(BattleEntityObject); i++)
	{
		var attempt = instance_find(BattleEntityObject, i)
		if (!attempt.player) 
		{
			enemy = attempt
			break
		}
	}
}

if (GetHealth(enemyPkmn) == 0) 
{
	var name = GetName(enemyPkmn)
	var battle = instance_find(BattleObject, 0)
	ds_list_add(textList, string_concat("The opposing ", name, " fainted"))
	
	enemy.currentPkmn++
	enemyPkmn = ds_list_find_value(enemy.team, enemy.currentPkmn)
	battle.enemyPkmn = enemyPkmn
	
	if (enemy.currentPkmn >= ds_list_size(enemy.team)) 
	{
		enemy.currentPkmn = -1
	}
	else 
	{
		name = GetName(enemyPkmn)
		ds_list_add(textList, string_concat(battle.enemyName, " sent out ", name))
	}
}

alarm[4] = 30