cutsceneVideo = ""
video_close()

var musicObj = instance_find(MusicObject, 0)
musicObj.currentMusic = GetBattleTheme(enemyName)
audio_play_sound(musicObj.currentMusic, 1, true)