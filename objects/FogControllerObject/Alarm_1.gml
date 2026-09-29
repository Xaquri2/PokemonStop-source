if (instance_number(FogObject) < 4000)
{
	repeat (spawnAmount) 
	{
		instance_create_layer(x+random_range(-spawnRange+spawnOffset,spawnRange+spawnOffset), 
		y+random_range(-spawnRange+spawnOffset,spawnRange+spawnOffset), "Instances", FogObject)
	}
}
alarm[1] = spawnTime