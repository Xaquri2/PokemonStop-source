if (global.torch)
{
	var color = c_orange;
	var steps = 120*global.torchPower;
	var currentRadius = 61;
	var alpha = 0

	for (var i = steps; i > 0; i--) {
	    alpha += 0.0002
	    color = merge_colour(color, c_yellow, 0.005);
    
	    draw_set_alpha(alpha); 
	    draw_circle_color(x, y, currentRadius, color, color, false);
	    currentRadius -= 0.5;
	}

	draw_set_alpha(1); // Reset
}

draw_self()
if (showNPCText != "" and !talking and canWalk) {
	if !(nearestNPC.object_index == PokelootObject and !nearestNPC.obtainable)
    {
		draw_sprite_ext(ArrowSelectSprite, 0, nearestNPC.x, nearestNPC.y-32+arrowOffset, 1.5, 1.5, image_angle, image_blend, image_alpha)
	}
}

//draw_set_color(c_white);
//draw_text(x + 32, y - 64,
//    "player layer id: " + string(layer) + "\n" +
//    "Gash layer id: " + string(layer_get_id("Gash"))
//);