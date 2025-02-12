draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.05, 
15, 25, image_angle, image_blend, image_alpha)

for (var i = 0; i < global.partySize; i++)
{
	draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.12, view_get_hport(0)*(0.1+(0.13*i)), 
	12.5, 3, image_angle, c_grey, image_alpha)
}