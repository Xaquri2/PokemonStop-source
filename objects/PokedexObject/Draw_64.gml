draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.08, 
25, 25, image_angle, image_blend, image_alpha)

var xOrigin = view_get_wport(0)*0.08
var yOrigin = view_get_hport(0)*0.08

var xOffset = 0
var yOffset = 0
var counter = 0
for (var i = 0; i < pageAmount; i++)
{	
	var pokedexIndex = i+16*page
	var name = GetNameByNumber(pokedexIndex+1)

	var frameScaledWidth = sprite_get_width(MenuSprite)*4
	var frameScaledHeight = sprite_get_height(MenuSprite)*4
	
	var frameXOffset = xOrigin+96+160*xOffset
	var frameYOffset = yOrigin+64+160*yOffset
	
	draw_sprite_ext(MenuSprite, 0, frameXOffset, frameYOffset, 4, 4, image_angle, image_blend, image_alpha)
	
	if (ds_list_find_index(global.pokedex, name) >= 0) //Draw Pokémon Icon
	{
		var pkmnSprite = GetSpriteByNumber(pokedexIndex+1)
	
		var spriteWidth = -1
		var spriteHeight = -1
		if (pkmnSprite != undefined)
		{
			spriteWidth = sprite_get_width(pkmnSprite)
			spriteHeight = sprite_get_height(pkmnSprite)
		}
	
		if (pkmnSprite != undefined) draw_sprite_part_ext(pkmnSprite, 0, 
		spriteWidth/2-16, spriteHeight/2-16, 32, 32,
		frameXOffset, frameYOffset, 4, 4, image_blend, image_alpha)
	}
	
	counter++
	xOffset++
	if (counter == lineAmount)
	{
		counter = 0
		xOffset = 0
		yOffset++
	}
}