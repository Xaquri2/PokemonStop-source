if (game.warp and game.targetWarp == warpName)
{
	var player = instance_find(PlayerObject, 0)
	if (!instance_exists(player)) player = instance_create_layer(0, 0, "Instances", PlayerObject)

	switch (spawnDirection)
	{
		case "Up":
			player.x = x+sprite_width/2
			player.y = bbox_top-32
			break
		case "Down":
			player.x = x+sprite_width/2
			player.y = bbox_bottom+32
			break
		case "Right":
			player.x = bbox_right+32
			player.y = y+sprite_height/2
			break
		case "Left":
			player.x = bbox_left-32
			player.y = y+sprite_height/2
			break
	}

	game.warp = false
	game.targetWarp = ""
}
