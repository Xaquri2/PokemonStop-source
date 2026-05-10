if (vspeed > -1.7) {
	vspeed -= 0.05
}

if (vspeed < 0) {
	alpha -= 0.01;
}
size += .01

if (alpha <= 0) instance_destroy();

depth = -999999