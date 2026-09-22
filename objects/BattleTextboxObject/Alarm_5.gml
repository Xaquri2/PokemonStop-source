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
if (string_count("poison damage", newText) > 0)
{
	var otherEntity = "Enemy"
	var name = GetName(playerPkmn)
	var level = GetLevel(playerPkmn)
	enemyDamage = clamp(floor(GetHPStat(GetPokemonFinalStats(name, level))/16), 1, 1000000)

	if (string_count("opponent", newText) > 0)
	{
		name = GetName(enemyPkmn)
		level = GetLevel(enemyPkmn)
		otherEntity = "Player"
		playerDamage = clamp(floor(GetHPStat(GetPokemonFinalStats(name, level))/16), 1, 1000000)
	}

	whoAttacked = otherEntity
	alarm[1] = GetMoveAnimationTime(moveName)
	
	var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
	attackC.alarm[0] = alarm[1]
	attackC.moveName = "Poison"
	attackC.whoAttacked = otherEntity
	attackC.particleSpawnTime = floor(alarm[1] / 2)
}
if (string_count("burn damage", newText) > 0)
{
	var otherEntity = "Enemy"
	var name = GetName(playerPkmn)
	var level = GetLevel(playerPkmn)
	enemyDamage = clamp(floor(GetHPStat(GetPokemonFinalStats(name, level))/16), 1, 1000000)

	if (string_count("opponent", newText) > 0)
	{
		name = GetName(enemyPkmn)
		level = GetLevel(enemyPkmn)
		otherEntity = "Player"
		playerDamage = clamp(floor(GetHPStat(GetPokemonFinalStats(name, level))/16), 1, 1000000)
	}

	whoAttacked = otherEntity
	alarm[1] = GetMoveAnimationTime(moveName)

	var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
	attackC.alarm[0] = alarm[1]
	attackC.moveName = "Burn"
	attackC.whoAttacked = otherEntity
	attackC.particleSpawnTime = floor(alarm[1] / 2)
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
