player = instance_find(PlayerObject, 0)

if (global.autosave and alarm[1] == -1) alarm[1] = 60*60
else if (!global.autosave) alarm[1] = -1

if (keyboard_check_pressed(vk_control))
{
	if (global.speedUpMultiplier*2 <= 2)
	{
		global.speedUpMultiplier *= 2
	}
	else global.speedUpMultiplier = 1
	game_set_speed(global.originalSpeed*global.speedUpMultiplier, gamespeed_fps)
}

if (keyboard_check_pressed(vk_alt))
{
	for (var i = 1; i <= 5; i++)
	{
		var fileName = string_concat("savefile", i, ".json")
		if (file_exists(fileName))
		{
			file_delete(fileName)
		}
	}
}

if (keyboard_check_pressed(ord("M")))
{
	if (audio_get_master_gain(0) == 1) audio_set_master_gain(0, 0)
	else audio_set_master_gain(0, 1)
}

if (fade)
{
	if (fadeAlpha < 1) fadeAlpha += 0.05
	else
	{
		if (warp and room != targetRoom)
		{
			room_goto(targetRoom)
		}
		else if (warp and room == targetRoom)
		{
			if (targetRoom == loadRoom) alarm[0] = 1

			warp = false
			fade = false
			targetRoom = noone
			if (instance_exists(player))
			{
				player.busy = false
				player.sprite_index = PlayerIdleDownSprite
			}

			for (var i = 0; i < instance_number(NPCParent); i++)
			{
				var npc = instance_find(NPCParent, i)
				npc.x = npc.originX
				npc.y = npc.originY
			}
		}
	}
}
else
{
	if (fadeAlpha > 0) fadeAlpha -= 0.05
}

var battle = instance_find(BattleObject, 0)
if (room == RoomBattle and !audio_is_playing(GetBattleTheme(battle.enemyName)))
{
	audio_play_sound(WildBattleThemeNO_INTRO, 1, false)
}