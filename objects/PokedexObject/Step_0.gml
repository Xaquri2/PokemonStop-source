if (keyboard_check_pressed(ord("W"))) currentOption -= 4
if (keyboard_check_pressed(ord("S"))) currentOption += 4
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

if ((currentOption+1)%4==0)
{
	arrowDir = 1
	if (arrowAlpha < 1) arrowAlpha += 0.05
}
else if (((currentOption-1) % 4 == 0 and currentOption-1 != 0) or currentOption-1 < 0)
{
	arrowDir = -1
	if (arrowAlpha < 1) arrowAlpha += 0.05
}
else { if (arrowAlpha > 0) arrowAlpha -= 0.05 }