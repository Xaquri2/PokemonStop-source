randomize()
audio_group_load(Music)
audio_group_load(BattleThemes)

global.playerName = "Gash"
global.money = 3000

global.autosave = false
global.saveFile = 1
global.latestSaveState = 1

global.originalSpeed = game_get_speed(gamespeed_fps)
global.speedUpMultiplier = 1

global.followerType = ""
global.pikminCount = 0

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

global.partySize = 36 //The maximum size of the player party
global.playerParty = ds_list_create() //The player party list

global.pokedex = ds_list_create()

global.beatenTrainers = ds_list_create()
global.collectedPokeloot = ds_list_create()

global.flags = ds_list_create()
global.npcFlags = ds_map_create()

AddPokemon("Pikachu", 100, GetRandomGender(50))
AddPokemon("Ewok", 100, GetRandomGender(50))
/*AddPokemon("Godzilla", 95, GetRandomGender(50))
AddPokemon("Omega Squirtle", 100, GetRandomGender(50))
AddPokemon("Glyptoblock", 15, GetRandomGender(50))
AddPokemon("Creeper", 100, GetRandomGender(50))
AddPokemon("Charmander", 100, GetRandomGender(50))*/
//AddPokemon("Pikachu", 10, GetRandomGender(50))

global.standardStartRoom = FifthFloor
global.activatedBadges = ds_list_create()

global.torch = false
global.torchPower = 1
global.torchRange = 60

global.morlockTimer = 0
global.convinceCounter = 0

AddItem("Field Area Key", 1)
AddItem("Skyview Potion", 1)
AddItem("Poke Flute", 1)

ds_list_add(global.flags, "ZoovacFirstBattle")