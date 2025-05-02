if (keyboard_check_pressed(vk_control)) 
{
	if (global.speedUpMultiplier*2 <= 8) 
	{
		global.speedUpMultiplier = clamp(global.speedUpMultiplier*2, 0, 8)
	}
	else global.speedUpMultiplier = 1
	game_set_speed(global.originalSpeed*global.speedUpMultiplier, gamespeed_fps)
}