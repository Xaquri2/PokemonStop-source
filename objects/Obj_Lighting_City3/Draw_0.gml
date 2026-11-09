// Camera sizes can change after room transitions or zooming.
var cam = view_camera[0];
var w = max(1, ceil(camera_get_view_width(cam)));
var h = max(1, ceil(camera_get_view_height(cam)));
if (surface_exists(light_surface)) {
    if (surface_get_width(light_surface) != w or surface_get_height(light_surface) != h) {
        surface_free(light_surface);
        light_surface = -1;
    }
}
if (!surface_exists(light_surface)) {
    light_surface = surface_create(w, h);
}

// get camera position
var cam_x = camera_get_view_x(cam);
var cam_y = camera_get_view_y(cam);
var lx = x - cam_x;
var ly = y - cam_y;

var scale = 1;
var offset_y = 0;

// draw onto surface
surface_set_target(light_surface);


if ((HasFlag("Potion") and !HasFlag("PotionCure")) or global.morlockTimer > 0) {
	// BRIGHT WHITE LIGHT
	if (room != MutantPath1) and (room != EmptyHouse) and (room != ShadowPathGym) {
	draw_clear_alpha(c_white, 0.98);
	}
	else {
		draw_clear_alpha(c_white, 0.80);
	}
	var flicker = .8 + random_range(-0.05, 0.05);

	// Torch
	if (global.torch and global.torchPower > 0) {
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
	        1
	    );
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

else {
	draw_clear_alpha(c_black, 0);
//	var t = instance_nearest(PlayerObject.x, PlayerObject.y, Torch);
//	if (instance_exists(Torch) && (point_distance(PlayerObject.x, PlayerObject.y, t.x, t.y) < 50)) {
//				draw_clear_alpha(c_white, 0.95);
//			}
//			
//			else {
//			draw_clear_alpha(c_red, 0.2);
//			}
//		
//	
//		var flicker = .8 + random_range(-0.05, 0.05);
//
//	// Torch
//	if (global.torch) {
//	    gpu_set_blendmode(bm_add);
//
//	    draw_sprite_ext(
//	        TorchLightShaderTest,
//	        0,
//	        PlayerObject.x - cam_x,
//	        PlayerObject.y - cam_y,
//	        flicker,
//	        flicker,
//	        0,
//	        c_white,
//	        1
//	    );
//	}
//
//	with (Torch) {
//	    gpu_set_blendmode(bm_add);
//
//	    draw_sprite_ext(
//	        TorchLightShaderTest,
//	        0,
//	        x - cam_x,
//	        y - cam_y,
//	        flicker,
//	        flicker,
//	        0,
//	        c_white,
//	        0.9
//	    );
//	}
//
//	with (Light) {
//	    gpu_set_blendmode(bm_add);
//
//	    draw_sprite_ext(
//	        TorchLightShaderTest,
//	        0,
//	        x - cam_x,
//	        y - cam_y,
//	        1.3 * flicker,
//	        1.3 * flicker,
//	        0,
//	        c_gray,
//	        .2
//	    );
//	}
//
//
//	        // Draw light
//	        draw_sprite_ext(
//	            TorchLightShaderTest,
//	            0,
//	            lx,
//	            ly + offset_y,
//	            scale,
//	            0.7 * scale,
//	            0,
//	            c_yellow,
//	            1
//	        );
	    }




// reset
surface_reset_target();
gpu_set_blendmode(bm_normal);

// draw surface aligned to camera
draw_surface(light_surface, cam_x, cam_y);


