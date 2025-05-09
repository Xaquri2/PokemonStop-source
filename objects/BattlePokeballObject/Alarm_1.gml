var pkmnLayer = "Pokemon"
if (!entity.player) pkmnLayer = "EnemyPokemon"

var pk = instance_create_layer(x,y,pkmnLayer,BattlePokemonObject)
if (entity.player) entity.currentPkmn = GetFirstHealthyPokemon()
pk.index = entity.currentPkmn

pk.team = entity.team
if (!entity.player) pk.playerTeam = false
instance_destroy(id)