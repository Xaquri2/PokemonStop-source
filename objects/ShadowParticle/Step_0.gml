// Random tiny push (Brownian style)
var rand_x = random_range(-jitter_strength, jitter_strength);
var rand_y = random_range(-jitter_strength, jitter_strength);

hspeed += rand_x;
vspeed += rand_y;

// Gently pull back toward starting position
var dx = start_x - x;
var dy = start_y - y;

hspeed += dx * pull_strength;
vspeed += dy * pull_strength;

// Optional: limit speed so they don’t zoom off
var max_speed = 0.4;
if (point_distance(0, 0, hspeed, vspeed) > max_speed)
{
    var dir = point_direction(0, 0, hspeed, vspeed);
    hspeed = lengthdir_x(max_speed, dir);
    vspeed = lengthdir_y(max_speed, dir);
}


if (Sphinx.RiddleSolved == true && !instance_exists(TextboxObject)) {
	image_alpha -= 0.004; 
}

if (Sphinx.RiddleSolved == true && !instance_exists(TextboxObject) && looped == false) {
	looped = true
	audio_play_sound(Downers3,0,0)
}