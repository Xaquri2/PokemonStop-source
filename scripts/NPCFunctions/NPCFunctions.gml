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
	// Leaders pay a fixed bonus; other known trainers scale with progression.
	switch (n)
	{
		case "Lilium": return 1800
		case "Gorbertron": return 1800
		case "Collector": return 2000
		case "Zoovac": return 4000
	}

	switch (GetTrainerRank(n))
	{
		case 0: return irandom_range(50, 150)
		case 1: return irandom_range(150, 250)
		case 2: return irandom_range(300, 500)
		case 3: return irandom_range(600, 900)
		case 4: return irandom_range(1000, 1400)
	}
	return irandom_range(50, 150)
}

function GetTrainerRank(n)
{
	switch (n)
	{
		// Opening battle and lower Route Minus One.
		case "GodzillaTestTrainer":
		case "Gym Leader Test":
		case "Mary":
		case "Hat Kid":
		case "Kidd Funkadelic, Jr.":
		case "Pikachu":
		case "KcoKt":
			return 0

		// Upper Route Minus One and the early branch trainers.
		case "Mary2":
		case "Ultiron":
		case "Bestie":
		case "Shocker":
		case "Team Rocket Hexagonni":
		case "BoxBotH":
		case "BoxBotI":
		case "Greg":
			return 1

		// Deeper branch areas, Morlock City, and Mountain Peak.
		case "Morlock Trainer":
		case "Skull":
		case "BridgeMorlock":
		case "Morlock Tunnel Scout":
		case "Morlock Bridge Sentry":
		case "Bottrick Notthuman":
		case "Cloaked Trainer":
		case "Ephemelia":
		case "Box Bot O":
		case "Ian":
		case "Elise":
			return 2

		// Gym leaders and the first three tower floors.
		case "Sphinx":
		case "Lilium":
		case "Gorbertron":
		case "Collector":
		case "Team Rocket Mildred":
		case "Team Rocket Bonnie":
		case "Team Rocket Gladys":
		case "Team Rocket Roxanne":
		case "Team Rocket Spike":
		case "Team Rocket Marnie":
		case "Team Rocket Jett":
			return 3

		// Fourth-floor gauntlet and the final boss.
		case "Team Rocket Sable":
		case "Team Rocket Cruz":
		case "Team Rocket Nyx":
		case "Team Rocket Harlow":
		case "Team Rocket Gage":
		case "Team Rocket Vesper":
		case "Team Rocket Dante":
		case "Team Rocket Kira":
		case "Zoovac":
			return 4

		default: return 0
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

function ConfigureMorlockDialogue(npc, friendlyText, humanText)
{
	npc.morlockFriendlyText = friendlyText
	npc.morlockHumanText = humanText
	RefreshMorlockDialogue(npc)
}

function RefreshMorlockDialogue(npc)
{
	var disguised = (HasFlag("Potion") and !HasFlag("PotionCure")) or global.morlockTimer > 0
	var lines = disguised ? npc.morlockFriendlyText : npc.morlockHumanText
	ds_list_clear(npc.textList)
	ds_list_clear(npc.nameList)
	ds_list_clear(npc.iconList)
	for (var i = 0; i < array_length(lines); i++)
	{
		ds_list_add(npc.textList, lines[i])
		ds_list_add(npc.nameList, "Morlock")
		ds_list_add(npc.iconList, npc.sprite_index)
	}
}

function RefreshMorlockTrainerDialogue(npc)
{
	// The sentry's challenge does not depend on the player's form.
	if (npc.name != "BridgeMorlock" and npc.name != "Morlock Tunnel Scout") return
	var disguised = (HasFlag("Potion") and !HasFlag("PotionCure")) or global.morlockTimer > 0
	npc.morlockDialogueDisguised = disguised
	ds_list_clear(npc.textList)
	ds_list_clear(npc.nameList)
	ds_list_clear(npc.iconList)
	ds_list_clear(npc.postBattleTextList)
	ds_list_clear(npc.postBattleNameList)
	ds_list_clear(npc.postBattleIconList)
	if (npc.name == "BridgeMorlock")
	{
		if (disguised)
		{
			ds_list_add(npc.textList, "Oh hello, fellow Morlock!",
			"Man, all this study of human culture is making me HUNGRY!",
			"Good thing you're not a human! I would've eaten you right on the spot! Heh, heh, heeee!",
			"Ah, still, I guess I'll have to settle for demolishing your Pokémon!!!")
			ds_list_add(npc.postBattleTextList, "Good match! You win fair and square!",
			"I... should probably go get some dinner.", "Till the next time we meet!")
		}
		else
		{
			ds_list_add(npc.textList, "I am learning to respect your human culture.",
			"I believe the polite phrasing is, 'may I please eat you?'")
			ds_list_add(npc.postBattleTextList, "Ah, then I am NOT to eat you, it seems?",
			"While I strongly disagree with your decision, I respect your resolve in making it.",
			"Still, I hope to eat you the next time we meet!")
		}
	}
	else
	{
		if (disguised)
		{
			ds_list_add(npc.textList, "Hey buddy, I'm practicing with my Pokémon so I can become the Pokémon Master!! Wanna spar?")
			ds_list_add(npc.postBattleTextList, "Dang! I really gotta practice harder.", "Thanks for the match!")
		}
		else
		{
			ds_list_add(npc.textList, "Ack!! A Human!!")
			ds_list_add(npc.postBattleTextList, "Beaten by a human!! How humiliating.",
			"Hey, let's keep this between us & I won't eat you. Deal?")
		}
	}
	repeat (ds_list_size(npc.textList))
	{
		ds_list_add(npc.nameList, "Morlock trainer")
		ds_list_add(npc.iconList, npc.sprite_index)
	}
	repeat (ds_list_size(npc.postBattleTextList))
	{
		ds_list_add(npc.postBattleNameList, "Morlock trainer")
		ds_list_add(npc.postBattleIconList, npc.sprite_index)
	}
}

function PostBattleFlagActivation(flag)
{
	switch (flag)
	{
		case "MaryRivalBattle1": return false
		default: return true
	}
}
