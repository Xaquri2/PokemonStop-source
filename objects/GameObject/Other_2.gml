randomize()

var itemsList = ds_list_create()
var ballsList = ds_list_create()
var battleList = ds_list_create()
var berryList = ds_list_create()
var keyList = ds_list_create()

ds_list_add(itemsList, "Potion", "Potion", "Super Potion", "Potion", "Hyper Potion", "Hyper Potion")

global.categoryNameList = ds_list_create()
ds_list_add(global.categoryNameList, "Items", "Balls", "Battle Items", "Berries", "Key Items")

global.categoryItemList = ds_list_create()
ds_list_add(global.categoryItemList, itemsList, ballsList, battleList, berryList, keyList)

global.catchIndex = 0 //The index of every new Pokémon caught
global.pokemonList = ds_list_create() //The list containing all Pokémon caught

global.partySize = 6 //The maximum size of the player party
global.playerParty = ds_list_create() //The player party list

AddPokemon("Pikachu", 15, "Male", PikachuIdleSprite)
AddPokemon("Squirtle", 25, "Female", SquirtleIdleSprite)
AddPokemon("Charmander", 25, "Male", CharmanderIdleSprite)
AddPokemon("Snorlax", 25, "Female", SnorlaxIdleSprite)