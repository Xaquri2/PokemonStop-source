// Return to the main menu
if (keyboard_check_pressed(ord("E")))
{
	if (instance_exists(menu))
	{
		menu.active = true
		menu.visible = true
	}

	instance_destroy()
	exit
}


// Move through the options
if (canInteract)
{
	if (keyboard_check_pressed(ord("W")) ||
		keyboard_check_pressed(vk_up))
	{
		selectedIndex--
	}

	if (keyboard_check_pressed(ord("S")) ||
		keyboard_check_pressed(vk_down))
	{
		selectedIndex++
	}
}


// Wrap selection
var optionCount = ds_list_size(optionsList)

if (selectedIndex >= optionCount)
{
	selectedIndex = 0
}

if (selectedIndex < 0)
{
	selectedIndex = optionCount - 1
}


// Select an option
if (keyboard_check_pressed(vk_enter) && canInteract)
{
	var option = ds_list_find_value(optionsList, selectedIndex)

	switch (option)
	{

		case "Volume":
			if (audio_get_master_gain(0) == 1) {
				audio_set_master_gain(0,0.2)
			}
			else if (audio_get_master_gain(0) == 0.2) {
				audio_set_master_gain(0,0.4)
			}
			else if (audio_get_master_gain(0) == 0.4) {
				audio_set_master_gain(0,0.6)
			}
			else if (audio_get_master_gain(0) == 0.6) {
				audio_set_master_gain(0,0.8)
			}
			else if (audio_get_master_gain(0) == 0.8) {
				audio_set_master_gain(0,1)
			}
			break

		case "Fullscreen":
			window_set_fullscreen(!window_get_fullscreen())
			break

		case "Exit":
			if (instance_exists(menu))
			{
				menu.active = true
				//menu.visible = true
			}

			instance_destroy()
			break
	}
}