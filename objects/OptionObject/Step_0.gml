if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")))
{
	if (currentOption == 0) currentOption = 1
	else if (currentOption == 1) currentOption = 0
}

if (keyboard_check_pressed(vk_enter))
{
	//Add item consumption logic
}