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
else if (direction == 21) {
	hspeed = 0
}

//if (PlayerCollide == true) {
//	hspeed = 0
//}
