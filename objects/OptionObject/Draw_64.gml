draw_sprite_ext(MenuSprite, 0, 20, view_get_hport(0)*0.8, 16, 5, image_angle, image_blend, image_alpha)
draw_text_transformed(40, view_get_hport(0)*0.82, question, 1.5, 1.5, image_angle)

draw_text_transformed(40, view_get_hport(0)*0.86, option1, 1.5, 1.5, image_angle)
if (currentOption == 0) draw_sprite_ext(ArrowSelectSprite, 0, 40+string_width(option1)*1.5+20, 
view_get_hport(0)*0.86+20,	1.5, 1.5, 270, image_blend, image_alpha)

draw_text_transformed(40, view_get_hport(0)*0.9, option2, 1.5, 1.5, image_angle)
if (currentOption == 1) draw_sprite_ext(ArrowSelectSprite, 0, 40+string_width(option2)*1.5+20, 
view_get_hport(0)*0.9+20, 1.5, 1.5, 270, image_blend, image_alpha)