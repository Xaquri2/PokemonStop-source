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
	switch (GetMoveType(moveName))
	{
	    case "Fire":
			//if (playing == false) {
	        audio_play_sound(MP3_Fireball_Travel_2,1,0)
			FirePlaying = true
			//}
	        break;

	    case "Electric":
	        audio_play_sound(MP3_Water_Swoosh_2,1,0)
			ElectricPlaying = true
	        break;

	    case "Water":
	        audio_play_sound(MP3_Water_Swoosh_2,1,0)
			WaterPlaying = true
	        break;
	}
}

if FirePlaying == true {
	audio_sound_gain(MP3_Fireball_Travel_2,0,2000)
	FirePlaying = false
}
