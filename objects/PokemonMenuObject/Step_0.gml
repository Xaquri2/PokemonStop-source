if (keyboard_check_pressed(ord("E"))) 
{
	if (summaryMode)
	{
		summaryMode = false
	}
	else
	{
		menu.active = true
		instance_destroy(id)
	}
}

if (keyboard_check_pressed(vk_enter)) summaryMode = true

if (!summaryMode)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
}

if (selectedIndex == ds_list_size(global.playerParty)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(global.playerParty)-1