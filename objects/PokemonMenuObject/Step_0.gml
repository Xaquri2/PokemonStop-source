if (keyboard_check_pressed(ord("E")) and canInteract) 
{
	if (summaryMode)
	{
		summaryMode = false
	}
	else
	{
		if (!switchMode)
		{
			menu.active = true
			instance_destroy(id)
		}
		else 
		{
			switchIndex = -1
			switchMode = false
		}
	}
}

if (keyboard_check_pressed(vk_enter) and canInteract)
{
	if (switchMode)
	{
		var temp = ds_list_find_value(global.playerParty, selectedIndex)
		ds_list_set(global.playerParty, selectedIndex, ds_list_find_value(global.playerParty, switchIndex))
		ds_list_set(global.playerParty, switchIndex, temp)
		
		switchMode = false
	}
	else
	{
		if (!summaryMode and !switchMode)
		{
			canInteract = false
			var options = instance_create_layer(x,y,layer,PokemonMenuOptionsObject)
			options.xOffset = view_get_wport(0)*0.14
			options.yOffset = view_get_hport(0)*(0.1+(0.14*selectedIndex))
			options.menu = id
			options.depth = depth-1
		
			var pkmnInfo = GetPartyMemberInfo(selectedIndex)
			ds_list_add(options.optionList, "Summary", "Switch")
			if (CanEvolve(selectedIndex)) ds_list_add(options.optionList, "Evolve")
		}
	}
}

if (!summaryMode and canInteract)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
}

if (selectedIndex == ds_list_size(global.playerParty)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(global.playerParty)-1