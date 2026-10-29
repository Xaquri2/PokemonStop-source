if (keyboard_check_pressed(ord("W")))
{
	currentOption--
	if (currentOption <= 0) currentOption = ds_list_size(moveList)-1
}

if (keyboard_check_pressed(vk_up))
{
	currentOption--
	if (currentOption <= 0) currentOption = ds_list_size(moveList)-1
}

else if (keyboard_check_pressed(ord("S")))
{
	currentOption++
	if (currentOption >= ds_list_size(moveList)) currentOption = 0
}

else if (keyboard_check_pressed(vk_down))
{
	currentOption++
	if (currentOption >= ds_list_size(moveList)) currentOption = 0
}

if (keyboard_check_pressed(ord("E")))
{
	menu.inactive = false
	menu.visible = true
	instance_destroy(id)
	ds_list_insert(menu.textList, menu.currentText + 1, string_concat("Your Pokemon did not learn ", newMove, "."))
	ds_list_delete(menu.listLevelUpMoves, 0)
}

if (keyboard_check_pressed(vk_enter))
{
	var forgottenMove = ds_list_find_value(moveList, currentOption)

	menu.inactive = false
	menu.visible = true

	instance_destroy(id)
	ds_list_insert(menu.textList, menu.currentText + 1, string_concat("Your pokémon forgot ", forgottenMove, " to learn ", newMove, "!"))

	LearnMove(menu.playerPkmn, newMove, currentOption)
	ds_list_delete(menu.listLevelUpMoves, 0)
}
