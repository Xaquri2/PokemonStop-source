with (inst_70AD7FDB) {
    target_x = open_x;
    target_y = open_y;
	moving = true;
}

with (inst_7B36F9C2) {
    target_x = open_x;
    target_y = open_y;
	moving = true;
}



if (playing == true) {
	audio_play_sound(OldMetalSlidingDoor,1,0,4,.2)
	alarm[1] = 100
	playing = false;
	}
