event_inherited();
var game = instance_find(GameObject, 0)
if (game.warp and game.targetWarp == "MinusOneToTower")
{
	var player = instance_find(PlayerObject, 0)
	if (!instance_exists(player)) player = instance_create_layer(0, 0, "Instances", PlayerObject)

	player.x = x+sprite_width/2
	player.y = bbox_bottom+32

	game.warp = false
	game.targetWarp = ""
}