if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")))
{
	if (currentOption <= 0) currentOption = ds_list_size(moveList)-1
	else if (currentOption > ds_list_size(moveList)-1) currentOption = 0
}

if (keyboard_check_pressed(ord("E"))) 
{
	menu.inactive = false
	menu.visible = true
	instance_destroy(id)
	ds_list_insert(menu.textList, menu.currentText, "Do you want to stop learning a new move?")
}

if (keyboard_check_pressed(vk_enter))
{
	var forgottenMove = ds_list_find_value(moveList, currentOption)
	
	menu.inactive = false
	menu.visible = true
	
	instance_destroy(id)
	ds_list_insert(menu.textList, menu.currentText, string_concat("Your pokémon forgot ", forgottenMove, " to learn ", newMove, "!"))
	//Learn the new move, across ALL references of that specific pokémon, in global lists and local lists
}