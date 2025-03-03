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

if (currentOption < 0) currentOption += 4
if (currentOption > 3) currentOption -= 4