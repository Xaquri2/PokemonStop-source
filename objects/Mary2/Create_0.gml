// Inherit the parent event
event_inherited();

battleFlag = "MaryRivalBattle2";

merchant = true
name = "Mary2"
player = instance_find(PlayerObject, 0)

ds_list_add(textList, "Yo dweeb!","I got ahead of you somehow! And I've been training since our last encounter!", "Let's battle!")
ds_list_add(nameList, "Mary","Mary","Mary")
ds_list_add(iconList, MaryFaceSprite,MaryFaceSprite,MaryFaceSprite)

ds_list_add(postBattleTextList, "Oh, that's it! I'm joining your party -- if only to see how you keep cheating!!")
ds_list_add(postBattleNameList, "Mary")
ds_list_add(postBattleIconList, MaryFaceSprite)

trainerSprite = MaryTrainerSprite
