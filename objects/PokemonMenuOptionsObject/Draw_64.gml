var boxSize = 3
if (ds_list_size(optionList) > 2) boxSize = 4
draw_sprite_ext(MenuSprite, 0, xOffset, yOffset, 5, boxSize, image_angle, image_blend, image_alpha)

var optionOffsetX = 10
var optionOffsetY = 36
for (var i = 0; i < ds_list_size(optionList); i++)
{
	var color = c_black
	if (selectedIndex == i) color = c_yellow
	draw_text_transformed_color(xOffset+optionOffsetX, yOffset+10+optionOffsetY*i, 
	ds_list_find_value(optionList, i), 2, 2, image_angle, color, color, color, color, image_alpha)
	optionOffsetY += 0.06
}