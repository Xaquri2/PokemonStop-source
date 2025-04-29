if (keyboard_check_pressed(ord("W")) or keyboard_check_pressed(ord("S")))
{
	if (currentOption == 0) currentOption = 1
	else if (currentOption == 1) currentOption = 0
}

if (keyboard_check_pressed(ord("E"))) 
{
	menu.optionMenu = noone
	menu.hasSelected = false
	instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter))
{
	var itemInfo = GetItemInfo(menu.selectedCategory, menu.selectedItem)
	var itemName = GetItemName(itemInfo)

	if (IsConsumableItem(itemName))
	{
		if (currentOption == 0)
			{
				ConsumeItem(menu.selectedCategory, menu.selectedItem, 1)
				
				var pkmnMenu = instance_create_depth(x,y,depth-1,PokemonMenuObject)
				pkmnMenu.itemUse = true
				pkmnMenu.itemName = itemName
				pkmnMenu.bagMenu = menu
				
				menu.optionMenu = noone
				instance_destroy(id)
			}
	}
}