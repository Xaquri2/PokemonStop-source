if (instance_exists(currentGrassSpot))
{
	repeat(3)
	{
		var grassPart = instance_create_depth(x, y, depth+1,GrassParticle)
		grassPart.hspeed = random_range(-1,1)
		grassPart.vspeed = random_range(-2,-1)
	}
}