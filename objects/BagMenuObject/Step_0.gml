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
	optionMenu.question = "Would you like to use this item?"
	optionMenu.option1 = "Use"
	optionMenu.option2 = "Exit"
}

#region Category Controls
if (!hasSelected)
{
	if (keyboard_check_pressed(ord("A"))) selectedCategory--
	if (keyboard_check_pressed(ord("D"))) selectedCategory++
	
	if (selectedCategory == ds_list_size(global.categoryNameList)) selectedCategory = 0
	if (selectedCategory < 0) selectedCategory = ds_list_size(global.categoryNameList)-1
}
#endregion

#region Item Controls
if (!hasSelected)
{
	var itemList = ds_list_find_value(global.categoryItemList, selectedCategory)
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