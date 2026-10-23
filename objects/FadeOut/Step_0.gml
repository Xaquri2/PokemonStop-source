if (image_alpha >= 1) && (room == Asleep) {
	audio_sound_gain(TitleTheme, 0.19, 0);
	audio_play_sound(TitleTheme, 0, true);
	room_goto(TitleScreen)
}

//if (room == TitleScreen) {
//	instance_destroy(self)
//}