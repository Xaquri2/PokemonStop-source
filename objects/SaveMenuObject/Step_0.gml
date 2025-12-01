if (keyboard_check_pressed(ord("E")) and active)
{
	instance_destroy()

	player.alarm[0] = 5
}

if (keyboard_check_pressed(vk_enter) and active)
{
	var option = ds_list_find_value(optionsList, selectedIndex)
	if (option != "Exit") active = false

	switch (option)
	{
		case "1":
			SaveStateAction(1, mode)
			instance_destroy(id)
			break
		case "2":
			SaveStateAction(2, mode)
			instance_destroy(id)
			break
		case "3":
			SaveStateAction(3, mode)
			instance_destroy(id)
			break
		case "4":
			SaveStateAction(4, mode)
			instance_destroy(id)
			break
		case "5":
			SaveStateAction(5, mode)
			instance_destroy(id)
			break
	}

	player.alarm[0] = 5
}

if (active)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
	if (keyboard_check_pressed(vk_up)) selectedIndex--
	if (keyboard_check_pressed(vk_down)) selectedIndex++
}
if (selectedIndex == ds_list_size(optionsList)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(optionsList)-1
