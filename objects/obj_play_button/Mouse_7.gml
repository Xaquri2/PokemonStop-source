/// @DnDAction : YoYo Games.Instances.Inherit_Event
/// @DnDVersion : 1
/// @DnDHash : 6CBB9609
event_inherited();

/// @DnDAction : YoYo Games.Audio.Audio_Set_Volume
/// @DnDVersion : 1.1
/// @DnDHash : 7095E4E6
/// @DnDArgument : "sound" "TitleTheme"
/// @DnDArgument : "volume" "0"
/// @DnDArgument : "time" "500"
/// @DnDSaveInfo : "sound" "TitleTheme"
audio_sound_gain(TitleTheme, 0, 500);

/// @DnDAction : YoYo Games.Instances.Set_Alarm
/// @DnDVersion : 1
/// @DnDHash : 7AEE5D5C
/// @DnDArgument : "steps" "60"
alarm_set(0, 60);