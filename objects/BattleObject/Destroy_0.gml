if (!isWild) ds_list_add(global.beatenTrainers, enemyName)

if (postBattleTextList != noone and !ds_list_empty(postBattleTextList))
{
	player = instance_find(PlayerObject, 0)
	var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
	dialogue.isDefeatDialogue = true

	dialogue.textList = postBattleTextList
	dialogue.iconList = postBattleIconList
	dialogue.nameList = postBattleNameList

	dialogue.name = enemyName
	player.talking = true

	if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
}
