function OneOrMinusOne()
{
	var value = irandom(1)
	if (value == 0) return -1
	else return 1
}

function ConvertListToArray(list)
{
	var arr = []
	for (var i = 0; i < ds_list_size(list); i++)
	{
		var element = ds_list_find_value(list, i)
		arr[i] = element
	}
	return arr
}

function ConvertMapToMatrix(map)
{
	if (!ds_map_empty(map))
	{
		var matrix = []

		var key = ds_map_find_first(map)
		while (key != undefined)
		{
			var value = ds_map_find_value(map, key)
			array_push(matrix, [key, value])
			key = ds_map_find_next(map, key)
		}

		return matrix
	}
}

function CenterTextPosition()
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
}

function ResetTextPosition()
{
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

function GetNumberFormat(num)
{
	var str = string(num)
	var zeroList = ds_list_create()
	for (var i = 10; i < 1000; i *= 10)
	{
		if (num < i)
		{
			ds_list_add(zeroList, "0")
		}
	}

	for (var i = 0; i < ds_list_size(zeroList); i++)
	{
		str = string_concat("0", str)
	}

	str = string_concat("#", str)
	return str
}

function HasFlag(flag)
{
	if (ds_list_find_index(global.flags, flag) != -1) return true
	return false
}

function GenerateTextPopup(xPos,yPos,displayText)
{
	var obj = instance_create_depth(xPos,yPos,-1000000,TextPopupObject)
	obj.text = displayText
}

function GetFollowerSprite(spriteDir)
{
	if (object_index == FollowerPikminObject)
	{
		if (spriteDir == "Down") return PikminWalkDownSprite
		else if (spriteDir == "Up") return PikminWalkUpSprite
		else
		{
			if (spriteDir == "Right") xscaleDir = 1
			else xscaleDir = -1
			return PikminWalkRightSprite
		}
	}
	
	switch (global.followerType)
	{
		case "Mary":
			if (spriteDir == "Down") return MaryWalkDownSprite
			if (spriteDir == "Right")
			{
				xscaleDir = 1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Left")
			{
				xscaleDir = -1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Up") return MaryWalkUpSprite

		default:
			if (spriteDir == "Down") return MaryWalkDownSprite
			if (spriteDir == "Right")
			{
				xscaleDir = 1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Left")
			{
				xscaleDir = -1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Up") return MaryWalkUpSprite
			return
	}
}

function CheckForInterruptions()
{
	if (instance_exists(TextboxObject))
		{
			speed = 0
			hspeed = 0
			vspeed = 0
		}
	if (instance_exists(OptionObject))
		{
			speed = 0
			hspeed = 0
			vspeed = 0
		}
	if (instance_exists(MenuObject))
		{
			speed = 0
			hspeed = 0
			vspeed = 0
		}
	if (instance_exists(PlayerObject) && (PlayerObject.menuOpen))
		{
		    speed = 0
		    hspeed = 0
		    vspeed = 0
		}
}

function GetNextNearestGrass()
{
	var closest = noone
	var currentGrass = collision_point(x,y,GrassObject,false,true)
	
	for (var i = 0; i < instance_number(GrassObject); i++)
	{
		var attempt = instance_find(GrassObject, i)
		if (closest == noone or point_distance(x,y,closest.x,closest.y) > point_distance(x,y,attempt.x,attempt.y))
		{
			if (attempt != currentGrass and ds_list_find_index(grassList, attempt) == -1) 
			{
				closest = attempt
				ds_list_add(grassList, attempt)
			}
		}
	}
	
	if (closest == noone and instance_exists(currentGrass)) closest = currentGrass
	return closest
}

function GetGravityFollowerOffset(xAnchor, yAnchor)
{
	for (var i = 16; i > -16; i--)
	{
		var attempt = collision_point(xAnchor, yAnchor+i, CollisionObject, false, true)
		if (attempt == noone) return i
	}
	return 0
}
// Keep the saved flag and live state together for transformations and future cures.
function SetPlayerGhost(enabled)
{
    var flagIndex = ds_list_find_index(global.flags, "PlayerGhost")
    if (enabled) {
        if (flagIndex == -1) ds_list_add(global.flags, "PlayerGhost")
    }
    else {
        while (flagIndex != -1) {
            ds_list_delete(global.flags, flagIndex)
            flagIndex = ds_list_find_index(global.flags, "PlayerGhost")
        }
    }
    global.playerGhost = enabled
    with (PlayerObject) UpdatePlayerAppearance()
}

// Call in player context; preserve facing when changing form while standing still.
function UpdatePlayerAppearance()
{
    global.playerGhost = HasFlag("PlayerGhost")
    var facingIndex = 0
    switch (sprite_index) {
        case PlayerIdleDownSprite:
        case PlayerWalkDownSprite:
        case PlayerMorlockIdleDownSprite:
        case PlayerMorlockWalkDownSprite:
        case GhostPlayerIdleDownSprite:
        case GhostPlayerWalkDownSprite:
            facingIndex = 0; break
        case PlayerIdleUpSprite:
        case PlayerWalkUpSprite:
        case PlayerMorlockIdleUpSprite:
        case PlayerMorlockWalkUpSprite:
        case GhostPlayerIdleUpSprite:
        case GhostPlayerWalkUpSprite:
            facingIndex = 1; break
        case PlayerIdleRightSprite:
        case PlayerWalkRightSprite:
        case PlayerMorlockIdleRightSprite:
        case PlayerMorlockWalkRightSprite:
        case GhostPlayerIdleRightSprite:
        case GhostPlayerWalkRightSprite:
            facingIndex = 2; break
        case PlayerIdleLeftSprite:
        case PlayerWalkLeftSprite:
        case PlayerMorlockIdleLeftSprite:
        case PlayerMorlockWalkLeftSprite:
        case GhostPlayerIdleLeftSprite:
        case GhostPlayerWalkLeftSprite:
            facingIndex = 3; break
    }
    if (vspeed < 0) facingIndex = 1
    if (vspeed > 0) facingIndex = 0
    if (hspeed > 0) facingIndex = 2
    if (hspeed < 0) facingIndex = 3
    var moving = hspeed != 0 or vspeed != 0
    var sprites
    // Ghost appearance wins while existing Morlock effects continue normally.
    if (global.playerGhost) {
        if (moving) sprites = [GhostPlayerWalkDownSprite, GhostPlayerWalkUpSprite, GhostPlayerWalkRightSprite, GhostPlayerWalkLeftSprite]
        else sprites = [GhostPlayerIdleDownSprite, GhostPlayerIdleUpSprite, GhostPlayerIdleRightSprite, GhostPlayerIdleLeftSprite]
    }
    else if ((HasFlag("Potion") and !HasFlag("PotionCure")) or global.morlockTimer > 0) {
        if (moving) sprites = [PlayerMorlockWalkDownSprite, PlayerMorlockWalkUpSprite, PlayerMorlockWalkRightSprite, PlayerMorlockWalkLeftSprite]
        else sprites = [PlayerMorlockIdleDownSprite, PlayerMorlockIdleUpSprite, PlayerMorlockIdleRightSprite, PlayerMorlockIdleLeftSprite]
    }
    else {
        if (moving) sprites = [PlayerWalkDownSprite, PlayerWalkUpSprite, PlayerWalkRightSprite, PlayerWalkLeftSprite]
        else sprites = [PlayerIdleDownSprite, PlayerIdleUpSprite, PlayerIdleRightSprite, PlayerIdleLeftSprite]
    }
    sprite_index = sprites[facingIndex]
}
