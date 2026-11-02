if (instance_exists(SaveMenuObject) or instance_exists(obj_about_dialog)) exit;
event_inherited();
var loadMenu = instance_create_layer(0, 0, "UserInterface", SaveMenuObject);
loadMenu.mode = "Load";
loadMenu.player = noone;
loadMenu.returnToTitle = true;
layer_set_visible("Sequence2", false);
