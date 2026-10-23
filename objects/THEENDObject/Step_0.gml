if Endfadein == true {
	image_alpha += .03
	if FinalMusicPlayed == false {
		audio_sound_gain(GetRoomMusic(), 0, 2000);
		alarm[4] = 60
		FinalMusicPlayed = true;
	}
}
