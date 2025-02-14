/// @param {string}   name    The name of the Pokémon being added
/// @param {real}     level   The level of the Pokémon being added
/// @param {string}   gender  The name of the Pokémon being added
/// @param {asset}    sprite  The sprite of the Pokémon being added
/// @description              Adds a Pokémon to the player's party with the provided information, with all of it being stored inside a DS list. Added Pokémon are always added with 100% of their health.
function AddPokemon(name, level, gender, sprite) {
	var pokemon = ds_list_create()
	ds_list_add(pokemon, global.catchIndex, name, level, gender, sprite, 100)
	ds_list_add(global.pokemonList, pokemon)
	global.catchIndex++
	
	if (ds_list_size(global.playerParty) < 6)
	{
		ds_list_add(global.playerParty, pokemon)
	}
}

/// @param {string}   index   The name of the Pokémon to retreive info about
/// @description              Returns a list with the information of the given Pokémon, using its index in the party as an identifier, in the following order: Index, Name, Level, Gender, Sprite.
function GetPartyMemberInfo(index) {
	return ds_list_find_value(global.playerParty, index)
}

/// @param {string}   index   The name of the Pokémon to retreive base stats of
/// @description              Returns a list with the base stats of the given Pokémon, in the following order: HP, Attack, Defense, Special Attack, Special Defense, Speed.
function GetPokemonBaseStats(index) {
	var pokemon = ds_list_find_value(global.playerParty, index)
	var name = ds_list_find_value(pokemon, 1)
	var statList = ds_list_create()
	switch (name)
	{
		case "Pikachu":
			ds_list_add(statList, 35, 55, 40, 50, 50, 90)
			break
		case "Squirtle":
			ds_list_add(statList, 44, 48, 65, 50, 64, 43)
			break
		case "Charmander":
			ds_list_add(statList, 39, 52, 43, 60, 50, 65)
			break
		case "Snorlax":
			ds_list_add(statList, 160, 110, 65, 65, 110, 30)
			break
	}
	return statList
}

/// @param {string}   index   The name of the Pokémon to retreive final stats of
/// @description              Returns a list with the final stats of the given Pokémon, in the following order: HP, Attack, Defense, Special Attack, Special Defense, Speed.
function GetPokemonFinalStats(index)
{
	var pokemon = ds_list_find_value(global.playerParty, index)
	var level = ds_list_find_value(pokemon, 2)
	var baseStats = GetPokemonBaseStats(index)
	
	var finalStats = ds_list_create()
	for (var i = 0; i < ds_list_size(baseStats); i++)
	{
		ds_list_add(finalStats, ds_list_find_value(baseStats, i)*(2*(level/100)))
	}
	
	return finalStats
}