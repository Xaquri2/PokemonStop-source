if (!spawned)
{
	var layerName = ""
	var moveSpeed = -2
	if (trainer == object_get_sprite(PlayerObject)) layerName = "Pokemon"
	else 
	{
		moveSpeed = 2
		layerName = "EnemyPokemon"
	}
	
	var entity = instance_create_layer(x,y-32,layerName,BattlePokemonObject)
	entity.sprite_index = trainer
	entity.moveSpeed = moveSpeed
}