draw_sprite_ext(MenuSprite, 0, 20, view_get_hport(0)*0.8, 16, 5, image_angle, image_blend, image_alpha)
draw_text_transformed(40, view_get_hport(0)*0.82, question, 1.5, 1.5, image_angle)

if (buying) draw_text_transformed(40+string_width(question)*1.5+40,
view_get_hport(0)*0.82, string_concat("(x", buyQuantity, ")"), 1.5, 1.5, image_angle)

draw_text_transformed(40, view_get_hport(0)*0.86, option1, 1.5, 1.5, image_angle)
if (currentOption == 0) draw_sprite_ext(ArrowSelectSprite, 0, 40+string_width(option1)*1.5+20,
view_get_hport(0)*0.86+20,	1.5, 1.5, 270, image_blend, image_alpha)

draw_text_transformed(40, view_get_hport(0)*0.9, option2, 1.5, 1.5, image_angle)
if (currentOption == 1) draw_sprite_ext(ArrowSelectSprite, 0, 40+string_width(option2)*1.5+20,
view_get_hport(0)*0.9+20, 1.5, 1.5, 270, image_blend, image_alpha)

if (referenceNPC.object_index == PokelootObject)
{
	if (instance_exists(referenceNPC) and GetNumberByName(referenceNPC.item) != -1)//Draw Pokémon Icon
	{
		var pkmnSprite = GetSpriteByNumber(GetNumberByName(referenceNPC.item))
		var spriteWidth = sprite_get_width(pkmnSprite)
		var spriteHeight = sprite_get_height(pkmnSprite)

		if (pkmnSprite != undefined)
		{
			draw_sprite_ext(MenuSprite, 0, window_get_width()/2-spriteWidth/2-20,
			window_get_height()/2-spriteHeight/2-20, 5, 5, image_angle, image_blend, image_alpha)
			draw_sprite_part_ext(pkmnSprite, 0, spriteWidth/2-16, spriteHeight/2-16, 32, 32,
			window_get_width()/2-spriteWidth/2, window_get_height()/2-spriteHeight/2, 4, 4, image_blend, image_alpha)
		}
	}
}