if (surface_exists(historySurface)) surface_free(historySurface)
if (room == ShadowPath and layer_exists(fadingLayer))
    layer_set_visible(fadingLayer, fadingLayerWasVisible)
view_visible[1] = previousViewVisible
view_camera[1] = previousViewCamera
view_xport[1] = previousViewXport
view_yport[1] = previousViewYport
view_wport[1] = previousViewWport
view_hport[1] = previousViewHport
