var music = GetRoomMusic()
if (room != RoomBattle and instance_number(BattleObject) == 0)
{
	// The ending fades this sound asset to zero; restore it for credits replays.
	if (room == EndCreditsRoom) audio_sound_gain(music, 1, 0)

	if (currentMusic == noone)
	{
		audio_play_sound(music, 1, true)
		currentMusic = music
	}
	else if (currentMusic != music)
	{
		audio_stop_sound(currentMusic)
		audio_play_sound(music, 1, true)
		currentMusic = music
	}
}

