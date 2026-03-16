var xPos = view_get_wport(0)*0.1
var yPos = view_get_hport(0)*0.03
draw_sprite_ext(MenuSprite, 0, xPos, yPos, 25, 25, image_angle, image_blend, image_alpha)

var categoryList = ds_list_find_value(global.categoryItemList, selectedCategory)
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

if (!ds_list_empty(categoryList))
{
	//Item Description
	var itemInfo = ds_list_find_value(categoryList, selectedItem)
	var itemName = GetItemName(itemInfo)

	xPos += 40
	yPos = yPos+sprite_get_height(MenuSprite)*18
	draw_sprite_ext(MenuSprite, 0, xPos, yPos, 16, 5, image_angle, image_blend, image_alpha)
	draw_text_ext_transformed(xPos+20, yPos+20, GetItemDescription(itemName), 
	24, 100, 1.5, 1.5, image_angle)

	//Item Icon
	xPos = xPos+40+sprite_get_width(MenuSprite)*16+16
	draw_sprite_ext(MenuSprite, 0, xPos, yPos, 5, 5, image_angle, image_blend, image_alpha)

	//Item List
	var itemCount = ds_list_size(ds_list_find_value(global.categoryItemList, selectedCategory))
	
	if (ds_list_find_value(global.categoryNameList, selectedCategory) != "Key Items")
	{
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
	else
	{
		var displayedItems = 0
		for (var i = startingItemOffset; i < clamp(startingItemOffset+5, 0, itemCount); i++) //Drawing the items
		{
			var itemDetails = ds_list_find_value(ds_list_find_value(global.categoryItemList, selectedCategory), i)
			var itemAmount = GetItemAmount(itemDetails)
			itemName = GetItemName(itemDetails)
			var originX = view_get_wport(0)*0.15
			var originY = 240+80+view_get_hport(0)*0.075+40*displayedItems
			
			if (itemName != undefined) draw_text_transformed(originX, originY, itemName, 1.5, 1.5, image_angle)
			draw_text_transformed(view_get_wport(0)*0.85, originY, string_concat("x", itemAmount), 1.5, 1.5, image_angle)

			if (selectedItem == i) draw_sprite_ext(ArrowSelectSprite, 0, originX+string_width(itemName)*1.5+20, originY+20,
			1.5, 1.5, 270, image_blend, image_alpha)

			displayedItems++
		}
	}
}

if (ds_list_find_value(global.categoryNameList, selectedCategory) == "Key Items")
{
	CenterTextPosition()
	draw_text_transformed(view_get_wport(0)*0.5, 120+view_get_hport(0)*0.075, "Badges", 2, 2, image_angle)
	draw_text_transformed(view_get_wport(0)*0.5, 240+80+view_get_hport(0)*0.075-32, "Other Key Items", 2, 2, image_angle)
	ResetTextPosition()
	
	if (HasFlag("MutantBadge")) 
	{
		var originX = view_get_wport(0)*0.3
		var originY = 160+view_get_hport(0)*0.075+40
		draw_sprite_ext(MutantBadgeSprite, 0, originX, originY, 1, 1, image_angle, image_blend, image_alpha)
	}
	if (HasFlag("RobotBadge"))
	{
		var originX = view_get_wport(0)*0.5
		var originY = 160+view_get_hport(0)*0.075+40
		draw_sprite_ext(RobotBadgeSprite, 0, originX, originY, 0.08, 0.08, image_angle, image_blend, image_alpha)
	}
	if (HasFlag("ShadowBadge"))
	{
		var originX = view_get_wport(0)*0.7
		var originY = 160+view_get_hport(0)*0.075+40
		draw_sprite_ext(ShadowBadgeSprite, 0, originX, originY, 0.1, 0.1, image_angle, image_blend, image_alpha)
	}
}