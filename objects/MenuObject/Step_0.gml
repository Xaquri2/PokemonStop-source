if (keyboard_check_pressed(ord("E")) and player.menuOpen) 
{
	player.alarm[0] = 5
}

if (keyboard_check_pressed(vk_enter))
{
	var option = ds_list_find_value(optionsList, selectedIndex)
	switch (option)
	{
		case "Exit":
			player.alarm[0] = 5
			break
	}
}

if (keyboard_check_pressed(ord("W"))) selectedIndex--
if (keyboard_check_pressed(ord("S"))) selectedIndex++

if (selectedIndex == ds_list_size(optionsList)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(optionsList)-1