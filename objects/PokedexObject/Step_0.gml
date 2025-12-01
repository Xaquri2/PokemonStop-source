if (keyboard_check_pressed(ord("W"))) currentOption -= 4
if (keyboard_check_pressed(ord(vk_up))) currentOption -= 4
if (keyboard_check_pressed(ord("S"))) currentOption += 4
if (keyboard_check_pressed(ord(vk_down))) currentOption += 4
if (keyboard_check_pressed(ord("A")))
{
	if (((currentOption-1) % 4 == 0 and currentOption-1 != 0) or currentOption-1 < 0)
	{
		if (page > 0) page--
		else page = 30-1
		currentOption += 3
	}
	else currentOption--
}
if (keyboard_check_pressed(ord(vk_left)))
{
	if (((currentOption-1) % 4 == 0 and currentOption-1 != 0) or currentOption-1 < 0)
	{
		if (page > 0) page--
		else page = 30-1
		currentOption += 3
	}
	else currentOption--
}
if (keyboard_check_pressed(ord("D")))
{
	if ((currentOption+1) % 4 == 0)
	{
		if (page < 30-1) page++
		else page = 0
		currentOption -= 3
	}
	else currentOption++
}
if (keyboard_check_pressed(ord(vk_right)))
{
	if ((currentOption+1) % 4 == 0)
	{
		if (page < 30-1) page++
		else page = 0
		currentOption -= 3
	}
	else currentOption++
}

if (keyboard_check_pressed(vk_enter))
{
	if (!summaryMode)
	{
		summaryMode = true
		pokemonNumber = 1+currentOption+pageAmount*page
	}
	else
	{
		summaryMode = false
		pokemonNumber = -1
	}
}

if ((currentOption+1)%4==0) //Right side arrow
{
	arrowDir = 1
	if (arrowAlpha < 1) arrowAlpha += 0.05
}
else if (((currentOption-1) % 4 == 0 and currentOption-1 != 0) or currentOption-1 < 0) //Left side arrow
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
