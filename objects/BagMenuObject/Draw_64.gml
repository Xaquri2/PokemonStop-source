draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.1, view_get_hport(0)*0.03, 25, 25, image_angle, image_blend, image_alpha)

var yOffset = 0.1
for (var i = 0; i < ds_list_size(global.categoryNameList); i++)
{
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*(0.15+0.15*i), view_get_hport(0)*0.075, 4, 2, image_angle, image_blend, image_alpha)
	if (i == selectedCategory) 
	{
		draw_set_alpha(0.5)
		draw_rectangle(view_get_wport(0)*(0.15+0.15*i), 
		view_get_hport(0)*0.075,
		view_get_wport(0)*(0.15+0.15*i)+sprite_get_width(MenuSprite)*4, 
		view_get_hport(0)*0.075+sprite_get_height(MenuSprite)*2,
		false)
		draw_set_alpha(1)
	}
}