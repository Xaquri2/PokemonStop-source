function GetWalkingCoords(walkRange)
{
	var checkX1 = -1
	var checkX2 = -1
	var checkY1 = -1
	var checkY2 = -1

	while (checkX1 == -1)
	{
		var attempt = [random_range(x-walkRange,x+walkRange), random_range(y-walkRange, y+walkRange)]
		if (attempt[1] > y)
		{
			checkY1 = bbox_top
			checkY2 = attempt[1]+sprite_height/2
		}
		else
		{
			checkY1 = bbox_bottom
			checkY2 = attempt[1]-sprite_height/2
		}

		if (attempt[0] > x)
		{
			checkX1 = bbox_left
			checkX2 = attempt[0]+sprite_width/2
		}
		else
		{
			checkX1 = bbox_right
			checkX2 = attempt[0]-sprite_width/2
		}

		if (instance_exists(collision_rectangle(checkX1, checkY1,
		checkX2, checkY2, CollisionObject, false, true)))
		{
			checkX1 = -1
		}
		else return [attempt[0], attempt[1]]
	}
}

function GetBattleTheme(name)
{
	switch (name)
	{
		//case "Rival Trainer Name": return RivalTheme
		case "Gorbertron": return MutantPathGymBattleTheme
		case "Collector": return RobotGymBattleTheme
		case "Lilium": return ShadowPathGymBattleTheme
		default: return WildBattleTheme
	}
}

function GetNPCFlagDialogue(name, flag)
{
	var dialogue = ds_list_create()
	switch (name)
	{
		case "Ginkgo":
			if (flag == "ChoosingFirstDialogue")
			{
				ds_list_add(dialogue, "Ah, welcome Gash!",
				"It brings me to tears to realize you've come of age.",
				"Choose your first Pokémon!")
			}
			else if (flag == "ChoosingDefaultDialogue")
			{
				ds_list_add(dialogue, "Choose your first Pokémon!")
			}
			else if (flag == "StarterChosen")
			{
				ds_list_add(dialogue, "Have fun in your adventure!")
			}
			break

		default:
			ds_list_add(dialogue, "This is the default dialogue", "Someone doesn't have a name!")
	}
	return dialogue
}

function GetNPCFlag(name) { return ds_map_find_value(global.npcFlags, name) }
function SetNPCFlag(name, flag)
{
	if (ds_map_find_value(global.npcFlags, name) != undefined) ds_map_set(global.npcFlags, name, flag)
	else ds_map_add(global.npcFlags, name, flag)
}

function PostBattleFlagActivation(flag)
{
	switch (flag)
	{
		case "MaryRivalBattle1": return false
		default: return true
	}
}
