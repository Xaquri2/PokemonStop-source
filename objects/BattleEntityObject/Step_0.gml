if (isWild)
{
	var pk = instance_create_layer(x,y,"EnemyPokemon",BattlePokemonObject)
	pk.index = currentPkmn
	pk.team = team
	pk.playerTeam = false
	instance_destroy(id)
}