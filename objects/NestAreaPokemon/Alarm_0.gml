if (canWalk)
{
	var newGrass = GetNextNearestGrass()
	state = "Walk"
	walkCoords = [newGrass.x+newGrass.sprite_width/2,newGrass.y+newGrass.sprite_height/2]
}