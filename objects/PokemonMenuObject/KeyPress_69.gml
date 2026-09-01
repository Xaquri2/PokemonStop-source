	if instance_exists(PlayerObject) {
		PlayerObject.canWalk = true
		PlayerObject.menuOpen = false
		instance_destroy(MenuObject)
		instance_destroy(self)
	}
