event_inherited();
merchant = true
name = "Mary"
player = instance_find(PlayerObject, 0)

if (HasFlag("StarterChosen"))
{
	ds_list_add(textList, "Yo! Let's battle!")
	ds_list_add(nameList, name)
	ds_list_add(iconList, MaryFaceSprite)
}
else
{
	ds_list_add(textList, "Oh, you don't have a Pokémon yet huh? Go get one!")
	ds_list_add(nameList, name)
	ds_list_add(iconList, MaryFaceSprite)
}

ds_list_add(postBattleTextList, "How? I can't believe i lost!")
ds_list_add(postBattleNameList, name)
ds_list_add(postBattleIconList, MaryFaceSprite)

trainerSprite = MaryTrainerSprite