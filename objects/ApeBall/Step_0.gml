// Inherit the parent event
event_inherited();

var p = instance_nearest(x, y, target_obj);
if (!instance_exists(p)) exit;

var d = point_distance(x, y, p.x, p.y);

// Start chasing when within range
if (!chasing && d <= trigger_dist) chasing = true;

if (chasing)
{
    // Move so that "time to reach" is ~approach_time seconds
    // Convert seconds to steps:
    var steps = max(1, approach_time * room_speed);

    // Speed needed to cover remaining distance in that many steps:
    var spd = d / steps;

    // Move toward player
    var dir = point_direction(x, y, p.x, p.y);
    x += lengthdir_x(spd, dir);
    y += lengthdir_y(spd, dir);
	
	//Play sound
	{
    chasing = true;

    if (!roar_played)
    {
        audio_play_sound(MP3_Bear_Roar_2, 1, false);
        roar_played = true;
    }
}

    // Optional: snap when super close (prevents tiny jitter)
    if (d <= spd)
    {
        x = p.x;
        y = p.y;
    }
}
