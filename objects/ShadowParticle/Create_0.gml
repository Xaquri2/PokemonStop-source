// Remember where this instance started
start_x = x;
start_y = y;

// Movement tuning
max_radius = 20;      // how far it’s allowed to wander
jitter_strength = 0.5; // how strong the random push is
pull_strength = 0.02;  // how strongly it drifts back toward start

// Unique motion seed
randomize(); // optional, only once globally usually

looped = false;
