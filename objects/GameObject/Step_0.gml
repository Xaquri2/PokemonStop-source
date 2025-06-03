if (keyboard_check_pressed(vk_control)) 
{
	if (global.speedUpMultiplier*2 <= 8) 
	{
		global.speedUpMultiplier = clamp(global.speedUpMultiplier*2, 0, 8)
	}
	else global.speedUpMultiplier = 1
	game_set_speed(global.originalSpeed*global.speedUpMultiplier, gamespeed_fps)
}

if (fade) 
{
	if (fadeAlpha < 1) fadeAlpha += 0.05
	else 
	{
		if (warp and room != targetRoom) 
		{
			warp = false
			room_goto(targetRoom)
		}
		else if (warp and room == targetRoom)
		{
			warp = false
			fade = false
			targetRoom = noone
			player.busy = false
		}
	}
}
else
{
	if (fadeAlpha > 0) fadeAlpha -= 0.05
}