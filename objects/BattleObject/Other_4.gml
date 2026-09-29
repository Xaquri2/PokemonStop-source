if (room == RoomBattle or room == RoomBattleGodzilla)
{
	var playerPkmnIndex = GetFirstHealthyPokemon()
	if (playerPkmnIndex != -1)
	{
		playerPkmn = ds_list_find_value(playerTeam, playerPkmnIndex)
	}
	else if (!ds_list_empty(pikminList))
	{
		var reservePikmin = ds_list_find_value(pikminList, 0)
		ds_list_delete(pikminList, 0)

		if (ds_list_size(playerTeam) < 6)
		{
			AddPokemon(GetName(reservePikmin), GetLevel(reservePikmin), GetGender(reservePikmin))
			playerPkmnIndex = ds_list_size(playerTeam)-1
			playerPkmn = ds_list_find_value(playerTeam, playerPkmnIndex)
		}
		else
		{
			currentPikmin = reservePikmin
			playerPkmn = reservePikmin
		}

		global.pikminCount = max(0, global.pikminCount-1)
	}
	else
	{
		// A battle cannot start without a usable combatant. Resolve it through
		// the normal defeat destination and restore the party for the next try.
		for (var i = 0; i < ds_list_size(playerTeam); i++)
		{
			HealPokemon(playerTeam, i, 1000000, true, true, true)
		}

		ending = true
		defeat = true
		fadeAlpha = 0
		alarm[0] = -1
		exit
	}

	var bgLayer = BattleHasBackground()
	var bgLayer2 = BattleHasBackground2()
	var bgFX = BattleHasFX()
	if (bgLayer != "")
	{
		layer_set_visible(layer_get_id(bgLayer), true)
	}
	if (bgLayer2 != "")
	{
		layer_set_visible(layer_get_id(bgLayer2), true)
	}
	if (bgFX != "")
	{
		layer_set_visible(layer_get_id(bgFX), true)
		layer_set_visible("Background", false)
	}
	
	alarm[0] = 100
	if (cutsceneVideo != "")
	{
		var musicObj = instance_find(MusicObject, 0)
		audio_stop_sound(musicObj.currentMusic)
		musicObj.currentMusic = noone
		
		playCutscene = true
		cutscenePlaying = true
		if (cutsceneVideo == "MegaBotCutscene")
		{
			video_open("MegaBot800.mp4")
			audio_play_sound(MegaBot800CutsceneAudio, 1, false)
		}
		else if (cutsceneVideo == "GodzillaCutscene")
		{
			video_open("GodzillaCutscene.mp4")
		}
		alarm[1] = video_get_duration()
	}
	
	var playerTeamMemberName = GetName(playerPkmn)

	enemyPkmn =  ds_list_find_value(enemyTeam, 0)
	var enemyTeamMemberName = GetName(enemyPkmn)

	if (isWild)
	{
		ds_list_add(textList, string_concat("You found a wild ", enemyName),
		string_concat("Go! ", playerTeamMemberName))
	}
	else
	{
		ds_list_add(textList, string_concat(enemyName, " wants to battle"), string_concat(enemyName, " sent out ", enemyTeamMemberName),
		string_concat("Go! ", playerTeamMemberName))
	}
	
	if (room != RoomBattleGodzilla)
	{
		var floorEnemy = instance_create_layer(room_width*0.7,
		room_height*0.3, "BattleFloor", BattleFloorObject)

		var floorPlayer = instance_create_layer(room_width*0.3,
		room_height*0.7, "BattleFloor", BattleFloorObject)
	
		floorEnemy.team = enemyTeam
		floorEnemy.trainer = enemySprite
		floorEnemy.player = false
		floorEnemy.isWild = isWild

		floorPlayer.team = playerTeam
		floorPlayer.trainer = object_get_sprite(PlayerObject)

		floorEnemy.image_xscale = 2
		floorPlayer.image_xscale = 2
	}
	else
	{
		var floorEnemy = instance_create_layer(150,
		160, "BattleFloor", BattleFloorObject)

		var floorPlayer = instance_create_layer(110,
		170, "BattleFloor", BattleFloorObject)
	
		floorEnemy.team = enemyTeam
		floorEnemy.trainer = enemySprite
		floorEnemy.player = false
		floorEnemy.isWild = isWild

		floorPlayer.team = playerTeam
		floorPlayer.trainer = object_get_sprite(PlayerObject)

		floorEnemy.image_xscale = 2
		floorPlayer.image_xscale = 2
	}
}
else
{
	if (ending)
	{
		if (!defeat)
		{
			if (instance_number(PlayerObject) == 0)
			{	
				//var collisionFix = 
				var player = instance_create_layer(playerX, playerY, "Instances", PlayerObject)
				player.x = playerX
				player.y = playerY
			}
			else
			{
				var player = instance_find(PlayerObject, 0)
				player.x = playerX
				player.y = playerY
			}

			// Returning to the exact pre-battle position can overlap a roaming
			// Pokemon after the overworld room recreates its instances. Separate
			// the player during Room Start, before Step and Collision events can
			// immediately trigger the same battle again.
			var returnedPlayer = instance_find(PlayerObject, 0)
			if (escaped and isWild and instance_exists(returnedPlayer))
			{
				with (returnedPlayer)
				{
					var overlappingPokemon = instance_place(x, y, RoamingPokemonParent)
					if (instance_exists(overlappingPokemon))
					{
						var returnX = x
						var returnY = y
						var leftOffset = bbox_left-x
						var rightOffset = bbox_right-x
						var topOffset = bbox_top-y
						var bottomOffset = bbox_bottom-y
						var escapeDirection = point_direction(overlappingPokemon.x, overlappingPokemon.y, returnX, returnY)
						var blockedDirections = array_create(8, false)
						var foundSafePosition = false

						// Search away from the encountered Pokemon first. Once a ray hits
						// another object or the room boundary, do not teleport through it.
						for (var radius = 8; radius <= 128 and !foundSafePosition; radius += 8)
						{
							for (var directionIndex = 0; directionIndex < 8; directionIndex++)
							{
								if (blockedDirections[directionIndex]) continue

								var checkDirection = escapeDirection+directionIndex*45
								var candidateX = returnX+lengthdir_x(radius, checkDirection)
								var candidateY = returnY+lengthdir_y(radius, checkDirection)
								var insideRoom = candidateX+leftOffset >= 0
								and candidateX+rightOffset < room_width
								and candidateY+topOffset >= 0
								and candidateY+bottomOffset < room_height

								if (!insideRoom)
								{
									blockedDirections[directionIndex] = true
									continue
								}

								var candidateCollision = instance_place(candidateX, candidateY, CollisionParent)
								if (candidateCollision == noone)
								{
									x = candidateX
									y = candidateY
									foundSafePosition = true
									break
								}
								else if (candidateCollision != overlappingPokemon)
								{
									blockedDirections[directionIndex] = true
								}
							}
						}
					}
				}
			}

			for (var i = 0; i < instance_number(TrainerParent); i++)
			{
				var attempt = instance_find(TrainerParent, i)
				if (attempt.name == enemyName)
				{
					//attempt.x = trainerX
					//attempt.y = trainerY
				}
			}
		}

		audio_group_stop_all(BattleThemes)
		instance_destroy(id)
	}
}
