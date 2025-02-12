draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.05, 
15, 25, image_angle, image_blend, image_alpha)

for (var i = 0; i < ds_list_size(global.playerParty); i++)
{
	var pkmnInfo = GetPartyMemberInfo(i)
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*(0.1+(0.13*i)), 
	12.5, 3, image_angle, c_grey, image_alpha)
	
	var sprite = ds_list_find_value(pkmnInfo, 4)
	draw_sprite_ext(sprite, 0, view_get_wport(0)*0.18, view_get_hport(0)*(0.15+(0.13*i)), 
	2, 2, image_angle, image_blend, image_alpha)
	
	var name = ds_list_find_value(pkmnInfo, 1)
	draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*(0.11+(0.13*i)), name, 2, 2, image_angle)
	
	var level = ds_list_find_value(pkmnInfo, 2)
	draw_text_transformed(view_get_wport(0)*0.24, view_get_hport(0)*(0.15+(0.13*i)), string_concat("Level: ", level), 2, 2, image_angle)

}