player = instance_find(PlayerObject, 0)

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