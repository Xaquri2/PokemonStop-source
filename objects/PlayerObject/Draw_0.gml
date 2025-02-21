draw_self()
if (showNPCText != "" and !talking) {
    draw_sprite_ext(ArrowSelectSprite, 0, nearestNPC.x, nearestNPC.y-32+arrowOffset, 1.5, 1.5, image_angle, image_blend, image_alpha)
}