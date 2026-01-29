var scale = 5
scale += clamp(ds_list_size(optionList), 2, 100)-2

draw_sprite_ext(OptionBoxSprite, 0, 20, view_get_hport(0)*0.98, 16, scale, image_angle, image_blend, image_alpha)
draw_text_transformed(40, view_get_hport(0)*0.98-sprite_get_height(OptionBoxSprite)*scale+20, question, 1.5, 1.5, image_angle)

if (buying) draw_text_transformed(40+string_width(question)*1.5+40,
view_get_hport(0)*0.98-sprite_get_height(OptionBoxSprite)*scale+20, 
string_concat("(x", buyQuantity, ")"), 1.5, 1.5, image_angle)

for (var i = 0; i < ds_list_size(optionList); i++)
{
	draw_text_transformed(40, view_get_hport(0)*0.98-sprite_get_height(OptionBoxSprite)*scale+20+40*(i+1), 
	ds_list_find_value(optionList, i), 1.5, 1.5, image_angle)
	
	if (currentOption == i)
	{
		draw_sprite_ext(ArrowSelectSprite, 0, 40+string_width(ds_list_find_value(optionList, i))*1.5+20,
		view_get_hport(0)*0.98-sprite_get_height(OptionBoxSprite)*scale+32+40*(i+1), 1.5, 1.5, 270, image_blend, image_alpha)
	}
}

/*if (buying) draw_text_transformed(40+string_width(question)*1.5+40,
view_get_hport(0)*0.82, string_concat("(x", buyQuantity, ")"), 1.5, 1.5, image_angle)

if (instance_exists(referenceNPC) and referenceNPC.object_index == PokelootObject)
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