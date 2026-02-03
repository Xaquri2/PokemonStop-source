if (instance_exists(Lily)) {
    with (Lily) floatDown = true;
    show_debug_message("Triggered Lily floatDown");
} else {
    show_debug_message("No Lily instance exists in room");
}
