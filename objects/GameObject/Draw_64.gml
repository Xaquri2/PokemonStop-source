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
    var width = display_get_gui_width();
    var height = display_get_gui_height();
    draw_surface_stretched(cutsceneSurface, 0, 0, width, height);
}