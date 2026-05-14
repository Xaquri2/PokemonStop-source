if (!isWild) ds_list_add(global.beatenTrainers, enemyName)

if (postBattleTextList != noone and !ds_list_empty(postBattleTextList) and enemyName != "Collector")
{
	player = instance_find(PlayerObject, 0)
	var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
	dialogue.isDefeatDialogue = true
	if (instance_number(enemyObjectType) > 0) dialogue.actionNPC = instance_find(enemyObjectType, 0)

	dialogue.textList = postBattleTextList
	dialogue.iconList = postBattleIconList
	dialogue.nameList = postBattleNameList

	dialogue.name = enemyName
	player.talking = true

	if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
}

var game = instance_find(GameObject, 0)
game.warp = false

player = instance_find(PlayerObject, 0)
var camera = instance_find(CameraObject, 0)
if (instance_exists(player) and instance_exists(camera))
{
	camera.x = player.x
	camera.y = player.y
}

ds_list_destroy(playerFieldEffects)
ds_list_destroy(enemyFieldEffects)