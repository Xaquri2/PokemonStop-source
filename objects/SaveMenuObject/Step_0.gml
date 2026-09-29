if (keyboard_check_pressed(ord("E")) and active)
{
	instance_destroy()

	player.alarm[0] = 5
}

if (keyboard_check_pressed(vk_enter) and active)
{
	var fileName = string_concat("savefile", selectedIndex+1, ".json")
	var option = ds_list_find_value(optionsList, selectedIndex)
	if (option != "Exit") active = false
	
	global.saveFile = selectedIndex+1
	global.currentSaveState = selectedIndex+1
	
	if (mode == "Save")
	{
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
	}
	else if (mode == "Load")
	{
		switch (option)
		{
			case "1":
				if (file_exists(fileName))
				{
					SaveStateAction(1, mode)
					instance_destroy(id)
				}
				else active = false
				break
			case "2":
				fileName = string_concat("savefile", 2, ".json")
				if (file_exists(fileName))
				{
					SaveStateAction(2, mode)
					instance_destroy(id)
				}
				else active = false
				break
			case "3":
				fileName = string_concat("savefile", 3, ".json")
				if (file_exists(fileName))
				{
					SaveStateAction(3, mode)
					instance_destroy(id)
				}
				else active = false
				break
			case "4":
				fileName = string_concat("savefile", 4, ".json")
				if (file_exists(fileName))
				{
					SaveStateAction(4, mode)
					instance_destroy(id)
				}
				else active = false
				break
			case "5":
				fileName = string_concat("savefile", 5, ".json")
				if (file_exists(fileName))
				{
					SaveStateAction(5, mode)
					instance_destroy(id)
				}
				else active = false
				break
		}
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
