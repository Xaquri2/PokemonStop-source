draw_self()
var xOffset = 0
var yOffset = 0
for (var i = 0; i < displayCount; i++)
{
	xOffset += 8
	if (i == 3) 
	{
		yOffset += 8
		xOffset = 8
	}
	if (ds_list_size(global.playerParty) > i)
	{
		var pkmn = ds_list_find_value(global.playerParty, i)
		var pkmnSprite = GetSprite(pkmn)
		var sourceLeft = sprite_get_bbox_left(pkmnSprite)
		var sourceTop = sprite_get_bbox_top(pkmnSprite)
		var sourceWidth = max(1, sprite_get_bbox_right(pkmnSprite)-sourceLeft+1)
		var sourceHeight = max(1, sprite_get_bbox_bottom(pkmnSprite)-sourceTop+1)
		// Fit the visible Pokemon into each 8-pixel slot without stretching it.
		var pkmnScale = 7/max(sourceWidth, sourceHeight)
		var centerX = x-sprite_width*0.5+xOffset
		var centerY = y-sprite_height*0.2+yOffset
		draw_sprite_part_ext(pkmnSprite, 0, sourceLeft, sourceTop, sourceWidth, sourceHeight,
		centerX-sourceWidth*pkmnScale*0.5, centerY-sourceHeight*pkmnScale*0.5,
		pkmnScale, pkmnScale, image_blend, image_alpha)
	}
}
