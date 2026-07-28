draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.4, view_get_hport(0)*0.07, 9, 25, image_angle, image_blend, image_alpha)

var yOffset = 0.1
for (var i = 0; i < ds_list_size(optionsList); i++)
{
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.42, view_get_hport(0)*0.1+56*i, 8, 1.5, image_angle, image_blend, image_alpha)
	

	var color = c_black
	if (selectedIndex == i) color = c_yellow
	draw_text_transformed_color(view_get_wport(0)*0.45, view_get_hport(0)*yOffset+10,
	ds_list_find_value(optionsList, i), 2, 2, image_angle, color, color, color, color, image_alpha)
	yOffset += 0.06
	
	if (i == 0 && selectedIndex == 0)
		{
			draw_set_colour(c_black)
		    draw_text_ext(
		        view_get_wport(0) * 0.6, //X
		        view_get_hport(0) * 0.1 + 16, //Y
		        string_concat(audio_get_master_gain(0)*100, "%"),
		        -1,
		        -1
		    );
			draw_set_colour(c_white);
		}
}
