
if (!game.warp)
{

	if (is_door) {
		audio_play_sound(DoorOpen, 1, false);
	}
	
	other.canWalk = false
	game.fade = true
	game.warp = true
	game.targetRoom = targetRoom
	game.targetWarp = targetWarp
	
	

}
