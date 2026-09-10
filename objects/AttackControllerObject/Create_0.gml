attackParticle = HitAttackObject
particleSpawnTime = 0

moveName = ""
whoAttacked = ""
playerPkmnEntity = noone
enemyPkmnEntity = noone

for (var i = 0; i < instance_number(BattlePokemonObject); i++)
{
	var attempt = instance_find(BattlePokemonObject, i)
	if (attempt.playerTeam) playerPkmnEntity = attempt
	else if (!attempt.playerTeam) enemyPkmnEntity = attempt
}

alarm[1] = 1

FirePlaying = false
ElectricPlaying = false
WaterPlaying = false