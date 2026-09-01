// Inherit the parent event
event_inherited();

event_inherited();
name = "Kidd Funkadelic, Jr."
lineSightDir = "Down"
lineSight = 64

ds_list_add(textList, "None of this is right!!", "You’ve got to wake up!!", "This isn’t real!")
ds_list_add(nameList, name, name, name)
ds_list_add(iconList, sprite_index, sprite_index, sprite_index)

image_alpha = 1;
fade_spd = 1 / (4 * room_speed);
fading = false;

battleFlag = "KiddFunk_inst_1";

if HasFlag("FadedOut") {
	instance_destroy(self)
}



