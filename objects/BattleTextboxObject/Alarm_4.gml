var text = ds_list_find_value(textList, currentText)

if (currentText+1 >= ds_list_size(textList))
{
	alarm[0] = 60
}
else
{	
	if (string_count("opposing", ds_list_find_value(textList, currentText+1)) > 0
	and string_count("fainted", ds_list_find_value(textList, currentText+1)) > 0)
	{
		var enemyPkmnEntity = -1
		for (var i = 0; i < instance_number(BattlePokemonObject); i++)
		{
			var attempt = instance_find(BattlePokemonObject, i)
			if (!attempt.playerTeam)
			{
				enemyPkmnEntity = attempt
				break
			}
		}
		
		if (enemyPkmnEntity != -1)
		{
			alarm[3] = 120
			enemyPkmnEntity.alarm[1] = 120
		}
	}
}