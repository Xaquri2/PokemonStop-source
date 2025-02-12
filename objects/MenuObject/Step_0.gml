if (keyboard_check_pressed(ord("E")) and player.menuOpen and active) 
{
	player.alarm[0] = 5
}

if (keyboard_check_pressed(vk_enter) and active)
{
	var option = ds_list_find_value(optionsList, selectedIndex)
	if (option != "Exit") active = false
	
	switch (option)
	{
		case "Pokemon":
			var pkmnMenu = instance_create_layer(x,y,layer,PokemonMenuObject)
			pkmnMenu.menu = id
			break
		case "Exit":
			player.alarm[0] = 5
			break
	}
}

if (active)
{
	if (keyboard_check_pressed(ord("W"))) selectedIndex--
	if (keyboard_check_pressed(ord("S"))) selectedIndex++
}
if (selectedIndex == ds_list_size(optionsList)) selectedIndex = 0
if (selectedIndex < 0) selectedIndex = ds_list_size(optionsList)-1