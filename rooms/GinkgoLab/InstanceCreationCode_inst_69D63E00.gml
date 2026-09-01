item = "Creeper"
itemCount = 1
itemTag = "StarterPokemonOne"
pokemonInfo = CreatePokemonInfo(item, 5, true, noone)

if HasFlag("StarterChosen") {
	instance_destroy(self)
}