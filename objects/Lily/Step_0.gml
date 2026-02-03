depth = -y

// hover_time += 1;
// 
// // gentle up/down
// y_offset = sin(hover_time * hover_speed) * hover_height;
// 
// // gentle side-to-side rotation
// image_angle = sin(hover_time * rock_speed) * rock_angle;
// 
// // apply the hovering movement by offsetting from the object's base Y
// y = ystart + y_offset;
depth = -y;

// hover timer
hover_time += 1;

// --- FLOAT CONTROLS baseY ---
if (floatDown) targetY = homeY + maxDrop;
else           targetY = homeY;

var accel = 0.15;
var damp  = 0.85;
var maxSp = 1.5;

var dist = targetY - baseY;

vsp += dist * accel;
vsp *= damp;
vsp = clamp(vsp, -maxSp, maxSp);

baseY += vsp;

// snap
dist = targetY - baseY;
if (abs(dist) < 0.2 && abs(vsp) < 0.2) {
    baseY = targetY;
    vsp = 0;
}

// --- HOVER is just an offset on top ---
var y_offset = sin(hover_time * hover_speed) * hover_height;
y = baseY + y_offset;

// rocking is visual only
image_angle = sin(hover_time * rock_speed) * rock_angle;
