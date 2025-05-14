var pkmnLayer = "Pokemon"
if (!entity.player) pkmnLayer = "EnemyPokemon"

var pk = instance_create_layer(x,y,pkmnLayer,BattlePokemonObject)
if (entity.switchIndex == -1)
{
	if (entity.player) entity.currentPkmn = GetFirstHealthyPokemon()
	pk.index = entity.currentPkmn
}
else pk.index = entity.switchIndex

pk.team = entity.team
if (!entity.player) pk.playerTeam = false

instance_destroy(id)