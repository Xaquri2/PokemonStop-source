draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.05,
15, 25, image_angle, image_blend, image_alpha)

for (var i = 0; i < ds_list_size(moveList); i++)
{
	if (currentMove == i) draw_set_colour(c_yellow)
	
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.11, view_get_hport(0)*0.07+64*i,
	12.5, 2, image_angle, image_blend, image_alpha)
	draw_text_transformed(view_get_wport(0)*0.11+16, view_get_hport(0)*0.07+64*i+16,
	ds_list_find_value(moveList, i), 2.25, 2.25, image_angle)
	
	draw_set_colour(c_white)
}