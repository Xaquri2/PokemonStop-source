var newText = ds_list_find_value(textList, currentText)
var count = string_count("used", newText)
if (count > 0)
{
	if (string_count("opposing", newText)) 
	{
		whoAttacked = "Enemy"
		moveName = ChooseMove(enemyPkmn, playerPkmn)
		alarm[1] = GetMoveAnimationTime(moveName)
	}
	else if (string_count("opposing", newText) == 0)
	{
		whoAttacked = "Player"
		moveName = ChooseMove(enemyPkmn, playerPkmn)
		alarm[1] = GetMoveAnimationTime(moveName)
	}

	var attackC = instance_create_layer(0,0,"Particles",AttackControllerObject)
	attackC.alarm[0] = alarm[1]
	attackC.whoAttacked = whoAttacked
	attackC.particleSpawnTime = floor(alarm[1] / 2)
}