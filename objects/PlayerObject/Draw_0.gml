draw_self()
if (showNPCText != "" and !talking and canWalk) {
	if !(nearestNPC.object_index == PokelootObject and !nearestNPC.obtainable)
    {
		draw_sprite_ext(ArrowSelectSprite, 0, nearestNPC.x, nearestNPC.y-32+arrowOffset, 1.5, 1.5, image_angle, image_blend, image_alpha)
	}
}