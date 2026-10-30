player = instance_find(PlayerObject, 0)
if (global.morlockTimer > 0) global.morlockTimer--

if (global.autosave and alarm[1] == -1) alarm[1] = 60*60
else if (!global.autosave) alarm[1] = -1

if (keyboard_check_pressed(vk_control))
{
	if (global.speedUpMultiplier*2 <= 4)
	{
		global.speedUpMultiplier *= 2
	}
	else global.speedUpMultiplier = 1
	game_set_speed(global.originalSpeed*global.speedUpMultiplier, gamespeed_fps)
}

//if (keyboard_check_pressed(ord("Q")))
//{
//	for (var i = 1; i <= 5; i++)
//	{
//		var fileName = string_concat("savefile", i, ".json")
//		if (file_exists(fileName))
//		{
//			file_delete(fileName)
//		}
//	}
//}

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
			cutsceneVideo = GetRoomCutscene(targetRoom)
			if (cutsceneVideo != "") 
			{
				if (video_get_status() == video_status_closed)
				{
					if (cutscenePlaying)
					{
						if (targetRoom == ShadowPathGym and !HasFlag("HasVisitedShadowGym")) ds_list_add(global.flags, "HasVisitedShadowGym")
						
						video_close()
						room_goto(targetRoom)
						cutscenePlaying = false
						
						audio_group_set_gain(Music, beforeCutsceneVolume)
					}
					else
					{
						instance_destroy(RoomNameObject)
						video_open(cutsceneVideo)
						
						cutscenePlaying = true
						cutsceneSurface = video_draw()[1]
						
						beforeCutsceneVolume = audio_group_get_gain(Music)
						audio_group_set_gain(Music, 0)
					}
				}
				else
				{
					if (video_get_status() == video_status_playing) cutsceneSurface = video_draw()[1]
				}
			}
			else 
			{
				room_goto(targetRoom)
			}
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
				player.canWalk = true
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
	if (fadeAlpha > 0) 
	{
		fadeAlpha -= 0.05
	}
}

var battle = instance_find(BattleObject, 0)
if (room == RoomBattle and instance_exists(battle))
{
	if (battle.cutsceneVideo == "")
	{
		var targetBattleTheme = GetBattleTheme(battle.enemyName)
	
		if (!audio_is_playing(targetBattleTheme) and !audio_is_playing(WildBattleThemeNO_INTRO) and
		(targetBattleTheme == WildBattleTheme or targetBattleTheme == WildBattleThemeNO_INTRO))
		{
			audio_play_sound(WildBattleThemeNO_INTRO, 1, false)
		}
		else if (!audio_is_playing(targetBattleTheme) and !audio_is_playing(WildBattleThemeNO_INTRO))
		{
			audio_play_sound(targetBattleTheme, 1, false)
		}
	}
}