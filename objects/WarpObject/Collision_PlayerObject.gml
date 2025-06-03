var game = instance_find(GameObject, 0)
if (!game.warp)
{
	other.canWalk = false
	game.fade = true
	game.warp = true
	game.targetRoom = targetRoom
	game.targetWarp = targetWarp
}