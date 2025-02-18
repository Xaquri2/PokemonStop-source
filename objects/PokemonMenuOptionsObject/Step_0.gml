if (keyboard_check_pressed(vk_enter)) 
{
	switch (selectedIndex)
	{
		case 0:
			menu.summaryMode = true
			break
		case 1:
			break
		case 2:
			break
	}
}

if (!summaryMode)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
}

if (selectedIndex == ds_list_size(optionList)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(optionList)-1