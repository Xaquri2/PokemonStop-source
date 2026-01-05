depth = -y

#region Movement and Interactions
hspeedOld = hspeed
vspeedOld = vspeed
hspeed = 0

if (RoomHasGravity())
{
	if (vspeed < 1) vspeed += 0.2
}
else vspeed = 0

if (keyboard_check_pressed(ord("E")) and !menuOpen and !talking and !battle)
{
	canWalk = false
	menuOpen = true
	var menu = instance_create_layer(x,y,"UserInterface",MenuObject)
	menu.player = id
}

if (canWalk and !talking and !battle)
{
	var speedValue = normalSpeed
	if (!IsIndoors()) speedValue = overworldSpeed

	if (keyboard_check(ord("W")) and !RoomHasGravity()) vspeed = -speedValue
	if (keyboard_check(ord("S")) and !RoomHasGravity()) vspeed = speedValue
	if (keyboard_check(ord("A"))) hspeed = -speedValue
	if (keyboard_check(ord("D"))) hspeed = speedValue

	if (keyboard_check(vk_up) and !RoomHasGravity()) vspeed = -speedValue
	if (keyboard_check(vk_down) and !RoomHasGravity()) vspeed = speedValue
	if (keyboard_check(vk_left)) hspeed = -speedValue
	if (keyboard_check(vk_right)) hspeed = speedValue

	if (keyboard_check_pressed(ord("Q")))
	{
		if (global.autosave)
		{
			global.autosave = false
			GenerateTextPopup(x,bbox_top-10,"Autosave Disabled")
		}
		else
		{
			global.autosave = true
			GenerateTextPopup(x,bbox_top-10,"Autosave Enabled")
		}
	}
}
#endregion

#region Animation
if (vspeed < 0) sprite_index = PlayerWalkUpSprite
if (vspeed > 0) sprite_index = PlayerWalkDownSprite
if (hspeed > 0) sprite_index = PlayerWalkRightSprite
if (hspeed < 0) sprite_index = PlayerWalkLeftSprite

if (hspeed == 0 and vspeed == 0)
{
	if (vspeedOld < 0) sprite_index = PlayerIdleUpSprite
	if (vspeedOld > 0) sprite_index = PlayerIdleDownSprite
	if (hspeedOld > 0) sprite_index = PlayerIdleRightSprite
	if (hspeedOld < 0) sprite_index = PlayerIdleLeftSprite
}
#endregion

#region Collision
if (canCollide)
{
	var collidedTile = collision_rectangle(bbox_left+hspeed, bbox_bottom+vspeed,
	bbox_right+hspeed, bbox_top+vspeed, CollisionParent, false, true)

	if (instance_exists(collidedTile))
	{
		if (collidedTile.object_index == TiltedFloor)
		{
			if (hspeed != 0) y -= 1
		}
		else
		{
			if (object_get_parent(collidedTile.object_index) == RoamingPokemonParent)
			{
				with (collidedTile)
				{
					if (!battle)
					{
						var musicC = instance_find(MusicObject, 0)
						var music = musicC.currentMusic
						audio_stop_sound(music)
						audio_play_sound(GetBattleTheme(name), 1, false)
						musicC.currentMusic = GetBattleTheme(name)
	
						battle = true
						other.talking = false
						other.canWalk = false
						other.battle = true

						var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
						battleObj.enemyTeam = trainerTeam
						battleObj.enemySprite = trainerSprite
						battleObj.enemyName = GetName(ds_list_find_value(collidedTile.trainerTeam, 0))
						battleObj.isWild = true
						battleObj.playerX = other.x
						battleObj.playerY = other.y
						battleObj.playerRoom = room

						if (battleFlag != "") battleObj.battleFlag = battleFlag
					}
				}
			}
			
			hspeed = 0
			vspeed = 0
		}
	}

	if (x+hspeed > room_width or x-hspeed < 0 or collision_rectangle(bbox_left+hspeed, bbox_bottom, bbox_right+hspeed, bbox_top, CollisionParent, false, true) != noone) hspeed = 0
	if (y+vspeed > room_height or y-vspeed < 0 or collision_rectangle(bbox_left, bbox_bottom+vspeed, bbox_right, bbox_top+vspeed, CollisionParent, false, true) != noone) vspeed = 0
}
#endregion

#region NPC Interaction
//Check if there are NPCs nearby to talk to
var npc = instance_nearest(x,y,NPCParent)
if (distance_to_object(npc) <= 32)
{
	if (nearestNPC != npc)
	{
		showNPCText = "Press Enter to talk"
		nearestNPC = npc

		arrowDirection = floor(random_range(-1,3))
		if (arrowDirection > 0) arrowDirection = 1
		else arrowDirection = -1
	}
}
else
{
	showNPCText = ""
	nearestNPC = noone
}

if (nearestNPC != noone)
{
	if (arrowDirection >= 0)
	{
		if (arrowSpeed < 0.5) arrowSpeed += 0.05
		if (arrowOffset > 2) arrowDirection = -1
	}
	else
	{
		if (arrowSpeed > -0.5) arrowSpeed -= 0.05
		if (arrowOffset < -2) arrowDirection = 1
	}
	arrowOffset += arrowSpeed

	if (keyboard_check_pressed(vk_enter) and !menuOpen and !talking and !battle)
	{
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

		if (nearestNPC.object_index == PokelootObject and nearestNPC.obtainable)
		{
			dialogue.item = nearestNPC.item
			dialogue.itemCount = nearestNPC.itemCount

			if (string_count("Pokemon", nearestNPC.itemTag) == 1)
			{
				var optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
				optionMenu.question = string_concat("Do you want ", nearestNPC.item, ", ", GetTitleByNumber(GetNumberByName(nearestNPC.item)), "?")
				optionMenu.option1 = "Yes"
				optionMenu.option2 = "No"
				optionMenu.referenceNPC = nearestNPC
			}
			else
			{
				if (nearestNPC.itemCount == 1) ds_list_add(nearestNPC.textList, string_concat("You got a ", nearestNPC.item, "!"))
				else ds_list_add(nearestNPC.textList, string_concat("You got ", nearestNPC.itemCount, " ", nearestNPC.item, "s!"))
				ds_list_add(nearestNPC.textList, string_concat("You put it in your ",  GetItemCategory(nearestNPC.item), " Bag"))
			}
		}

		if (ds_list_empty(nearestNPC.trainerTeam) or ds_list_find_index(global.beatenTrainers, nearestNPC.name) == -1)
		{
			dialogue.textList = nearestNPC.textList
		}
		else
		{
			dialogue.textList = nearestNPC.defeatTextList
		}

		dialogue.iconList = nearestNPC.iconList
		dialogue.nameList = nearestNPC.nameList

		dialogue.name = nearestNPC.name
		dialogue.actionNPC = nearestNPC
		if (nearestNPC.object_index != PokelootObject or nearestNPC.obtainable) talking = true

		if (ds_list_empty(dialogue.textList))
		{
			if !(nearestNPC.object_index == PokelootObject and
			string_count("Pokemon", nearestNPC.itemTag) == 1)
			{
				talking = false
			}
			instance_destroy(dialogue)
		}

		if (nearestNPC.object_index == PokelootObject and
		nearestNPC.obtainable and string_count("Pokemon", nearestNPC.itemTag) != 1)
		{
			instance_destroy(nearestNPC)
		}
	}
}
#endregion

#region Wild Encounters
var grassAttempt = collision_line(bbox_left,bbox_bottom,bbox_right,bbox_bottom,GrassObject,false,true)
var fogAttempt = collision_line(bbox_left,bbox_bottom,bbox_right,bbox_bottom,FogObject,false,true)
if (canEncounter)
{
	if (instance_exists(grassAttempt) and grassTimer == -1 and
	(hspeed != 0 or vspeed != 0))
	{
		var wildBattle = floor(random_range(1,11))
		if (wildBattle == 1)
		{
			var musicC = instance_find(MusicObject, 0)
			var music = musicC.currentMusic
			audio_stop_sound(music)
			audio_play_sound(WildBattleTheme, 1, false)
			musicC.currentMusic = WildBattleTheme

			var wildPkmn = GetWildPokemon("Grass")
			var wildPokemonList = ds_list_create()
			ds_list_add(wildPokemonList, wildPkmn)

			talking = false
			canWalk = false
			battle = true
			var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
			battleObj.enemyTeam = wildPokemonList
			battleObj.enemySprite = GetSprite(wildPkmn)
			battleObj.enemyName = GetName(wildPkmn)
			battleObj.isWild = true
			battleObj.playerX = x
			battleObj.playerY = y
			battleObj.playerRoom = room
		}
		grassTimer = 30
	}
	if (instance_exists(fogAttempt) and fogTimer == -1 and
	(hspeed != 0 or vspeed != 0))
	{
		var wildBattle = floor(random_range(1,30))
		if (wildBattle == 1)
		{
			var musicC = instance_find(MusicObject, 0)
			var music = musicC.currentMusic
			audio_stop_sound(music)
			audio_play_sound(WildBattleTheme, 1, false)
			musicC.currentMusic = WildBattleTheme

			var wildPkmn = GetWildPokemon("Fog")
			var wildPokemonList = ds_list_create()
			ds_list_add(wildPokemonList, wildPkmn)

			talking = false
			canWalk = false
			battle = true
			var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
			battleObj.enemyTeam = wildPokemonList
			battleObj.enemySprite = GetSprite(wildPkmn)
			battleObj.enemyName = GetName(wildPkmn)
			battleObj.isWild = true
			battleObj.playerX = x
			battleObj.playerY = y
			battleObj.playerRoom = room
		}
		fogTimer = 30
	}
}

if (grassTimer > -1) grassTimer--
if (fogTimer > -1) fogTimer--
#endregion

#region Follower Spawning
if (global.followerType != "" and !instance_exists(follower))
{
	follower = instance_create_layer(x,y,"Instances",FollowerObject)
	follower.player = id
}

if (instance_number(FollowerPikminObject) < global.pikminCount)
{
	repeat (global.pikminCount-instance_number(FollowerPikminObject))
	{
		var pikmin = instance_create_layer(x,y,"Instances",FollowerPikminObject)
		pikmin.player = id
	}
}
#endregion

#region Miscellanous Logic
var closestFog = instance_nearest(x,y,FogControllerObject)
if (distance_to_object(closestFog) < fogTeleportRange)
{
	if (alarm[2] == -1) alarm[2] = fogTeleportTime
}
else
{
	if (alarm[2] != -1) alarm[2] = -1
}

#endregion