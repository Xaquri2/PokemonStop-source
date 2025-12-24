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
		case GymLeaderTest:
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "That said... Are you ready to challenge me?") //Mary's defeat dialogue
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Start the Gym Battle?"
				optionMenu.option1 = "Yes"
				optionMenu.option2 = "No"
			}
		case NurseJoy:
			if (ds_list_find_value(textList, 0) == "Would you like me to heal your pokémon?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Heal Pokémon?"
				optionMenu.option1 = "Yes"
				optionMenu.option2 = "No"
			}
			else if (ds_list_find_value(textList, 0) == "Alright, let me heal them...")
			{
				player.alarm[1] = -1
				actionNPC.alarm[1] = 60*3
				actionNPC.alarm[2] = 20
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

if (startBattle and instance_number(OptionObject) == 0)
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
	battleObj.enemySprite = actionNPC.trainerSprite
	battleObj.enemyName = name
	battleObj.isWild = isWild
	battleObj.playerX = player.x
	battleObj.playerY = player.y
	battleObj.playerRoom = room
	
	if (object_get_parent(actionNPC.object_index) == GymLeaderParent) 
	{
		battleObj.importantBattle = true
		battleObj.spriteIntro = true
	}
	
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
