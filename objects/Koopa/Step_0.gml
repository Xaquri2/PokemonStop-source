// Inherit the parent event
event_inherited();

if (direction == 0) {
	hspeed = 1
	image_xscale = 1
}
else if (direction == 180) {
	hspeed = -1
	image_xscale = -1
}
else if (direction == 1) {
	hspeed = 0
	vspeed = 0
}
else if (direction == 181) {
	hspeed = 0
	vspeed = 0
}

//if (PlayerCollide == true) {
//	hspeed = 0
//}
