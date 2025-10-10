draw_sprite_ext(MenuSprite, 0, 20, view_get_hport(0)*0.75, 16, 10, image_angle, image_blend, image_alpha)
draw_text_transformed(40, view_get_hport(0)*0.775, "Which move to replace?", 1.5, 1.5, image_angle)

for (var i = 0; i < ds_list_size(moveList); i++)
{
	var moveName = ds_list_find_value(moveList, i)
	draw_text_transformed(40, view_get_hport(0)*(0.81+0.04*i), moveName, 1.5, 1.5, image_angle)
	
	if (currentOption == i) draw_sprite_ext(ArrowSelectSprite, 0, 40+string_width(moveName)*1.5+20, 
	view_get_hport(0)*(0.81+0.04*i)+20,	1.5, 1.5, 270, image_blend, image_alpha)
}