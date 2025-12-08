event_inherited();
merchant = true
name = "Mary"
player = instance_find(PlayerObject, 0)

ds_list_add(textList, "Yo! Let's battle!")
ds_list_add(nameList, name)
ds_list_add(iconList, sprite_index)

ds_list_add(postBattleTextList, "How? I can't believe i lost!")
ds_list_add(postBattleNameList, name)
ds_list_add(postBattleIconList, sprite_index)

trainerSprite = Mary