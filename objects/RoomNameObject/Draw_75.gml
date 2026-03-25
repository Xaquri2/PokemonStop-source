if (name != "")
{
	CenterTextPosition()
	draw_sprite_ext(sprite_index, image_index, xPos, yPos,
	6, 2, image_angle, image_blend, image_alpha)
	draw_text_transformed(xPos,yPos,name,1.5,1.5,image_angle)
	ResetTextPosition()
}
