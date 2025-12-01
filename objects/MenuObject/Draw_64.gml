draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.7, view_get_hport(0)*0.05, 8, 25, image_angle, image_blend, image_alpha)

var yOffset = 0.1
for (var i = 0; i < ds_list_size(optionsList); i++)
{
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.72, view_get_hport(0)*0.1+56*i, 6, 1.5, image_angle, image_blend, image_alpha)

	var color = c_black
	if (selectedIndex == i) color = c_yellow
	draw_text_transformed_color(view_get_wport(0)*0.75, view_get_hport(0)*yOffset,
	ds_list_find_value(optionsList, i), 2, 2, image_angle, color, color, color, color, image_alpha)
	yOffset += 0.06
}
