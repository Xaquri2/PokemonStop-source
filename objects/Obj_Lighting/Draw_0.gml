//surface_set_target(light_surface); 
//
//draw_clear_alpha(c_black,1);
//gpu_set_blendmode(bm_add); 
//draw_sprite_ext(TorchLightShaderTest, 0, PlayerObject.x, PlayerObject.y, 1, 1,0, c_white, 1)


// recreate surface if needed
if (!surface_exists(light_surface)) {
    var cam = view_camera[0];
    var w = camera_get_view_width(cam);
    var h = camera_get_view_height(cam);
    light_surface = surface_create(w, h);
}

// get camera position
var cam = view_camera[0];
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);

// draw onto surface
surface_set_target(light_surface);


if (!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))) {
	// FULL DARKNESS
	draw_clear_alpha(c_black, 0.95);

	var flicker = .8 + random_range(-0.05, 0.05);

	// cut out light
	if (global.torch) {
	    gpu_set_blendmode(bm_subtract);

	    draw_sprite_ext(
	        TorchLightShaderTest,
	        0,
	        PlayerObject.x - cam_x,
	        PlayerObject.y - cam_y,
	        flicker,
	        flicker,
	        0,
	        c_white,
	        1
	    );
	}

	with (Torch) {
	    gpu_set_blendmode(bm_subtract);

	    draw_sprite_ext(
	        TorchLightShaderTest,
	        0,
	        x - cam_x,
	        y - cam_y,
	        flicker - 0.3,
	        flicker - 0.3,
	        0,
	        c_gray,
	        1
	    );
	}

	with (Light) {
	    gpu_set_blendmode(bm_subtract);

	    draw_sprite_ext(
	        TorchLightShaderTest,
	        0,
	        x - cam_x,
	        y - cam_y,
	        1.3 * flicker,
	        1.3 * flicker,
	        0,
	        c_gray,
	        1
	    );
	}

	with (TiltedLight) {
	    gpu_set_blendmode(bm_subtract);

	    draw_sprite_ext(
	        TiltedShadowSprite,
	        0,
	        x - cam_x,
	        y - cam_y,
	        1,
	        1,
	        0,
	        c_gray,
	        1
	    );
	}

	with (MorlockPowerThing) {

	    gpu_set_blendmode(bm_subtract);

	    var frame = floor(image_index);

	    var lx = x - cam_x;
	    var ly = y - cam_y;

	    var scale = 1;
	    var offset_y = 0;

	    // --- FRAME LOGIC ---

	    // Frame 1 → no light
	    if (frame <= 0) {
	        // do nothing (skip drawing)
	    }
	    else {

	        // Frame 2–5: growing + moving upward
	        if (frame >= 1 && frame <= 4) {
	            var t = (frame - 1) / 3; // 0 → 1

	            // y moves from 61 → 51
	            var y_local = lerp(61, 51, t);

	            // scale grows from small → full
	            scale = lerp(0.4, 1.0, t);

	            offset_y = y_local - 32; // center sprite (64px / 2)
	        }

	        // Frame 6–28: move upward (51 → 14)
	        else if (frame >= 5 && frame <= 27) {
	            var t = (frame - 5) / (27 - 5); // 0 → 1

	            var y_local = lerp(51, 14, t);

	            scale = 1.0;

	            offset_y = y_local - 32;
	        }

	        // Frame 28–30: shrink
	        else if (frame >= 27 && frame <= 29) {
	            var t = (frame - 27) / (29 - 27); // 0 → 1

	            var y_local = 14;

	            scale = lerp(1.0, 0.3, t);

	            offset_y = y_local - 32;
	        }

	        // Draw light
	        draw_sprite_ext(
	            TorchLightShaderTest,
	            0,
	            lx,
	            ly + offset_y,
	            scale,
	            0.7 * scale,
	            0,
	            c_blue,
	            1
	        );
	    }
	}
}
else {
	var t = instance_nearest(PlayerObject.x, PlayerObject.y, Torch);
	if (instance_exists(Torch) && (point_distance(PlayerObject.x, PlayerObject.y, t.x, t.y) < 50)) {
				draw_clear_alpha(c_white, 0.95);
			}
			
			else {
			draw_clear_alpha(c_red, 0.2);
			}
		
	
		var flicker = .8 + random_range(-0.05, 0.05);

	// cut out light
	if (global.torch) {
	    gpu_set_blendmode(bm_add);

	    draw_sprite_ext(
	        TorchLightShaderTest,
	        0,
	        PlayerObject.x - cam_x,
	        PlayerObject.y - cam_y,
	        flicker,
	        flicker,
	        0,
	        c_white,
	        1
	    );
	}

	with (Torch) {
	    gpu_set_blendmode(bm_add);

	    draw_sprite_ext(
	        TorchLightShaderTest,
	        0,
	        x - cam_x,
	        y - cam_y,
	        flicker,
	        flicker,
	        0,
	        c_white,
	        0.9
	    );
	}

	with (Light) {
	    gpu_set_blendmode(bm_add);

	    draw_sprite_ext(
	        TorchLightShaderTest,
	        0,
	        x - cam_x,
	        y - cam_y,
	        1.3 * flicker,
	        1.3 * flicker,
	        0,
	        c_gray,
	        .2
	    );
	}

	with (TiltedLight) {
	    gpu_set_blendmode(bm_add);

	    draw_sprite_ext(
	        TiltedShadowSprite,
	        0,
	        x - cam_x,
	        y - cam_y,
	        1,
	        1,
	        0,
	        c_gray,
	        1
	    );
	}

	with (MorlockPowerThing) {

	    gpu_set_blendmode(bm_add);

	    var frame = floor(image_index);

	    var lx = x - cam_x;
	    var ly = y - cam_y;

	    var scale = 1;
	    var offset_y = 0;

	    // --- FRAME LOGIC ---

	    // Frame 1 → no light
	    if (frame <= 0) {
	        // do nothing (skip drawing)
	    }
	    else {

	        // Frame 2–5: growing + moving upward
	        if (frame >= 1 && frame <= 4) {
	            var t = (frame - 1) / 3; // 0 → 1

	            // y moves from 61 → 51
	            var y_local = lerp(61, 51, t);

	            // scale grows from small → full
	            scale = lerp(0.4, 1.0, t);

	            offset_y = y_local - 32; // center sprite (64px / 2)
	        }

	        // Frame 6–28: move upward (51 → 14)
	        else if (frame >= 5 && frame <= 27) {
	            var t = (frame - 5) / (27 - 5); // 0 → 1

	            var y_local = lerp(51, 14, t);

	            scale = 1.0;

	            offset_y = y_local - 32;
	        }

	        // Frame 28–30: shrink
	        else if (frame >= 27 && frame <= 29) {
	            var t = (frame - 27) / (29 - 27); // 0 → 1

	            var y_local = 14;

	            scale = lerp(1.0, 0.3, t);

	            offset_y = y_local - 32;
	        }

	        // Draw light
	        draw_sprite_ext(
	            TorchLightShaderTest,
	            0,
	            lx,
	            ly + offset_y,
	            scale,
	            0.7 * scale,
	            0,
	            c_yellow,
	            1
	        );
	    }
	}
}



// reset
surface_reset_target();
gpu_set_blendmode(bm_normal);

// draw surface aligned to camera
draw_surface(light_surface, cam_x, cam_y);


