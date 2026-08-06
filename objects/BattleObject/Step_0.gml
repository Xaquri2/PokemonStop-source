if (room != RoomBattle and room != RoomBattleGodzilla)
{
	if (!spriteIntro)
	{
		if (fadingIntro and fadeCount < 5)
		{
			if (fadeAlpha < 1 and fadeDir == 1)
			{
				if (fadeCount < 4) fadeAlpha += 0.12
				else
				{
					fadeAlpha += 0.02
					if (fadeAlpha >= 1)
					{
						if (enemyName == "Zoovac" and HasFlag("ZoovacFirstBattle")) room_goto(RoomBattleGodzilla)
						else room_goto(RoomBattle)
					}
				}
				if (fadeAlpha >= 1 and fadeCount < 4)
				{
					fadeDir = 0
				}
			}
			if (fadeAlpha > 0 and fadeDir == 0)
			{
				fadeAlpha -= 0.12
				if (fadeAlpha <= 0)
				{
					fadeCount++
					fadeDir = 1
				}
			}
		}
	}
	else
	{
		if (enemySpriteOffset > 0)
		{
			enemySpriteOffset -= 10
		}
		else
		{
			if (playerSpriteOffset < 0)
			{
				playerSpriteOffset += 10
			}
			else
			{
				spriteIntro = false
			}
		}
	}
}
else
{
	if (ending)
	{
		if (fadeAlpha < 1) fadeAlpha += 0.05
		else 
		{
			global.money += GetTrainerMoney(enemyName)
			if (defeat) room_goto(GinkgoLab) //SaveStateAction(global.latestSaveState, "Load")
			else room_goto(playerRoom)
		}
	}
	
	if (cutsceneVideo == "")
	{
		if (topRectValue-5 > 0)
		{
			topRectValue -= 5
		}
		else topRectValue = 0
	}
}

if (cutsceneVideo != "") 
{
	if (playCutscene)
	{
		cutsceneSurface = video_draw()[1]
		if !(video_get_status() == video_status_closed and cutscenePlaying)
		{
			alarm[0]++
		}
		else
		{
			if (!audio_is_playing(GetBattleTheme(enemyName))) audio_play_sound(GetBattleTheme(enemyName), 1, false)
		}
	}
}

/* Clouds
if (cloud_level > cloud_target) {
    cloud_level -= 0.001; // about 1.7 seconds at 60 FPS
    cloud_level = max(cloud_level, cloud_target);

    var fx = layer_get_fx("Clouds");
    if (fx != -1) {
        fx_set_parameter(fx, "g_CloudLevel", cloud_level);
    }
}
if room == RoomBattleGodzilla {
	show_debug_message("Clouds layer:" + string(layer_get_visible("Clouds") ))
}