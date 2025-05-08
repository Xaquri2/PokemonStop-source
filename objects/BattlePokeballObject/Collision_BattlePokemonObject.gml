if (catching and !activated)
{
	var battle = instance_find(BattleObject, 0)
	if (battle.isWild)
	{
		hspeed = 0
		vspeed = 0
		image_angle = 0
	
		activated = true
		for (var i = 0; i < random_range(5,13); i++)
		{
			var part = instance_create_layer(other.x,other.y,
			"Particles",PokeballParticleObject)

			part.hspeed = random_range(-2,2)
			part.vspeed = random_range(-2,2)
		}
	
		other.catchEffect = true
		target = other.id
	}
	else
	{
		hspeed *= -1
		vspeed = -2
		alarm[2] = 60
	}
}