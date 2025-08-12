if (keyboard_check_pressed(ord("E")) and optionMenu == noone) 
{
	if (!hasSelected)
	{
		if (battle)
		{
			menu.mode = "Choosing"
			menu.currentOption = 0
			instance_destroy(id)
		}
		else
		{
			alarm[0] = 1
		}
	}
	else hasSelected = false
}

if (keyboard_check_pressed(vk_enter) and !hasSelected)
{
	hasSelected = true
	optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
	optionMenu.menu = id
	optionMenu.question = "Would you like to buy this item?"
	optionMenu.option1 = "Buy"
	optionMenu.option2 = "Exit"
}

#region Item Controls
if (!hasSelected)
{
	var itemCount = ds_list_size(itemList)
	
	if (keyboard_check_pressed(ord("W"))) 
	{
		selectedItem--
		if (selectedItem >= 0 and selectedItem < startingItemOffset) startingItemOffset--
	}
	if (keyboard_check_pressed(ord("S"))) 
	{
		selectedItem++
		if (selectedItem < itemCount and selectedItem >= itemDisplayLimit+startingItemOffset
		and itemCount-startingItemOffset > itemDisplayLimit) startingItemOffset++
	}
	
	if (selectedItem == ds_list_size(itemList)) 
	{
		selectedItem = 0
		startingItemOffset = 0
	}
	if (selectedItem < 0) 
	{
		selectedItem = ds_list_size(itemList)-1
		startingItemOffset = itemCount-itemDisplayLimit
	}
}
#endregion