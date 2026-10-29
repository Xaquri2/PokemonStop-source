// Instance-only setup: shared MorlockTrainer events and other instances stay unchanged.
name = "Morlock Tunnel Scout"
battleFlag = "MorlockCity3_inst_6D3A9101"
lineSightDir = "Down"
lineSight = 160

// Replace the shared object's greeting after its Create event has run.
ds_list_clear(textList)
ds_list_clear(nameList)
ds_list_clear(iconList)
ds_list_add(textList, "The lower tunnels are my patrol route. Show me what you can do!")
ds_list_add(nameList, name)
ds_list_add(iconList, sprite_index)
ds_list_add(postBattleTextList, "You can pass. Keep an eye out for hungry Morlocks.")
ds_list_add(postBattleNameList, name)
ds_list_add(postBattleIconList, sprite_index)
// NPCParent's first alarm builds this instance's team from its unique name.
