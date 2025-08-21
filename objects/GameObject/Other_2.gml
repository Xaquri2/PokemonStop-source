randomize()
global.money = 3000
global.saveFile = 1
global.originalSpeed = game_get_speed(gamespeed_fps)
global.speedUpMultiplier = 1

var itemsList = ds_list_create()
var ballsList = ds_list_create()
var battleList = ds_list_create()
var berryList = ds_list_create()
var keyList = ds_list_create()

global.categoryNameList = ds_list_create()
ds_list_add(global.categoryNameList, "Items", "Balls", "Battle Items", "Berries", "Key Items")

global.categoryItemList = ds_list_create()
ds_list_add(global.categoryItemList, itemsList, ballsList, battleList, berryList, keyList)

global.catchIndex = 0 //The index of every new Pokémon caught
global.pokemonList = ds_list_create() //The list containing all Pokémon caught

global.partySize = 6 //The maximum size of the player party
global.playerParty = ds_list_create() //The player party list

global.pokedex = ds_list_create()

global.beatenTrainers = ds_list_create()

AddPokemon("Pikachu", 15, "Male")
AddPokemon("Squirtle", 25, "Female")
AddPokemon("Charmander", 25, "Male")
AddPokemon("Snorlax", 25, "Female")

AddItem("Potion", 1)
AddItem("Super Potion", 1)
AddItem("Potion", 2)
AddItem("Poke Ball", 50)

AddItem("X Attack", 1)
AddItem("X Defense", 1)
AddItem("X Defense 2", 4)