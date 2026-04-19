//if (!instance_exists(TextboxObject)) {
//	instance_create_layer(320, 240, "Instances", PressKeyToContinueText_Enter);
//}

if (seen_textbox_after_set2 && !instance_exists(TextboxObject_GINKGO_DIALOGUE)) {
    instance_create_layer(740, 840, "UserInterface", PressKeyToContinueText_Enter);
} else {
    alarm[1] = 1; // keep checking until it's truly done
}
