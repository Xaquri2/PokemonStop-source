if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")))
{
	if (currentOption == 0) currentOption = 1
	else if (currentOption == 1) currentOption = 0
}

if (keyboard_check_pressed(vk_enter))
{
	var itemIndex = menu.selectedItem
	var item = ds_list_find_value(global.categoryItemList, itemIndex)
	var itemName = GetItemName(item)
	
	switch (itemName)
	{
		case "Potion":
			var pkmnMenu = instance_create_depth(x,y,depth-1,PokemonMenuObject)
			pkmnMenu.itemUse = true
			pkmnMenu.itemName = itemName
			
			instance_destroy(menu.id)
			instance_destroy(id)
			break
	}
}