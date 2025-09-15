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
		case "Pokedex":
			var dex = instance_create_layer(x,y,layer,PokedexObject)
			dex.menu = id
			visible = false
			break
		case "Pokemon":
			var pkmnMenu = instance_create_layer(x,y,layer,PokemonMenuObject)
			pkmnMenu.menu = id
			break
		case "Bag":
			var bag = instance_create_layer(x,y,layer,BagMenuObject)
			bag.menu = id
			visible = false
			break
		case "Save Game":
		    var saveMenu = instance_create_layer(x, y,layer, SaveMenuObject);
			saveMenu.mode = "Save"
			saveMenu.player = player
			saveMenu.parent_menu = id     // so the save menu can return here
			saveMenu.use_recent = true    // tells the menu to list recent saves
			saveMenu.recent_limit = 10    // how many recent saves to show
			instance_destroy(id)
			break
		case "Load Game":
		    var loadMenu = instance_create_layer(x, y,layer, SaveMenuObject);
			loadMenu.mode = "Load"
			loadMenu.player = player
			loadMenu.parent_menu = id     // so the save menu can return here
			loadMenu.use_recent = true    // tells the menu to list recent saves
			loadMenu.recent_limit = 10    // how many recent saves to show
			instance_destroy(id)
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