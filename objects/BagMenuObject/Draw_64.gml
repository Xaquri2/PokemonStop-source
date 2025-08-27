var xPos = view_get_wport(0)*0.1
var yPos = view_get_hport(0)*0.03
draw_sprite_ext(MenuSprite, 0, xPos, yPos, 25, 25, image_angle, image_blend, image_alpha)

var categoryList = ds_list_find_value(global.categoryItemList, selectedCategory)
if (!ds_list_empty(categoryList))
{
	//Item Description
	var itemInfo = ds_list_find_value(categoryList, selectedItem)
	var itemName = GetItemName(itemInfo)

	xPos += 40
	yPos = yPos+sprite_get_height(MenuSprite)*18
	draw_sprite_ext(MenuSprite, 0, xPos, yPos, 16, 5, image_angle, image_blend, image_alpha)
	draw_text_transformed(xPos+20, yPos+20, GetItemDescription(itemName), 1.5, 1.5, image_angle)

	//Item Icon
	xPos = xPos+40+sprite_get_width(MenuSprite)*16+16
	draw_sprite_ext(MenuSprite, 0, xPos, yPos, 5, 5, image_angle, image_blend, image_alpha)

	//Item List
	var yOffset = 0.1
	for (var i = 0; i < ds_list_size(global.categoryNameList); i++) //Drawing the categories
	{
		var text = ds_list_find_value(global.categoryNameList, i)
		var width = sprite_get_width(MenuSprite)
		var height = sprite_get_height(MenuSprite)
		var originX = view_get_wport(0)*(0.15+0.15*i)
		var originY = view_get_hport(0)*0.075
		draw_sprite_ext(MenuSprite, 0, originX, originY, 4, 2, image_angle, image_blend, image_alpha)
	
		draw_set_halign(fa_center)
		draw_set_valign(fa_middle)
		draw_text_transformed(originX+width*2,originY+height,text,1.5,1.5,image_angle)
		draw_set_halign(fa_left)
		draw_set_valign(fa_top)
	
		if (i == selectedCategory) 
		{
			draw_set_alpha(0.5)
			draw_rectangle(originX,originY,originX+width*4,originY+height*2,false)
			draw_set_alpha(1)
		}
	}

	var itemCount = ds_list_size(ds_list_find_value(global.categoryItemList, selectedCategory))

	var displayedItems = 0
	for (var i = startingItemOffset; i < clamp(startingItemOffset+itemDisplayLimit, 0, itemCount); i++) //Drawing the items
	{
		var itemDetails = ds_list_find_value(ds_list_find_value(global.categoryItemList, selectedCategory), i)
		var itemAmount = GetItemAmount(itemDetails)
		itemName = GetItemName(itemDetails)
		var originX = view_get_wport(0)*0.15
		var originY = 80+view_get_hport(0)*0.075+40*displayedItems
	
		if (itemName != undefined) draw_text_transformed(originX, originY, itemName, 1.5, 1.5, image_angle)
		draw_text_transformed(view_get_wport(0)*0.85, originY, string_concat("x", itemAmount), 1.5, 1.5, image_angle)
	
		if (selectedItem == i) draw_sprite_ext(ArrowSelectSprite, 0, originX+string_width(itemName)*1.5+20, originY+20,
		1.5, 1.5, 270, image_blend, image_alpha)
	
		displayedItems++
	}
}