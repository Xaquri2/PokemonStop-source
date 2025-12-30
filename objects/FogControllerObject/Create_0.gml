spawnRange = 1500
spawnRangeIncrement = 0
spawnRangeDirection = 1

spawnTime = 2
spawnAmount = 10

alarm[0] = 1

repeat(200)
{
	instance_create_layer(x+random_range(-spawnRange,spawnRange), 
	y+random_range(-spawnRange,spawnRange), "Important", FogObject)
}