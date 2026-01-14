draw_self()
if (showNPCText != "" and !talking and canWalk) {
	if !(nearestNPC.object_index == PokelootObject and !nearestNPC.obtainable)
    {
		draw_sprite_ext(ArrowSelectSprite, 0, nearestNPC.x, nearestNPC.y-32+arrowOffset, 1.5, 1.5, image_angle, image_blend, image_alpha)
	}
}

if (torch)
{
	var steps = 120;
	var currentRadius = 1
	for (var i = steps; i > 0; i--) {
	    var alpha = i / steps;
    
	    draw_set_alpha(alpha);
	    draw_circle_color(x, y, currentRadius, c_white, c_white, true);
		currentRadius += 0.5
	}
}