item = "Envy"
itemCount = 1
itemTag = "StarterPokemonThree"
pokemonInfo = CreatePokemonInfo(item, 5, true, noone)

if HasFlag("StarterChosen") {
	instance_destroy(self)
}