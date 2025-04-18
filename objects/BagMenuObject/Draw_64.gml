draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.1, view_get_hport(0)*0.03, 25, 25, image_angle, image_blend, image_alpha)

var yOffset = 0.1
for (var i = 0; i < ds_list_size(global.categoryNameList); i++)
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

for (var i = 0; i < 15; i++)
{
	var itemName = ds_list_find_value(ds_list_find_value(global.categoryItemList, selectedCategory), i)
	var originX = view_get_wport(0)*0.15
	var originY = 80+view_get_hport(0)*0.075+40*i
	
	if (itemName != undefined) draw_text_transformed(originX,originY,itemName, 1.5, 1.5, image_angle)
}