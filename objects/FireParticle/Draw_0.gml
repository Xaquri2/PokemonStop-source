if (!drawInGUI)
{
	draw_set_alpha(image_alpha)
	draw_rectangle_colour(x-circleRadius*image_xscale,y-circleRadius*image_yscale,
	x+circleRadius*image_xscale,y+circleRadius*image_yscale,
	image_blend,image_blend,image_blend,image_blend,false)
	draw_set_alpha(1)
}