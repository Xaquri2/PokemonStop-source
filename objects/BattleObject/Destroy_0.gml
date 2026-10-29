if (!defeat)
{
	if (!isWild) ds_list_add(global.beatenTrainers, enemyName)

	if (postBattleTextList != noone and !ds_list_empty(postBattleTextList) and enemyName != "Collector")
	{
		player = instance_find(PlayerObject, 0)
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.isDefeatDialogue = true
		// Several independent trainers can share an object type. Bind the
		// dialogue to the trainer that actually fought, not its first sibling.
		for (var i = 0; i < instance_number(enemyObjectType); i++)
		{
			var trainer = instance_find(enemyObjectType, i)
			if (trainer.name == enemyName)
			{
				dialogue.actionNPC = trainer
				break
			}
		}

		dialogue.textList = postBattleTextList
		dialogue.iconList = postBattleIconList
		dialogue.nameList = postBattleNameList

		dialogue.name = enemyName
		if (instance_exists(player)) player.talking = true

		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
	}
} //

var game = instance_find(GameObject, 0)
game.warp = false

player = instance_find(PlayerObject, 0)
player.battle = false
var camera = instance_find(CameraObject, 0)
if (instance_exists(player) and instance_exists(camera))
{
	camera.x = player.x
	camera.y = player.y
}

ds_list_destroy(playerFieldEffects)
ds_list_destroy(enemyFieldEffects)
ds_list_destroy(battleParticipants)
ds_list_destroy(pikminList)
