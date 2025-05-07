if (catching and !activated)
{
	hspeed = 0
	vspeed = 0
	image_angle = 0
	
	activated = true
	for (var i = 0; i < random_range(5,13); i++)
	{
		var part = instance_create_layer(other.x,other.y,
		"Particles",StatBoostParticleObject)
		
		part.hspeed = random_range(-2,2)
		part.vspeed = random_range(-2,2)
	}
	
	other.catchEffect = true
	target = other.id
}