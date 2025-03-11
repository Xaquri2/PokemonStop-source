var pkmnLayer = "Pokemon"
if (!entity.player) pkmnLayer = "EnemyPokemon"
var pk = instance_create_layer(x,y,pkmnLayer,BattlePokemonObject)
pk.index = entity.currentPkmn
pk.team = entity.team
if (!entity.player) pk.playerTeam = false
instance_destroy(id)