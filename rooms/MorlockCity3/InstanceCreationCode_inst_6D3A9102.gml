// Instance-only setup: shared MorlockTrainer events and other instances stay unchanged.
name = "Morlock Bridge Sentry"
battleFlag = "MorlockCity3_inst_6D3A9102"
lineSightDir = "Right"
lineSight = 400

// Replace the shared object's greeting after its Create event has run.
ds_list_clear(textList)
ds_list_clear(nameList)
ds_list_clear(iconList)
ds_list_add(textList, "Halt! You're not getting past me!")
ds_list_add(nameList, name)
ds_list_add(iconList, sprite_index)
ds_list_add(postBattleTextList, "Gahhh!!")
ds_list_add(postBattleNameList, name)
ds_list_add(postBattleIconList, sprite_index)
// NPCParent's first alarm builds this instance's team from its unique name.
