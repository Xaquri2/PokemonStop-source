if (alarm[0] == particleSpawnTime and attackParticle != noone)
{
	var xPos = playerPkmnEntity.x
	var yPos = playerPkmnEntity.y
	if (whoAttacked == "Player")
	{
		xPos = enemyPkmnEntity.x
		yPos = enemyPkmnEntity.y
	}

	instance_create_layer(xPos, yPos, "Particles", attackParticle)
}
