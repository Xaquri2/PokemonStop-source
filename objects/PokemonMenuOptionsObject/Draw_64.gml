draw_sprite_ext(MenuSprite, 0, xOffset, yOffset, 5, 10, image_angle, image_blend, image_alpha)

var optionOffsetX = 0.1
var optionOffsetY = 0.1
for (var i = 0; i < ds_list_size(optionsList); i++)
{
	var color = c_black
	if (selectedIndex == i) color = c_yellow
	draw_text_transformed_color(xOffset+optionOffsetX, yOffset+optionOffsetY, 
	ds_list_find_value(optionsList, i), 2, 2, image_angle, color, color, color, color, image_alpha)
	optionOffsetY += 0.06
}