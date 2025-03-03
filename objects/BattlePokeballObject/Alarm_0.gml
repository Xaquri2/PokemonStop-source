var pkmnLayer = "Pokemon"
if (!entity.player) pkmnLayer = "EnemyPokemon"
var pkmn = instance_create_layer(x,y,pkmnLayer,BattlePokemonObject)
pkmn.index = entity.currentPkmn
pkmn.team = entity.team
instance_destroy(id)