if (isWild)
{
	var pk = instance_create_layer(x,y,pkmnLayer,BattlePokemonObject)
	pk.index = entity.currentPkmn
	pk.team = entity.team
	pk.playerTeam = false
	instance_destroy(id)
}