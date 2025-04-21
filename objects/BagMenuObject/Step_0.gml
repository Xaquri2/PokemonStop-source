if (keyboard_check_pressed(ord("E"))) 
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

if (keyboard_check_pressed(vk_enter))
{
	//Use item
}

#region Category Controls
if (keyboard_check_pressed(ord("A"))) selectedCategory--
if (keyboard_check_pressed(ord("D"))) selectedCategory++
	
if (selectedCategory == ds_list_size(global.categoryNameList)) selectedCategory = 0
if (selectedCategory < 0) selectedCategory = ds_list_size(global.categoryNameList)-1
#endregion

#region Item Controls
var itemList = ds_list_find_value(global.categoryItemList, selectedCategory)

if (keyboard_check_pressed(ord("A"))) selectedItem--
if (keyboard_check_pressed(ord("D"))) selectedItem++
	
if (selectedItem == ds_list_size(itemList)) selectedItem = 0
if (selectedItem < 0) selectedItem = ds_list_size(itemList)-1
#endregion