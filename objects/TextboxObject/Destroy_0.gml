if (instance_exists(actionNPC))
{
	if (IsMerchant(actionNPC.name))
	{
		var merchantMenu = instance_create_layer(x,y,"UserInterface",MerchantMenuObject)
		merchantMenu.itemList = GetMerchantItems(actionNPC.name)
		merchantMenu.player = instance_find(PlayerObject, 0)
	}

	switch (actionNPC.object_index)
	{
		case Snorlax:
			if (HasItem("Poke Flute") and ds_list_empty(actionNPC.trainerTeam))
			{
				if (player.alarm[1] > -1) player.alarm[1] = -1

				actionNPC.alarm[0] = 5
			}
			break
		case Ginkgo:
			switch (GetNPCFlag("Ginkgo"))
			{
				case undefined:
				case "ChoosingFirstDialogue":
					SetNPCFlag("Ginkgo", "ChoosingDefaultDialogue")
					break
			}
			break
	}
}

if (isDefeatDialogue)
{
	switch(name)
	{
		case "Mary":
			if (ds_list_find_value(textList, 0) == "How? I can't believe i lost!") //Mary's defeat dialogue
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.question = "Pick an option."
				optionMenu.option1 = "Get lost, loser!"
				optionMenu.option2 = "Why don't you join me?"
			}
			break
	}
}

if (startBattle)
{
	var musicC = instance_find(MusicObject, 0)
	var music = musicC.currentMusic
	audio_stop_sound(music)
	audio_play_sound(GetBattleTheme(name), 1, false)
	musicC.currentMusic = GetBattleTheme(name)

	player.talking = false
	player.canWalk = false
	player.battle = true

	var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
	battleObj.enemyTeam = actionNPC.trainerTeam
	battleObj.enemySprite = actionNPC.battleSprite
	battleObj.enemyName = name
	battleObj.isWild = isWild
	battleObj.playerX = player.x
	battleObj.playerY = player.y
	battleObj.playerRoom = room

	battleObj.trainerX = actionNPC.x
	battleObj.trainerY = actionNPC.y

	if (!ds_list_empty(actionNPC.postBattleTextList))
	{
		battleObj.postBattleTextList = actionNPC.postBattleTextList
		battleObj.postBattleIconList = actionNPC.postBattleIconList
		battleObj.postBattleNameList = actionNPC.postBattleNameList
	}

	if (actionNPC.battleFlag != "") battleObj.battleFlag = actionNPC.battleFlag
}

if (ds_list_find_value(textList, 0) == "Fine! Whatever...")
{
	ds_list_add(global.flags, "MaryRivalBattle1")
	instance_destroy(Mary)
	global.followerType = "Mary"
}

if (ds_list_find_value(textList, 0) == "It's a weird leaf, sticking up from the ground.")
{
	player.alarm[1] = -1
	var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
	optionMenu.question = "Pull it?"
	optionMenu.option1 = "Yes"
	optionMenu.option2 = "No"
	optionMenu.referenceNPC = actionNPC
}
