if (instance_exists(actionNPC))
{
	if (IsMerchant(actionNPC.name))
	{
		var merchantMenu = instance_create_layer(x,y,"UserInterface",MerchantMenuObject)
		merchantMenu.itemList = GetMerchantItems(actionNPC.name)
		merchantMenu.player = instance_find(PlayerObject, 0)
		player.talking = true
		player.alarm[1] = -1
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
		case Gorbertron:
			if (ds_list_find_value(textList, 0) != "Alright, let's begin!")
			{
				startBattle = false
			}
			if (!startBattle and ds_list_find_value(textList, ds_list_size(textList)-1) != "That said... Are you ready to challenge me?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Ask a question to Gorbertron."
				ds_list_add(optionMenu.optionList, "What are these things on your desk?",
				"What are the Morlocks?", "What’s an Uber-Morlock?", "What is this place?")
			}
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "That said... Are you ready to challenge me?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Start the Gym Battle?"
				ds_list_add(optionMenu.optionList, "Yes")
				ds_list_add(optionMenu.optionList, "No")
			}
			break
		case Lilium:
			if (ds_list_find_value(textList, 0) != "Alright, let's begin!")
			{
				startBattle = false
			}
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "This place – do you know what it is? ")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Do you know what this place is?"
				ds_list_add(optionMenu.optionList, "It's the gym, right?")
				ds_list_add(optionMenu.optionList, "I do not.")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "You will of course recognize Palkia and Dialga?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Do you know who Dialga and Palkia is?"
				ds_list_add(optionMenu.optionList, "Of course.")
				ds_list_add(optionMenu.optionList, "Who?")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "…Not die so much.")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "React to Lilium's monologue."
				ds_list_add(optionMenu.optionList, "You’re insane… you’ve gone power-mad. You can’t play god like that!")
				ds_list_add(optionMenu.optionList, "Thank you! That’s very generous of you!")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "Come back once you’ve completed your journey… and I’d be glad to convert you into one of my … projects.")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "React to Lilium's offer."
				ds_list_add(optionMenu.optionList, "Ooh! Convert me now pls")
				ds_list_add(optionMenu.optionList, "Uh, yeah, sure… I’ll keep that in mind.")
				
				ds_list_add(global.flags, "LiliumFirstDefeatText")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "That said... Are you ready to challenge me?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Start the Gym Battle?"
				ds_list_add(optionMenu.optionList, "Yes")
				ds_list_add(optionMenu.optionList, "No")
			}
			break
		case Collector:
			if (ds_list_find_value(textList, 0) != "Alright, let's begin!")
			{
				startBattle = false
			}
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "Well, I assume I assume you've brought inferior biological type Pokemon?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Did you bring inferior pokémon?"
				ds_list_add(optionMenu.optionList, "Mostly, yeah")
				ds_list_add(optionMenu.optionList, "Nah dude, all Robits for me")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "who, like Greek mythology, are our betters and will conquer us in the end.")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "React to the Collector."
				ds_list_add(optionMenu.optionList, "But YOU'RE biological!")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "...For now.")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "React to the Collector."
				ds_list_add(optionMenu.optionList, "So, you’re “inferior” then!")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "I'm a future robot, you see.")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "React to the Collector."
				ds_list_add(optionMenu.optionList, "You’re pathetic.", 
				"You’re insane! You’ve gone mad!", "A noble aim! I admire your ambition.")
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "MEGA-BOT, Activate!!!")
			{
				startBattle = true
			}
			else if (ds_list_find_value(textList, ds_list_size(textList)-1) == "That said... Are you ready to challenge me?")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Start the Gym Battle?"
				ds_list_add(optionMenu.optionList, "Yes")
				ds_list_add(optionMenu.optionList, "No")
			}
			break
		case NurseJoy:
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "Come see me when your Pokémon are injured!")
			{
				player.alarm[1] = -1
				var optionMenu = instance_create_layer(20,20,"UserInterface",OptionObject)
				optionMenu.referenceNPC = actionNPC
				optionMenu.question = "Heal Pokémon?"
				ds_list_add(optionMenu.optionList, "Yes")
				ds_list_add(optionMenu.optionList, "No")
			}
			else if (ds_list_find_value(textList, 0) == "Alright, let me heal them...")
			{
				player.alarm[1] = -1
				actionNPC.alarm[1] = 60*3
				actionNPC.alarm[2] = 20
			}
			break
		case BadgeDoorObject:
			if (ds_list_find_value(textList, ds_list_size(textList)-1) == "...the badges begin to resonate!")
			{
				player.alarm[1] = -1
				actionNPC.alarm[1] = 40
			}
			break
		case Sphinx:
		    if (ds_list_find_value(textList, ds_list_size(textList)-1) == 
		        "Which creature has one voice and yet becomes four-footed and two-footed and three-footed?")
		    {
		        player.alarm[1] = -1;

		        var optionMenu = instance_create_layer(20, 20, "UserInterface", OptionObject);
		        optionMenu.referenceNPC = actionNPC;
		        optionMenu.question = "A creature w/ one voice & becomes 4-footed & 2-footed & 3-footed?!";

		        ds_list_add(optionMenu.optionList, "Humans.")
				ds_list_add(optionMenu.optionList, "Dogs.")
				ds_list_add(optionMenu.optionList, "A Table.")
		    }
			
			if (ds_list_find_value(textList, 0) == "Humans.")
				{
					ds_list_add(global.flags, "MaryRivalBattle1")
					instance_destroy(Mary)
					global.followerType = "Mary"
				}
			//if (ds_list_find_value(textList, ds_list_size(textList)-1) == 
		   //    "Humans.")
		   //{
		   //    player.alarm[1] = -1;
		   //
		   //    var optionMenu = instance_create_layer(20, 20, "UserInterface", OptionObject);
		   //    optionMenu.referenceNPC = actionNPC;
		   //    optionMenu.question = "Which creature has one voice and yet becomes four-footed and two-footed and three-footed?";
		   //
		   //    ds_list_add(optionMenu.optionList, "vdfns.")
			//	ds_list_add(optionMenu.optionList, "dfv.")
			//	ds_list_add(optionMenu.optionList, "Adfvle.")
		   //}
		   // break;

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
				ds_list_add(optionMenu.optionList, "Get lost, loser!")
				ds_list_add(optionMenu.optionList, "Why don't you join me?")
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
	
	if (ds_list_find_value(textList, ds_list_size(textList)-1) == "MEGA-BOT, Activate!!!")
	{
		battleObj.cutsceneVideo = MegaBotCutscene
	}
	
	if (object_get_parent(actionNPC.object_index) == GymLeaderParent) 
	{
		battleObj.importantBattle = true
		battleObj.spriteIntro = true
	}
	
	battleObj.trainerX = actionNPC.x
	battleObj.trainerY = actionNPC.y

	if (object_get_parent(actionNPC.object_index) == TrainerParent and !ds_list_empty(actionNPC.postBattleTextList))
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
	ds_list_add(optionMenu.optionList, "Yes")
	ds_list_add(optionMenu.optionList, "No")
	optionMenu.referenceNPC = actionNPC
}

// Resume the controlling sequence (if we were given one)
if (room == GinkoIntroRoom ) {
	if (!is_undefined(seq_element_id) && seq_element_id != -1) {
	    layer_sequence_play(seq_element_id);
		with (NextRoomObect) alarm[0] = 1;
	}
}

}