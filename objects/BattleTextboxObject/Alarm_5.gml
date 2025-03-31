var newText = ds_list_find_value(textList, currentText)
var count = string_count("used", newText)
if (count > 0 and string_count("opposing", newText)) 
{
	whoAttacked = "Enemy"
	moveName = ChooseMove(enemyPkmn, playerPkmn)
	alarm[1] = GetMoveAnimationTime(moveName)
}
else if (count > 0 and string_count("opposing", newText) == 0)
{
	whoAttacked = "Player"
	moveName = ChooseMove(enemyPkmn, playerPkmn)
	alarm[1] = GetMoveAnimationTime(moveName)
}