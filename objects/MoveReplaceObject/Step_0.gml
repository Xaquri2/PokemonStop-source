if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")))
{
	if (currentOption <= 0) currentOption = ds_list_size(moveList)-1
	else if (currentOption > ds_list_size(moveList)-1) currentOption = 0
}

if (keyboard_check_pressed(ord("E"))) 
{
	menu.optionMenu = noone
	menu.hasSelected = false
	instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter))
{

}