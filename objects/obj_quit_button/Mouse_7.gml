if (instance_exists(SaveMenuObject) or instance_exists(obj_about_dialog)) exit;
/// @DnDAction : YoYo Games.Instances.Inherit_Event
/// @DnDVersion : 1
/// @DnDHash : 2C989185
event_inherited();

/// @DnDAction : YoYo Games.Game.End_Game
/// @DnDVersion : 1
/// @DnDHash : 08428F48
game_end();