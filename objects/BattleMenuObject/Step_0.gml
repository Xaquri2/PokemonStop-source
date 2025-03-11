if (keyboard_check_pressed(vk_enter)) 
{
	if (mode == "Choosing")
	{
		if (currentOption == 0)
		{
			mode = "Moves"
		}
	}
	else if (mode == "Moves")
	{
		var battle = instance_find(BattleObject, 0)
		var moveName = ds_list_find_value(GetMoves(battle.playerPkmn), currentOption)
		var damage = GetDamage(battle.playerPkmn, battle.enemyPkmn, moveName)
		
		var battleText = instance_create_layer(0,0,"UIElements",BattleTextboxObject)
		ds_list_add(battleText.textList, string_concat(GetName(battle.playerPkmn), " uses ", moveName, ". It deals ", damage, " damage!"))
		instance_destroy(id)
	}
}

if (mode == "Choosing" or mode == "Moves")
{
	if (keyboard_check_pressed(ord("W"))) currentOption -= 2
	if (keyboard_check_pressed(ord("S"))) currentOption += 2
	if (keyboard_check_pressed(ord("A"))) 
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
	if (keyboard_check_pressed(ord("D"))) 
	{
		if (currentOption % 2 == 0) currentOption += 1
		else currentOption -= 1
	}
}

if (currentOption < 0) currentOption += 4
if (currentOption > 3) currentOption -= 4