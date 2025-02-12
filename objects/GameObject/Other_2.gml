randomize()
global.catchIndex = 0 //The index of every new Pokémon caught
global.pokemonList = ds_list_create() //The list containing all Pokémon caught

global.partySize = 6 //The maximum size of the player party
global.playerParty = ds_list_create() //The player party list

AddPokemon("Pikachu", 10, "Male", PikachuSprite)