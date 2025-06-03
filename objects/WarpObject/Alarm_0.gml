var game = instance_find(GameObject, 0)
if (game.warp and game.targetWarp == warpName)
{
	var player = instance_find(PlayerObject, 0)
	player.x = x
	player.y = y-64
	game.warp = false
}