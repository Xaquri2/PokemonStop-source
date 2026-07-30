var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
var player = instance_find(PlayerObject, 0)

ds_list_clear(textList)
ds_list_add(textList, "The waking pokemon attacked!")

AddPokemonTrainer(trainerTeam, 1, "Snorlax", 3, "Male", SnorlaxIdleSprite)

dialogue.textList = textList
dialogue.iconList = iconList
dialogue.nameList = nameList

dialogue.name = name
dialogue.actionNPC = id
dialogue.isWild = true
player.talking = true
if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)