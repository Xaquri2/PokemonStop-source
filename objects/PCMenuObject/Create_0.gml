summaryMode = false
pokemonNumber = -1

menu = -1
currentOption = 0

page = 0
pageAmount = 16
lineAmount = 4

arrowDir = 0
arrowAlpha = 0

switching = false

if (ds_list_empty(global.pcPokemonList) and !ds_list_empty(global.pokemonList))
{
	for (var i = 0; i < ds_list_size(global.pokemonList); i++)
	{
		var attempt = ds_list_find_value(global.pokemonList, i)
		if (ds_list_find_index(global.playerParty, attempt) == -1) ds_list_add(global.pcPokemonList, attempt)
	}
}