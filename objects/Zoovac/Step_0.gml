// Inherit the parent event
event_inherited();

show_debug_message(
    "Zoovac exists: " + string(instance_exists(Zoovac)) +
    " | Room: " + room_get_name(room) +
    " | Time: " + string(current_time)
);
