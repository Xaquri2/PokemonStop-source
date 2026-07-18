
if (HasFlag("StarterChosen")) {
	instance_destroy(FollowerPikminObject)
	AddPokemon("Pikmin",1,"Male",PikminIdleSprite)
	global.pikminCount -= 1
}