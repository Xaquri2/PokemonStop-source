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
			if (spriteDir == "Right") image_xscale = 1
			else image_xscale = -1
			return PikminWalkRightSprite
		}
	}
	
	switch (global.followerType)
	{
		case "Mary":
			if (spriteDir == "Down") return MaryWalkDownSprite
			if (spriteDir == "Right")
			{
				image_xscale = 1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Left")
			{
				image_xscale = -1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Up") return MaryWalkUpSprite

		default:
			if (spriteDir == "Down") return MaryWalkDownSprite
			if (spriteDir == "Right")
			{
				image_xscale = 1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Left")
			{
				image_xscale = -1
				return MaryWalkRightSprite
			}
			if (spriteDir == "Up") return MaryWalkUpSprite
			return
	}
}
