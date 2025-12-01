if (alarm[0] % 5 == 0)
{
	var xPos = x+random_range(-32, 32)
	var yPos = y+random_range(-32, 32)

	var part = instance_create_layer(xPos,yPos,"Particles",StatBoostParticleObject)
	part.dirTimer = random_range(1,30)
	if (boosting) part.vspeed = -1
	else part.vspeed = 1

	var dir = random_range(-1,3)
	if (dir < 1) part.dir = -1
	else part.dir = 1
}
