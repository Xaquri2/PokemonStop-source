// Inherit the parent event
event_inherited();

/// obj_tektite : Create

// --- CONFIG ---
wait_min = room_speed * 1;     // 1 sec
wait_max = room_speed * 3;     // 3 sec

leap_distance = 200;           // pixels
leap_seconds  = 1.5;             // seconds
leap_total    = round(room_speed * leap_seconds);

arc_height    = 28;            // visual height of arc (pixels)

// Sprite behavior
idle_fps = 3;                  // play at 1 fps while idle

// Which object counts as "solid"
solid_obj = obj_editor_wall;         // change this if needed

// --- STATE ---
STATE_IDLE = 0;
STATE_LEAP = 1;
state = STATE_IDLE;

wait_timer = irandom_range(wait_min, wait_max);

// Leap timeline
leap_timer = 0;                // counts 0..leap_total

// Segment motion (lets us bounce without changing total duration)
seg_start_frame = 0;
seg_duration    = leap_total;

seg_start_x = x;
seg_start_y = y;
seg_end_x   = x;
seg_end_y   = y;

leap_dir = 0;

// Visual-only vertical offset
z = 0;

// Helpers
function start_leap() {
    leap_timer = 0;

    seg_start_frame = 0;
    seg_duration    = leap_total;

    seg_start_x = x;
    seg_start_y = y;

    leap_dir = irandom(359);

    seg_end_x = seg_start_x + lengthdir_x(leap_distance, leap_dir);
    seg_end_y = seg_start_y + lengthdir_y(leap_distance, leap_dir);

    state = STATE_LEAP;
}

function reset_wait() {
    wait_timer = irandom_range(wait_min, wait_max);
}

sprite_shadow = BattleFloorSprite_SHADOW // change to your shadow sprite asset name

prev_state = -1;

frozen_for_battle = false;

last_safe_x = x;
last_safe_y = y;





