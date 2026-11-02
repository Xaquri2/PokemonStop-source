if (view_current != 0) exit

if (!surface_exists(application_surface)) exit
var surfaceWidth = surface_get_width(application_surface)
var surfaceHeight = surface_get_height(application_surface)
if (surface_exists(historySurface))
{
    if (surface_get_width(historySurface) != surfaceWidth
        or surface_get_height(historySurface) != surfaceHeight)
    {
        surface_free(historySurface)
        historySurface = -1
        historyReady = false
    }
}
if (!surface_exists(historySurface))
{
    historySurface = surface_create(surfaceWidth, surfaceHeight)
    historyReady = false
}

if (historyReady and surface_exists(historySurface))
{
    gpu_push_state()
    gpu_set_ztestenable(false)
    gpu_set_zwriteenable(false)
    gpu_set_blendmode_ext(bm_one, bm_zero)
    var cam = view_camera[0]
    draw_surface_stretched_ext(historySurface, camera_get_view_x(cam), camera_get_view_y(cam),
        camera_get_view_width(cam), camera_get_view_height(cam), c_white, 1)
    gpu_pop_state()
}
