if (instance_exists(SaveMenuObject) or instance_exists(obj_about_dialog)) exit;
event_inherited();
instance_create_layer(0, 0, "UserInterface", obj_about_dialog);
layer_set_visible("Sequence2", false);
