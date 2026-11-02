// surface_copy completes its target handling inside this event. No render
// target is left open between callbacks, events, or room transitions.
if (view_current == 0 and surface_exists(historySurface)
    and surface_exists(application_surface))
{
    surface_copy(historySurface, 0, 0, application_surface)
    historyReady = true
}
