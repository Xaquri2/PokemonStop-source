var newText = ds_list_find_value(textList, currentText)
if (string_count("used", newText) > 0)
{
	if (string_count("You", newText) > 0)
	{
		whoAttacked = "Enemy" //This is for playing the animation on the player's pokémon
		moveName = playerMoveName
	}
	else
	{
		if (string_count("opposing", newText) > 0)
		{
			whoAttacked = "Enemy"
			moveName = enemyMoveName
			alarm[1] = GetMoveAnimationTime(moveName)
		}
		else if (string_count("opposing", newText) == 0)
		{
			whoAttacked = "Player"
			moveName = playerMoveName
			alarm[1] = GetMoveAnimationTime(moveName)
		}
		
		if (ds_list_find_value(textList, currentText+1) != "But it missed!")
		{
			var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
			attackC.alarm[0] = alarm[1]
			attackC.moveName = moveName
			attackC.whoAttacked = whoAttacked
			attackC.particleSpawnTime = floor(alarm[1] / 2)
		}
	}
}
if (string_count("poison damage", newText) > 0 or string_count("burn damage", newText) > 0)
				{
					ScheduleBattleStatusDamage(id, newText)
				}

				if (string_count("threw", newText) > 0)
{
	catching = true
	alarm[6] = 60
}

if (string_count("come back", newText) > 0)
{
	switching = true
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if (attempt.playerTeam)
		{
			attempt.switching = true
			attempt.textbox = id
		}
	}
}
