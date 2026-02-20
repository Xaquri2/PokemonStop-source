draw_set_alpha(1-fadeAlpha)
draw_text(20,20,string_concat("Speed: ", global.speedUpMultiplier, "x"))
draw_set_alpha(1)

if (!cutscenePlaying)
{
	draw_set_alpha(fadeAlpha)
	draw_rectangle_color(0,0,view_get_wport(0) + 10000000000000000,
	view_get_hport(0) + 1000000000000000,c_black,c_black,c_black,c_black,false)
	draw_set_alpha(1)
}

// Draw the video surface
if (cutsceneSurface != -1 and surface_exists(cutsceneSurface) and cutscenePlaying) {
	var camera = view_get_camera(0)
	var width = camera_get_view_width(0)
	var height = camera_get_view_height(0)
    draw_surface_stretched(cutsceneSurface, 0, 0, width, height);
}