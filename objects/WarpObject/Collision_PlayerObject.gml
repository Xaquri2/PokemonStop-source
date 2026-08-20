if (!game.warp)
{
	if (is_door) {
		audio_play_sound(DoorOpen, 1, false);
	}

		if (is_stairs) {
		audio_play_sound(StairsSound, 1, false);
	}

	other.canWalk = false
	game.fade = true
	game.warp = true
	game.targetRoom = targetRoom
	game.targetWarp = targetWarp
}

/*if (play_cutscene && !instance_exists(CutsceneObject)) {
    var cs = instance_create_depth(0, 0, -999999900000, CutsceneObject);
    cs.sprite_index = cutscene_sprite;
    cs.image_index = 0;
    cs.image_speed = 1;
}*/