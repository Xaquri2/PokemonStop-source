draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.1, view_get_hport(0)*0.03, 25, 25, image_angle, image_blend, image_alpha)

var yOffset = 0.1
var itemCount = ds_list_size(itemList)

var displayedItems = 0
for (var i = startingItemOffset; i < clamp(startingItemOffset+itemDisplayLimit, 0, itemCount); i++) //Drawing the items
{
	var itemName = ds_list_find_value(itemList, i)
	var originX = view_get_wport(0)*0.15
	var originY = 80+view_get_hport(0)*0.025+40*displayedItems
	
	if (itemName != undefined) draw_text_transformed(originX, originY, itemName, 1.5, 1.5, image_angle)
	draw_text_transformed(view_get_wport(0)*0.85, originY, string_concat("$", GetItemValue(itemName)), 1.5, 1.5, image_angle)
	
	if (selectedItem == i) draw_sprite_ext(ArrowSelectSprite, 0, originX+string_width(itemName)*1.5+20, originY+20,
	1.5, 1.5, 270, image_blend, image_alpha)
	
	displayedItems++
}