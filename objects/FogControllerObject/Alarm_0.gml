alarm[1] = spawnTime

repeat(spawnAmount*10)
{
	instance_create_layer(x+random_range(-spawnRange+spawnOffset,spawnRange+spawnOffset), 
	y+random_range(-spawnRange+spawnOffset,spawnRange+spawnOffset), "Important", FogObject)
}