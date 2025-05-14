var ball = instance_create_layer(x,y,"Items",BattlePokeballObject)
ball.entity = id
ball.vspeed = -3

if (player) ball.hspeed = 3.5
else ball.hspeed = -3

if (switchIndex != -1) ball.pkmnIndex = switchIndex