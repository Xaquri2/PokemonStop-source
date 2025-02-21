draw_self()
if (showNPCText != "" and !talking) {
    draw_set_halign(fa_center); // Center-align the text horizontally
    draw_set_valign(fa_middle); // Middle-align the text vertically
    draw_text(nearestNPC.x+nearestNPC.sprite_width/2, nearestNPC.y-16, showNPCText); // Draw the text at the specified viewport coordinates
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}