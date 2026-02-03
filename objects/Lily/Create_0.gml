// Inherit the parent event
event_inherited();

hover_time = 0;
hover_speed = 0.05;    // how fast it moves
hover_height = 2;      // how far up/down (pixels)

rock_speed = 0.03;     // how fast it rocks
rock_angle = 3;        // how many degrees left/right

floatDown = false;

homeY   = y;          // original position
baseY   = y; 
maxDrop = 100;         // how far down she can float (pixels)
targetY = baseY;      // where she’s trying to go
vsp     = 0;          // vertical speed



