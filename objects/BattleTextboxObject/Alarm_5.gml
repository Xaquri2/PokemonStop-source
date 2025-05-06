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

		var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
		attackC.alarm[0] = alarm[1]
		attackC.moveName = moveName
		attackC.whoAttacked = whoAttacked
		attackC.particleSpawnTime = floor(alarm[1] / 2)
	}
}

if (string_count("threw", newText) > 0)
{
	catching = true
	alarm[6] = 60
	//Check if caught, and then end battle if true
}