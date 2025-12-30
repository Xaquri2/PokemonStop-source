if (instance_number(FogObject) < 2000)
{
	repeat (spawnAmount) 
	{
		instance_create_layer(x+random_range(-spawnRange,spawnRange), 
		y+random_range(-spawnRange,spawnRange), "Instances", FogObject)
	}
}
alarm[0] = spawnTime