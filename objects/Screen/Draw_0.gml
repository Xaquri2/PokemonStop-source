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
		draw_sprite_ext(GetSprite(pkmn), 0, x-sprite_width*0.5+xOffset, 
		y-sprite_height*0.2+yOffset, 0.2, 0.2, image_angle, image_blend, image_alpha)
	}
}