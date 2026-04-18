// Inherit the parent event
event_inherited();

merchant = true
name = "Mary2"
player = instance_find(PlayerObject, 0)

ds_list_add(textList, "Yo dweeb! Let's battle!")
ds_list_add(nameList, "Mary")
ds_list_add(iconList, MaryFaceSprite)

ds_list_add(postBattleTextList, "How? I can't believe i lost!")
ds_list_add(postBattleNameList, "Mary")
ds_list_add(postBattleIconList, MaryFaceSprite)

trainerSprite = MaryTrainerSprite
