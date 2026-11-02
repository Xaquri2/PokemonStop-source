historySurface = -1
historyReady = false

// Keep the asset layer hidden for both views. Draw its sprites explicitly only
// in the presentation pass, so cached layer visibility cannot leak into history.
fadingLayer = layer_get_id("FadingTiles")
fadingLayerWasVisible = layer_get_visible(fadingLayer)
fadingElements = layer_get_all_elements(fadingLayer)
layer_set_visible(fadingLayer, false)
depth = layer_get_depth(fadingLayer)-1

// Reuse the live camera so both passes have exactly the same view transform.
// Pass zero updates history without the gradient; pass one presents the room.
previousViewVisible = view_visible[1]
previousViewCamera = view_camera[1]
previousViewXport = view_xport[1]
previousViewYport = view_yport[1]
previousViewWport = view_wport[1]
previousViewHport = view_hport[1]
view_visible[1] = true
view_camera[1] = view_camera[0]
view_xport[1] = view_xport[0]
view_yport[1] = view_yport[0]
view_wport[1] = view_wport[0]
view_hport[1] = view_hport[0]
