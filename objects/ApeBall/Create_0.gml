// Inherit the parent event
event_inherited();

// --- settings ---
target_obj  = PlayerObject; // change if your player object name differs
trigger_dist = 300;
approach_time = 0.1; // seconds to reach the player

// --- state ---
chasing = false;
roar_played = false; 
