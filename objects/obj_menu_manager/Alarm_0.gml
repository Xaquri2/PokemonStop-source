/// @DnDAction : YoYo Games.Audio.Stop_All_Audio
/// @DnDVersion : 1
/// @DnDHash : 08D1D181
/// @DnDComment : Stop all previous audio
audio_stop_all();

/// @DnDAction : YoYo Games.Audio.Play_Audio
/// @DnDVersion : 1.1
/// @DnDHash : 6F86E0C8
/// @DnDComment : Play menu music
/// @DnDArgument : "soundid" "TitleTheme"
/// @DnDArgument : "loop" "1"
/// @DnDSaveInfo : "soundid" "TitleTheme"
audio_play_sound(TitleTheme, 0, 1, 1.0, undefined, 1.0);

/// @DnDAction : YoYo Games.Common.Set_Global
/// @DnDVersion : 1
/// @DnDHash : 5A98766D
/// @DnDArgument : "value" "1"
/// @DnDArgument : "var" "global.speedUpMultiplier"
global.speedUpMultiplier = 1;