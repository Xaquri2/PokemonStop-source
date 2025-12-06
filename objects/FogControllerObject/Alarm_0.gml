repeat (10) instance_create_layer(x+random_range(-spawnRange,spawnRange), y+random_range(-spawnRange,spawnRange), "Instances", FogObject)
alarm[0] = spawnTime