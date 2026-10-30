var music = GetRoomMusic()
if (room != RoomBattle and instance_number(BattleObject) == 0)
{
	if (currentMusic == noone or currentMusic != music)
	{
		if (currentMusic != noone) audio_stop_sound(currentMusic)
		// Asset volume persists after fades, so restore it before starting room music.
		audio_sound_gain(music, 1, 0)
		audio_play_sound(music, 1, true)
		currentMusic = music
	}
}

