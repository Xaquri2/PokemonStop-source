ambientLight = 0.05;

var cam = view_camera[0];
var w = camera_get_view_width(cam);
var h = camera_get_view_height(cam);

light_surface = surface_create(w, h);

with (object_index) {
    if (id != other.id) {
        instance_destroy();
    }
}