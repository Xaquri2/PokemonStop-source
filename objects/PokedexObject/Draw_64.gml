draw_sprite_ext(MenuSprite, 0, view_get_wport(0)*0.08, view_get_hport(0)*0.08, 
25, 25, image_angle, image_blend, image_alpha)

var xOrigin = view_get_wport(0)*0.08
var yOrigin = view_get_hport(0)*0.08

var xOffset = 0
var yOffset = 0
var counter = 0
for (var i = 0; i < pageAmount; i++)
{	
	draw_sprite_ext(MenuSprite, 0, xOrigin+96+160*xOffset, yOrigin+64+160*yOffset, 4, 4, image_angle, image_blend, image_alpha)
	counter++
	xOffset++
	if (counter == lineAmount)
	{
		counter = 0
		xOffset = 0
		yOffset++
	}
}