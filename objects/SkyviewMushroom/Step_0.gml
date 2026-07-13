// Inherit the parent event
event_inherited();

if HasItem("Skyview Mushroom") {
	ds_list_add(global.flags,"GotMushroom")
	instance_destroy(self)
}

