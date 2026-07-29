depth = -y

#region Movement, Controls and Interactions
hspeedOld = hspeed
vspeedOld = vspeed
hspeed = 0

if (RoomHasGravity())
{
	if (vspeed < 3 and collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,LadderObject,false,true) == noone) vspeed += 1.5
}
else vspeed = 0

if (!place_meeting(x, y, TiltedFloor))
{
    falling = true;
}


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

	if (keyboard_check(ord("W")))
	{
		if (!RoomHasGravity()) vspeed = -speedValue
		else
		{
			if (collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,LadderObject,false,true) != noone)
			{
				vspeed = -2
			}
		}
	}
	if (keyboard_check(ord("S")) and !RoomHasGravity()) vspeed = speedValue
	if (keyboard_check(ord("A"))) hspeed = -speedValue
	if (keyboard_check(ord("D"))) hspeed = speedValue

	if (keyboard_check(vk_up) and !RoomHasGravity()) vspeed = -speedValue
	if (keyboard_check(vk_down) and !RoomHasGravity()) vspeed = speedValue
	if (keyboard_check(vk_left)) hspeed = -speedValue
	if (keyboard_check(vk_right)) hspeed = speedValue
	
	if (keyboard_check_pressed(ord("T")))
	{
		if (!global.torch) global.torch = true
		else global.torch = false
	}
	
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
if (HasFlag("Potion") and !HasFlag("PotionCure") or global.morlockTimer > 0) {
	if (vspeed < 0) sprite_index = PlayerMorlockWalkUpSprite
	if (vspeed > 0) sprite_index = PlayerMorlockWalkDownSprite
	if (hspeed > 0) sprite_index = PlayerMorlockWalkRightSprite
	if (hspeed < 0) sprite_index = PlayerMorlockWalkLeftSprite

	if (hspeed == 0 and vspeed == 0)
	{
		if (vspeedOld < 0) sprite_index = PlayerMorlockIdleUpSprite
		if (vspeedOld > 0) sprite_index = PlayerMorlockIdleDownSprite
		if (hspeedOld > 0) sprite_index = PlayerMorlockIdleRightSprite
		if (hspeedOld < 0) sprite_index = PlayerMorlockIdleLeftSprite
	}
}
else if (!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))) {
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
}

#endregion

#region Collision
var collidedPokemon = instance_place(
	x + hspeed,
	y + vspeed,
	RoamingPokemonParent
);

if (instance_exists(collidedPokemon) && collidedPokemon.name != "Morlock")
{
	if (instance_number(BattleObject) == 0)
	{
		var musicC = instance_find(MusicObject, 0);
		var battleTheme = GetBattleTheme(collidedPokemon.name);

		if (instance_exists(musicC))
		{
			audio_stop_sound(musicC.currentMusic);
			audio_play_sound(battleTheme, 1, false);
			musicC.currentMusic = battleTheme;
		}

		collidedPokemon.battle = true;

		talking = false;
		canWalk = false;
		battle = true;

		var battleObj = instance_create_layer(
			collidedPokemon.x,
			collidedPokemon.y,
			"Instances",
			BattleObject
		);

		battleObj.enemyTeam = collidedPokemon.trainerTeam;
		battleObj.enemySprite = collidedPokemon.trainerSprite;
		battleObj.enemyName = collidedPokemon.name;
		battleObj.isWild = true;

		battleObj.playerX = x;
		battleObj.playerY = y;
		battleObj.playerRoom = room;

		if (collidedPokemon.battleFlag != "")
		{
			battleObj.battleFlag = collidedPokemon.battleFlag;
		}
	}
}

if (canCollide)
{
	var collidedTile = collision_rectangle(bbox_left+hspeed, bbox_bottom+vspeed,
	bbox_right+hspeed, bbox_top+vspeed, CollisionParent, false, true)

	if (instance_exists(collidedTile))
	{
		if ((collidedTile.object_index == RoamingPokemonParent) or (collidedTile.object_index == NestAreaPokemon))
		{
			with (collidedTile)
			{
				if (instance_number(BattleObject) == 0)
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
					battleObj.enemyName = name
					battleObj.isWild = true
					battleObj.playerX = other.x
					battleObj.playerY = other.y
					battleObj.playerRoom = room

					if (battleFlag != "") battleObj.battleFlag = battleFlag
				}
			}
		}
		
		if (collidedTile.object_index == TiltedFloor)
		{
			if (hspeed != 0) y -= 1
		}
		else
		{	
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
var npc1 = instance_nearest(x,y,NPCParent);
var npc2 = instance_nearest(x, y, NPCParent_NoCollision);

var npc = noone;

if (npc1 == noone) npc = npc2;
else if (npc2 == noone) npc = npc1;
else if (point_distance(x, y, npc1.x, npc1.y) < point_distance(x, y, npc2.x, npc2.y)) npc = npc1;
else npc = npc2;

if (distance_to_object(npc) <= 32)
//if (npc != noone && point_distance(x, y, npc.x, npc.y) <= 32)
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

	if (keyboard_check_pressed(vk_enter) and !menuOpen and !talking and !battle
	and (object_get_parent(nearestNPC.object_index) != Morlock or (global.morlockTimer == 0 
	and (!HasFlag("Potion") or (HasFlag("Potion") and HasFlag("PotionCure"))))))
	{
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)

		if (nearestNPC.object_index == PokelootObject and nearestNPC.obtainable)
		or (object_get_parent(nearestNPC.object_index) == PokelootObject and nearestNPC.obtainable)
		{
			dialogue.item = nearestNPC.item
			dialogue.itemCount = nearestNPC.itemCount

			if (string_count("Pokemon", nearestNPC.itemTag) == 1)
			{
				var optionMenu = instance_create_depth(20,20,depth-1,OptionObject)
				optionMenu.question = string_concat("Do you want ", nearestNPC.item, ", ", GetTitleByNumber(GetNumberByName(nearestNPC.item)), "?")
				ds_list_add(optionMenu.optionList, "Yes")
				ds_list_add(optionMenu.optionList, "No")
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
		dialogue.isWild = nearestNPC.isWild
		
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
if (canEncounter and ds_list_size(global.playerParty) > 0)
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

if (!talking and !battle and global.torch)
{
	if (global.torchPower > 0) global.torchPower -= 0.001
	else global.torchPower = 0
}

//if (instance_exists(DarkTower)) {
//	var DaarkTower = instance_nearest(x,y,DarkTower)
//
//	if (BehindTower == true && DaarkTower.image_alpha > 0.5) {
//	
//		DaarkTower.image_alpha -= 0.01
//	}
//
//	if (BehindTower == false && DaarkTower.image_alpha < 1) {
//	
//		DaarkTower.image_alpha += 0.01
//	}
//}
#endregion

if instance_exists(TextboxObject) {
	ControlsHidden = true;
}