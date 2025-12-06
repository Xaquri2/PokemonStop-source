var game = instance_find(GameObject, 0)
if (!game.warp)
{
	canWalk = false
	game.fade = true
	game.warp = true
	game.targetRoom = ShadowPath
	game.targetWarp = "ShadowToMinusOne"
}
