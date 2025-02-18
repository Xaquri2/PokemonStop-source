if (keyboard_check_pressed(ord("E")) and canInteract) 
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

if (keyboard_check_pressed(vk_enter))
{
	canInteract = false
	//create the instance
	//set instance menu variable to this' menu variable's value
	//check if the pokémon can evolve, if so add 'Evolve' to the option list in the 3rd position (index 2)
}

if (!summaryMode and canInteract)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
}

if (selectedIndex == ds_list_size(global.playerParty)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(global.playerParty)-1