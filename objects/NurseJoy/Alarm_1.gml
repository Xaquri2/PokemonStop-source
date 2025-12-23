for (var i = 0; i < ds_list_size(global.playerParty); i++)
{
	HealPokemon(global.playerParty, i, 1000000, true, true, true)
}

var player = instance_find(PlayerObject, 0)
var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
dialogue.name = name
dialogue.actionNPC = id

ds_list_add(dialogue.textList, "Your pokémon have been healed!")

player.talking = true

if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)