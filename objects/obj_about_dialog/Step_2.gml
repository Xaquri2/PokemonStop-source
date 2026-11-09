// Keep blocking title-button release events until the closing click is finished.
if (closing and !mouse_check_button(mb_left))
    instance_destroy();
