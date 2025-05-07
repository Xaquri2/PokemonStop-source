var playerPkmnEntity = -1
for (var i = 0; i < instance_number(BattlePokemonObject); i++)
{
	var attempt = instance_find(BattlePokemonObject, i)
	if (attempt.playerTeam)	playerPkmnEntity = attempt
}
var ball = instance_create_layer(0,playerPkmnEntity.y,"Instances",BattlePokeballObject)
ball.catching = true
ball.timesBobbed = timesBobbed
ball.vspeed = -5
ball.hspeed = 6