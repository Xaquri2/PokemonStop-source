draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.08,
25, 25, image_angle, image_blend, image_alpha)

CenterTextPosition()
draw_text_transformed(view_get_wport(0)*0.08+sprite_get_width(MenuSprite)*12.5,
view_get_hport(0)*0.08+40, string_concat("Page ", page), 2, 2, image_angle)
ResetTextPosition()

var xOrigin = view_get_wport(0)*0.08
var yOrigin = view_get_hport(0)*0.08

if (!summaryMode)
{
	var xOffset = 0
	var yOffset = 0
	var counter = 0
	for (var i = 0; i < pageAmount; i++) //Draw pokémon boxes
	{
		var pokedexIndex = i+pageAmount*page
		var name = GetNameByNumber(pokedexIndex+1)

		var frameScaledWidth = sprite_get_width(MenuSprite)*4
		var frameScaledHeight = sprite_get_height(MenuSprite)*4

		var frameXOffset = xOrigin+96+160*xOffset
		var frameYOffset = yOrigin+64+160*yOffset

		draw_sprite_ext(MenuSprite, 0, frameXOffset, frameYOffset, 4, 4, image_angle, image_blend, image_alpha)

		var finalPokedexIndex = string(pokedexIndex+1)
		if (pokedexIndex+1 < 100) finalPokedexIndex = string_concat("0", finalPokedexIndex)
		if (pokedexIndex+1 < 10) finalPokedexIndex = string_concat("0", finalPokedexIndex)

		CenterTextPosition()
		draw_text_transformed(frameXOffset+sprite_get_width(MenuSprite)*4/2, 
		frameYOffset+sprite_get_height(MenuSprite)*4+20, finalPokedexIndex, 2, 2, image_angle)
		ResetTextPosition()
		
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

		draw_set_alpha(0.5)
		if (currentOption == i) draw_rectangle(frameXOffset, frameYOffset,
		frameXOffset+frameScaledWidth, frameYOffset+frameScaledHeight, false)
		draw_set_alpha(1)

		counter++
		xOffset++
		if (counter == lineAmount)
		{
			counter = 0
			xOffset = 0
			yOffset++
		}
	}

	if (arrowAlpha != 0) //Draw side arrows
	{
		var angle = -90
		var arrowX = xOrigin+64
		if (arrowDir > 0)
		{
			angle = 90
			arrowX += sprite_get_width(MenuSprite)*25-128
		}

		var arrowY = yOrigin+sprite_get_height(MenuSprite)*25/2

		draw_sprite_ext(ArrowSelectSprite, 0, arrowX, arrowY, 8, 4, angle, image_blend, arrowAlpha)
	}

	CenterTextPosition()
	draw_text_transformed(xOrigin+sprite_get_width(MenuSprite)*25/2,
	yOrigin+sprite_get_height(MenuSprite)*25-64, "Pokedex", 4, 4, image_angle)
	ResetTextPosition()
}
else
{
	#region Draw Pokémon Icon
	draw_sprite_ext(MenuSprite, 0, xOrigin+64, yOrigin+64, 4, 4, image_angle, image_blend, image_alpha)
	var pkmnSprite = GetSpriteByNumber(pokemonNumber)

	var spriteWidth = -1
	var spriteHeight = -1
	if (pkmnSprite != undefined)
	{
		spriteWidth = sprite_get_width(pkmnSprite)
		spriteHeight = sprite_get_height(pkmnSprite)
	}

	if (pkmnSprite != undefined) draw_sprite_part_ext(pkmnSprite, 0,
	spriteWidth/2-16, spriteHeight/2-16, 32, 32,
	xOrigin+64, yOrigin+64, 4, 4, image_blend, image_alpha)
	#endregion

	#region Draw Pokémon Number, Name, Title and Description
	var name = GetNameByNumber(pokemonNumber)
	var title = GetTitleByNumber(pokemonNumber)

	draw_sprite_ext(MenuSprite, 0, xOrigin+240, yOrigin+64,
	12, 4, image_angle, c_grey, image_alpha)
	if (name != "") draw_text_transformed(xOrigin+260, yOrigin+80, name, 1.5, 1.5, image_angle)
	draw_text_transformed(xOrigin+260+string_width(name)*1.5+20, yOrigin+80, GetNumberFormat(pokemonNumber), 1.5, 1.5, image_angle)

	if (title != "") draw_text_transformed(xOrigin+260, yOrigin+110, title, 1.5, 1.5, image_angle)

	var types = GetPokemonType(name)
	for (var i = 0; i < ds_list_size(types); i++)
	{
		var type = ds_list_find_value(types, i)
		if (i > 0) type = string_concat("/", type)

		var offset = string_width(type)
		draw_text_transformed(xOrigin+260+(offset*1.5+20)*i,yOrigin+140,type,1.5,1.5,image_angle)
	}

	draw_sprite_ext(MenuSprite, 0, xOrigin+44, yOrigin+220,
	20, 4.5, image_angle, c_grey, image_alpha)
	draw_text_ext_transformed(xOrigin+64, yOrigin+230, GetDescriptionByNumber(pokemonNumber),
	20, 480, 1.2, 1.2, image_angle)
	#endregion

	#region Draw Stat Bars and Game of Origin
	draw_sprite_ext(MenuSprite, 0, xOrigin+44, yOrigin+220+160,
	20, 12, image_angle, c_grey, image_alpha)

	var statList = GetPokemonBaseStats(name)
	for (var i = 0; i < ds_list_size(statList); i++)
	{
		var stat = ds_list_find_value(statList, i)
		var percentage = stat/150*100
		var text = string_concat(GetStatByIndex(i), ": ", stat)

		draw_text_transformed(xOrigin+64, yOrigin+240+160+40*i,
		text, 1.5, 1.5, image_angle)

		draw_sprite_ext(BarSprite, 0, xOrigin+400, yOrigin+240+160+40*i,
		12.5*(percentage/100), 1.2, image_angle, image_blend, image_alpha)
	}

	draw_sprite_ext(MenuSprite, 0, xOrigin+64, yOrigin+650, 16, 3, image_angle, image_blend, image_alpha)
	draw_text_transformed(xOrigin+80, yOrigin+665, string_concat(GetGameOfOrigin(name)), 1.5, 1.5, image_angle)
	draw_text_transformed(xOrigin+80, yOrigin+695, string_concat(GetGameDetails(name)), 1.5, 1.5, image_angle)
	#endregion
}
