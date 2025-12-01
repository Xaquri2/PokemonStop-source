if (keyboard_check_pressed(ord("E")))
{
	menu.canInteract = true
	instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter))
{
	switch (selectedIndex)
	{
		case 0:
			menu.summaryMode = true
			menu.canInteract = true
			instance_destroy(id)
			break
		case 1:
		    menu.switchIndex = menu.selectedIndex
			menu.switchMode = true
			menu.canInteract = true
			instance_destroy(id)
			break
		case 2:
			break
	}
}

if (keyboard_check_pressed(ord("W"))) selectedIndex--
if (keyboard_check_pressed(ord("S"))) selectedIndex++

if (keyboard_check_pressed(ord(vk_up))) selectedIndex--
if (keyboard_check_pressed(ord(vk_down))) selectedIndex++

if (selectedIndex == ds_list_size(optionList)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(optionList)-1
