if (instance_exists(Lily)) {
    with (Lily) floatDown = false;
    show_debug_message("Triggered Lily floatDown");
} else {
    show_debug_message("No Lily instance exists in room");
}
