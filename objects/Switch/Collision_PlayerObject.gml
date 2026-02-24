with (inst_61720F1C) {
    target_x = open_x;
    target_y = open_y;
	moving = true;
}

instance_destroy(inst_5A4F897F)

if (playing == true) {
	audio_play_sound(OldMetalSlidingDoor,1,0,4,.2)
	alarm[1] = 100
	playing = false;
	}
