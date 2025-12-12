spawnRange = 1500
spawnRangeIncrement = 0
spawnRangeDirection = 1

spawnTime = 2

alarm[0] = spawnTime
alarm[1] = spawnTime

repeat(2000)
{
	instance_create_layer(x+random_range(-spawnRange,spawnRange), 
	y+random_range(-spawnRange,spawnRange), "Important", FogObject)
}