/// @param {string}   name    The name of the Pokémon being added
/// @param {real}     level   The level of the Pokémon being added
/// @param {string}   gender  The name of the Pokémon being added
/// @param {asset}    sprite  The sprite of the Pokémon being added
/// @description              Adds a Pokémon to the player's party with the provided information, with all of it being stored inside a DS list.
function AddPokemon(name, level, gender, sprite)
{
	var pokemon = ds_list_create()
	ds_list_add(pokemon, global.catchIndex, name, level, gender, sprite)
	ds_list_add(global.pokemonList, pokemon)
	global.catchIndex++
	
	if (ds_list_size(global.playerParty) < 6)
	{
		ds_list_add(global.playerParty, pokemon)
	}
}

/// @param {string}   index   The name of the Pokémon to retreive info about
/// @description              Returns a list with the information of the given Pokémon, using its index in the party as an identifier, in the following order: Index, Name, Level, Gender, Sprite.
function GetPartyMemberInfo(index){
	return ds_list_find_value(global.playerParty, index)
}