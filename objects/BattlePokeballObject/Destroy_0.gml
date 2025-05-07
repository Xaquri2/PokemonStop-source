if (timesBobbed < 3)
{
	for (var i = 0; i < random_range(5,13); i++)
	{
		var part = instance_create_layer(other.x,other.y,
		"Particles",StatBoostParticleObject)
		
		part.hspeed = random_range(-2,2)
		part.vspeed = random_range(-2,2)
	}
}

if (target != -1)
{
	target.catchEffectAlpha = 1
	target.catchEffect = false
}