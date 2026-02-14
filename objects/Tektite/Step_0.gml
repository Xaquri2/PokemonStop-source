// Inherit the parent event
event_inherited();

/// obj_tektite : Step

switch (state) {

    case STATE_IDLE:
        // Idle sprite anim at 1 fps
        image_speed = idle_fps / room_speed;

        z = 0;

        wait_timer--;
        if (wait_timer <= 0) {
            start_leap();
        }
    break;


    case STATE_LEAP:
        // Hold sprite on 2nd frame while airborne
        image_speed = 0;
        image_index = 1; // "second frame" (0-based index)

        // Advance global leap clock
        leap_timer++;

        // --- Visual arc uses TOTAL leap progress so it stays smooth across bounces
        var t_total = clamp(leap_timer / leap_total, 0, 1);
        z = sin(pi * t_total) * arc_height;

        // --- Move along current segment
        var seg_t;
        if (seg_duration <= 0) seg_t = 1;
        else seg_t = clamp((leap_timer - seg_start_frame) / seg_duration, 0, 1);

        var prev_x = x;
        var prev_y = y;

        x = lerp(seg_start_x, seg_end_x, seg_t);
        y = lerp(seg_start_y, seg_end_y, seg_t);

        // --- Bounce if we hit a solid mid-leap
        if (place_meeting(x, y, obj_editor_wall)) {

            // Go back to previous safe position
            x = prev_x;
            y = prev_y;

            // Find what we hit (optional but nicer)
            var hit = instance_place(x, y, obj_editor_wall);

            // Pick "away" direction
            var away_dir;
            if (hit != noone) {
                away_dir = point_direction(hit.x, hit.y, x, y);
            } else {
                away_dir = leap_dir + 180;
            }

            // Remaining time in the leap (keeps total duration unchanged)
            var remaining_frames = max(0, leap_total - leap_timer);

            // Original speed (pixels per frame)
            var leap_speed = leap_distance / leap_total;

            // Remaining distance should match what would've been left
            var remaining_dist = leap_speed * remaining_frames;

            // Start a NEW segment from current position to a new destination
            seg_start_x = x;
            seg_start_y = y;

            seg_start_frame = leap_timer;
            seg_duration    = remaining_frames;

            // Aim away and pick destination using remaining_dist
            leap_dir = away_dir;

            seg_end_x = seg_start_x + lengthdir_x(remaining_dist, leap_dir);
            seg_end_y = seg_start_y + lengthdir_y(remaining_dist, leap_dir);

            // (No change to leap_timer — total timeline stays intact)
        }
		
		  // ---Stop if we hit GASH
        if (place_meeting(x, y, PlayerObject)) {

            // Go back to previous safe position
           // x = prev_x;
           // y = prev_y;

            // Find what we hit (optional but nicer)
            var hit = instance_place(x, y, PlayerObject);

            // Pick "away" direction
            var away_dir;
            if (hit != noone) {
                away_dir = point_direction(hit.x, hit.y, x, y);
            } else {
                away_dir = leap_dir + 180;
            }

            // Remaining time in the leap (keeps total duration unchanged)
            var remaining_frames = max(0, 0);

            // Original speed (pixels per frame)
            var leap_speed = leap_distance / leap_total;

            // Remaining distance should match what would've been left
            var remaining_dist = leap_speed * remaining_frames;

            // Start a NEW segment from current position to a new destination
            seg_start_x = x;
            seg_start_y = y;

            seg_start_frame = leap_timer;
            seg_duration    = remaining_frames;

            // Aim away and pick destination using remaining_dist
            leap_dir = away_dir;

            seg_end_x = seg_start_x + lengthdir_x(remaining_dist, leap_dir);
            seg_end_y = seg_start_y + lengthdir_y(remaining_dist, leap_dir);

            // (No change to leap_timer — total timeline stays intact)
        }

        // --- End of leap
        if (leap_timer >= leap_total) {
            state = STATE_IDLE;
            reset_wait();

            // resume idle animation
            image_speed = idle_fps / room_speed;
            z = 0;
        }
    break;
}



