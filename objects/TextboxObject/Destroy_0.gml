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
	battleObj.enemySprite = object_get_sprite(actionNPC.object_index)
	battleObj.enemyName = name
	battleObj.isWild = isWild
	battleObj.playerX = player.x
	battleObj.playerY = player.y
	battleObj.playerRoom = room
	
	battleObj.trainerX = actionNPC.x
	battleObj.trainerY = actionNPC.y
	
	if (actionNPC.battleFlag != "") battleObj.battleFlag = actionNPC.battleFlag
}