var boxSize = 4
if (ds_list_size(optionList) > 2) boxSize = 6
draw_sprite_ext(MenuSprite, 0, xOffset, yOffset, 6, boxSize, image_angle, image_blend, image_alpha)

var optionOffsetX = 24
var optionOffsetY = 50
for (var i = 0; i < ds_list_size(optionList); i++)
{
	draw_sprite_ext(MenuSprite, 0, xOffset+optionOffsetX-10, yOffset+20+optionOffsetY*i, 5, 1.5, image_angle, image_blend, image_alpha)

	var color = c_black
	if (selectedIndex == i) color = c_yellow
	draw_text_transformed_color(xOffset+optionOffsetX, yOffset+20+optionOffsetY*i,
	ds_list_find_value(optionList, i), 2, 2, image_angle, color, color, color, color, image_alpha)
	optionOffsetY += 0.06
}
