var xPos = view_get_wport(0)*0.1
var yPos = view_get_hport(0)*0.03
draw_sprite_ext(MenuSprite, 0, xPos, yPos, 25, 25, image_angle, image_blend, image_alpha)
draw_text_transformed(xPos+20, yPos+20, "Choose which item you want to buy:", 2, 2, image_angle)

//Item Description
var itemName = ds_list_find_value(itemList, selectedItem)

xPos += 40
yPos = yPos+sprite_get_height(MenuSprite)*18
draw_sprite_ext(MenuSprite, 0, xPos, yPos, 16, 5, image_angle, image_blend, image_alpha)
draw_text_transformed(xPos+20, yPos+20, GetItemDescription(itemName), 1.5, 1.5, image_angle)

//Item Icon
xPos = xPos+40+sprite_get_width(MenuSprite)*16+16
draw_sprite_ext(MenuSprite, 0, xPos, yPos, 5, 5, image_angle, image_blend, image_alpha)

//Item List
var yOffset = 0.1
var itemCount = ds_list_size(itemList)

var displayedItems = 0
for (var i = startingItemOffset; i < clamp(startingItemOffset+itemDisplayLimit, 0, itemCount); i++) //Drawing the items
{
	itemName = ds_list_find_value(itemList, i)
	var originX = view_get_wport(0)*0.15
	var originY = 80+view_get_hport(0)*0.025+40*displayedItems
	
	if (itemName != undefined) draw_text_transformed(originX, originY, itemName, 1.5, 1.5, image_angle)
	draw_text_transformed(view_get_wport(0)*0.85, originY, string_concat("$", GetItemValue(itemName)), 1.5, 1.5, image_angle)
	
	if (selectedItem == i) draw_sprite_ext(ArrowSelectSprite, 0, originX+string_width(itemName)*1.5+20, originY+20,
	1.5, 1.5, 270, image_blend, image_alpha)
	
	displayedItems++
}