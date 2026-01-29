if (keyboard_check_pressed(ord("E")) and !instance_exists(optionMenu))
{
	if (instance_exists(optionMenu)) instance_destroy(optionMenu)
	else instance_destroy(id)
}

if (keyboard_check_pressed(vk_enter) and !instance_exists(optionMenu)
and GetItemValue(ds_list_find_value(itemList, selectedItem)) <= global.money)
{
	optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
	optionMenu.menu = id
	optionMenu.question = "Would you like to buy this item?"
	ds_list_add(optionMenu.optionList, "Buy")
	ds_list_add(optionMenu.optionList, "Exit")
	optionMenu.buying = true
}

#region Item Controls
if (!instance_exists(optionMenu))
{
	var itemCount = ds_list_size(itemList)

	if (keyboard_check_pressed(ord("W")))
	{
		selectedItem--
		if (selectedItem >= 0 and selectedItem < startingItemOffset) startingItemOffset--
	}
	if (keyboard_check_pressed(vk_up))
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
	if (keyboard_check_pressed(vk_down))
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
