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
		case "Lilium": return CulexKillerbyMrVile //ShadowPathGymBattleTheme
		case "Zoovac": return FightAgainstSmithyByGaMetal
		default: return WildBattleTheme
	}
}

function GetTrainerMoney(n)
{
	switch (n)
	{
		//case "Name of the trainer": return [value]
		default: return 100
	}
}

function GetTrainerRank(n)
{
	switch (n)
	{
		//case "Name of trainer":
		//	return 1
		
		default:
			return 0
	}
}

function GetTrainerLoot(rankValue)
{
	var healList = ds_list_create()
	var ballList = ds_list_create()
	var xItemList = ds_list_create()
	
	switch (rankValue)
	{
		case 0:
			ds_list_add(healList, "Potion")
			ds_list_add(ballList, "Poke Ball")
			break
		
		case 1:
			ds_list_add(healList, "Potion")
			ds_list_add(ballList, "Poke Ball")
			ds_list_add(xItemList, "X Attack", "X Defense", "X Special Attack", "X Special Defense", "X Speed")
			break
		
		case 2:
			ds_list_add(healList, "Potion", "Super Potion")
			ds_list_add(ballList, "Poke Ball", "Great Ball")
			ds_list_add(xItemList, "X Attack", "X Defense", "X Special Attack", "X Special Defense", "X Speed")
			break
		
		case 3:
			ds_list_add(healList, "Potion", "Super Potion", "Hyper Potion")
			ds_list_add(ballList, "Poke Ball", "Great Ball")
			ds_list_add(xItemList, "X Attack", "X Defense", "X Special Attack", "X Special Defense", "X Speed")
			break
		
		case 4:
			ds_list_add(healList, "Potion", "Super Potion", "Hyper Potion", "Max Potion", "Full Restore")
			ds_list_add(ballList, "Poke Ball", "Great Ball", "Ultra Ball")
			ds_list_add(xItemList, "X Attack", "X Defense", "X Special Attack", "X Special Defense", "X Speed",
			"X Attack 2", "X Defense 2", "X Special Attack 2", "X Special Defense 2", "X Speed 2")
			break
	}
	
	var healChance = irandom(100)
	if (!ds_list_empty(healList) and healChance < 60) AddItem(ds_list_find_value(healList, floor(random_range(0,ds_list_size(healList)-1))), 1)
	
	var ballChance = irandom(100)
	if (!ds_list_empty(ballList) and ballChance < 30) AddItem(ds_list_find_value(ballList, floor(random_range(0,ds_list_size(ballList)-1))), 1)
	
	var xItemChance = irandom(100)
	if (!ds_list_empty(xItemList) and xItemChance < 10) AddItem(ds_list_find_value(xItemList, floor(random_range(0,ds_list_size(xItemList)-1))), 1)

	var gainedItem = false
	if (healChance < 60 or ballChance < 30 or xItemChance < 10) gainedItem = true
	
	ds_list_destroy(healList)
	ds_list_destroy(ballList)
	ds_list_destroy(xItemList)
	return gainedItem
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