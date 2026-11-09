if (global.torch and global.torchPower > 0)
{
	var color = c_orange;
	var steps = 120*global.torchPower;
	var currentRadius = global.torchRange;
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
if (showNPCText != "" and !talking and canWalk and instance_exists(nearestNPC)) {
	if !(instance_exists(nearestNPC) and nearestNPC.object_index == PokelootObject and !nearestNPC.obtainable)
    {
		var hintX = nearestNPC.x
		var hintY = nearestNPC.y - 32 + arrowOffset
		var hintAngle = 0
		var hintCamera = view_camera[view_current]
		if (hintCamera != -1)
		{
			var hintLeft = camera_get_view_x(hintCamera)
			var hintTop = camera_get_view_y(hintCamera)
			var hintRight = hintLeft + camera_get_view_width(hintCamera)
			var hintBottom = hintTop + camera_get_view_height(hintCamera)
			var hintHalfWidth = sprite_get_width(ArrowSelectSprite) * 0.75
			var hintHalfHeight = sprite_get_height(ArrowSelectSprite) * 0.75

			// Use the resting position so bobbing cannot flip the arrow between sides.
			if (nearestNPC.y - 32 < hintTop)
			{
				var hintRoomLeft = nearestNPC.x - hintLeft
				var hintRoomRight = hintRight - nearestNPC.x
				var hintSide = (hintRoomRight >= hintRoomLeft) ? 1 : -1
				hintX = nearestNPC.x + hintSide * (32 - arrowOffset)
				hintY = nearestNPC.y - 12
				hintAngle = (hintSide == 1) ? 270 : 90
				// Rotation swaps the sprite's horizontal and vertical extents.
				var hintSwap = hintHalfWidth
				hintHalfWidth = hintHalfHeight
				hintHalfHeight = hintSwap
			}

			// Keep the entire arrow inside the camera, with a small margin.
			hintX = clamp(hintX, hintLeft + hintHalfWidth + 2, hintRight - hintHalfWidth - 2)
			hintY = clamp(hintY, hintTop + hintHalfHeight + 2, hintBottom - hintHalfHeight - 2)
		}
		draw_sprite_ext(ArrowSelectSprite, 0, hintX, hintY, 1.5, 1.5, hintAngle, image_blend, image_alpha)
	}
}

//draw_set_color(c_white);
//draw_text(x + 32, y - 64,
//    "player layer id: " + string(layer) + "\n" +
//    "Gash layer id: " + string(layer_get_id("Gash"))
//);
