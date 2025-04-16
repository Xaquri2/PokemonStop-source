if (!spawned)
{
	spawned = true
	var layerName = ""
	var moveSpeed = -2
	if (trainer == object_get_sprite(PlayerObject)) layerName = "Pokemon"
	else 
	{
		moveSpeed = 2
		layerName = "EnemyPokemon"
	}
	
	var entity = instance_create_layer(x,y-32,layerName,BattleEntityObject)
	entity.sprite_index = trainer
	entity.moveSpeed = moveSpeed
	entity.player = player
	entity.team = team
	entity.isWild = isWild
}