/// @DnDAction : YoYo Games.Instances.Set_Instance_Var
/// @DnDVersion : 1
/// @DnDHash : 3ECDA877
/// @DnDComment : Add move_speed to$(13_10)X so it moves right
/// @DnDArgument : "value" "move_speed"
/// @DnDArgument : "value_relative" "1"
x += move_speed;

/// @DnDAction : YoYo Games.Instances.Set_Sprite
/// @DnDVersion : 1
/// @DnDHash : 669202AE
/// @DnDComment : Walk to side sprite
/// @DnDArgument : "imageind_relative" "1"
/// @DnDArgument : "spriteind" "spr_player_walk_side"
/// @DnDSaveInfo : "spriteind" "spr_player_walk_side"
sprite_index = spr_player_walk_side;
image_index += 0;

/// @DnDAction : YoYo Games.Common.Variable
/// @DnDVersion : 1
/// @DnDHash : 514AFB7A
/// @DnDArgument : "expr" ".55"
/// @DnDArgument : "var" "image_xscale"
image_xscale = .55;