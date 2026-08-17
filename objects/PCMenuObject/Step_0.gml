if (keyboard_check_pressed(ord("W"))) currentOption -= 4
if (keyboard_check_pressed(vk_up)) currentOption -= 4
if (keyboard_check_pressed(ord("S"))) currentOption += 4
if (keyboard_check_pressed(vk_down)) currentOption += 4
if (keyboard_check_pressed(ord("A")) or keyboard_check_pressed(vk_left))
{
	if ((currentOption % 4 == 0 and currentOption-1 != 0) or currentOption-1 < 0)
	{
		if (page > 0) page--
		else page = 5-1
		currentOption += 3
	}
	else currentOption--
}

if (keyboard_check_pressed(ord("D")) or keyboard_check_pressed(vk_right))
{
	if ((currentOption+1) % 4 == 0)
	{
		if (page < 5-1) page++
		else page = 0
		currentOption -= 3
	}
	else currentOption++
}

if (summaryMode) pokemonNumber = 1+currentOption+pageAmount*page
else pokemonNumber = -1

if (keyboard_check_pressed(vk_enter))
{
	var menuIndex = currentOption+pageAmount*page
	if (!switching and ds_list_size(global.pokemonList) > menuIndex)
	{
		var pkmnMenu = instance_create_depth(x,y,depth-1,PokemonMenuObject)
		pkmnMenu.pcSwitchMode = true
		pkmnMenu.switchIndex = currentOption+pageAmount*page
		menu.optionMenu = noone
		instance_destroy(id)
	}
}

if ((currentOption+1)%4==0) //Right side arrow
{
	arrowDir = 1
	if (arrowAlpha < 1) arrowAlpha += 0.05
}
else if ((currentOption % 4 == 0 and currentOption-1 != 0) or currentOption-1 < 0) //Left side arrow
{
	arrowDir = -1
	if (arrowAlpha < 1) arrowAlpha += 0.05
}
else { if (arrowAlpha > 0) arrowAlpha -= 0.05 }

if (keyboard_check_pressed(ord("E")))
{
	instance_destroy(id)
	menu.visible = true
	menu.active = true
}
