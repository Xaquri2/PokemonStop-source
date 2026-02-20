// Draw the video surface
if (cutsceneSurface != -1 and surface_exists(cutsceneSurface) and cutscenePlaying) {
    draw_surface_stretched(cutsceneSurface, 0, 0, room_width, room_height);
}