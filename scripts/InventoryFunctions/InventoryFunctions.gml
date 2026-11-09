//Items are stored in lists, with the data being in the following order: Name, Amount.
function GetItemInfo(categoryIndex, itemIndex) { return ds_list_find_value(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex) }
function GetItemName(itemInfo) { return ds_list_find_value(itemInfo, 0) }
function GetItemAmount(itemInfo) { return ds_list_find_value(itemInfo, 1) }
function UpdateItemAmount(itemInfo, amount) {
// 	if (GetItemName(itemInfo) == "Potion")
// 		show_debug_message("[Inventory] Potion count: " + string(GetItemAmount(itemInfo)) + " -> " + string(amount) + " (room " + room_get_name(room) + ")")
	ds_list_set(itemInfo, 1, amount)
}
function DeleteItem(categoryIndex, itemIndex) { ds_list_delete(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex) }

function GetItemCategory(name)
{
	if (string_count("Area Key", name) > 0)
	{
		return "Items"
	}
	
	switch (name)
	{
		#region Items
		case "Potion":
		case "Super Potion":
		case "Hyper Potion":
		case "Max Potion":
		case "Full Restore":
		case "Torch Fuel":
		case "Super Torch Fuel":
		case "Ultra Torch Fuel":
			return "Items"
		#endregion

		#region Balls
		case "Poke Ball":
		case "Great Ball":
		case "Ultra Ball":
			return "Balls"
		#endregion

		#region Battle Items
		case "X Attack":
		case "X Defense":
		case "X Special Attack":
		case "X Special Defense":
		case "X Speed":

		case "X Attack 2":
		case "X Defense 2":
		case "X Special Attack 2":
		case "X Special Defense 2":
		case "X Speed 2":
			return "Battle Items"
		#endregion

		#region Key Items
		case "Poke Flute":
		case "Skyview Potion":
		case "Skyview Mushroom":
			return "Key Items"
		#endregion
		
		default:
			return "Items"
	}
}

function GetItemDescription(name)
{
	switch (name)
	{
		case "Rare Candy": return "Raises a Pokemon by one level, up to level 100"
		#region Items
		case "Potion":
		case "Super Potion":
		case "Hyper Potion":
			return string_concat("Heals the Pokemon by ", GetHealValue(name), " HP")
		case "Max Potion":
			return "Heals the Pokemon up to full health"
		case "Full Restore":
			return "Heals the Pokemon up to full health and clears statuses"
			
		case "Torch Fuel":
		case "Super Torch Fuel":
		case "Ultra Torch Fuel":
			return string_concat("Restores the torch's power by ", GetHealValue(name)*100, "%")
		case "Field Area Key": return "A mysterious key. It glows with a strange energy. (Use it at any time; see what happens!)"
		#endregion

		#region Balls
		case "Poke Ball":
			return "Has a chance of catching wild Pokemon"
		case "Great Ball":
			return "Has an ok chance of catching wild Pokemon"
		case "Ultra Ball":
			return "Has a good chance of catching wild Pokemon"
		#endregion

		#region Battle Items
		case "X Attack":
		case "X Defense":
		case "X Special Attack":
		case "X Special Defense":
		case "X Speed":
			return "Increases the Pokemon's respective stat by one stage"

		case "X Attack 2":
		case "X Defense 2":
		case "X Special Attack 2":
		case "X Special Defense 2":
		case "X Speed 2":
			return "Increases the Pokemon's respective stat by two stages"
		#endregion

		#region Key Items
		case "Poke Flute":
			return "Can be used to wake sleeping pokemon"
		case "Skyview Mushroom":
			return "An eerie blue mushroom, with a slight glow. Don't eat it!!"
		case "Skyview Potion": 
			return "A potion made from a Skyview Mushroom by Nebogipfel the Morlock. Turns you into a Morlock."
		#endregion
	}
	return ""
}

function GetItemSprite(name)
{
	switch (name)
	{
		//case "Potion":
			//return PotionSprite

        #region Items
        case "Potion": return spr_potion_red
        case "Super Potion": return spr_potion_blue
        case "Hyper Potion": return spr_potion_pink
        case "Max Potion": return spr_potion_purple
        case "Full Restore": return spr_potion_green
        case "Rare Candy": return RareCandySprite
        case "Poke Ball": return PokeballRotateSprite
		case "Great Ball": return GreatBallSprite
		case "Ultra Ball": return UltraBallSprite
        case "Torch Fuel": return TorchSprite
        case "Super Torch Fuel": return TorchSprite
        case "Ultra Torch Fuel": return TorchSprite
        #endregion
		
		#region Key Items
		case "Poke Flute": return PokeFluteSprite
		case "Skyview Mushroom": return MushroomSprite
		case "Skyview Potion": return spr_potion_testtube_blue

        default: return PokeDollarSprite
	}
}

function AddItem(name, amount)
{
// 	if (name == "Potion") show_debug_message("[Inventory] Adding " + string(amount) + " Potion(s) (room " + room_get_name(room) + ")")
	var category = GetItemCategory(name)

	if (category != "")
	{
		var itemDetails = ds_list_create()
		ds_list_add(itemDetails, name, amount)

		var added = false
		var catIndex = ds_list_find_index(global.categoryNameList, category)
		var catList = ds_list_find_value(global.categoryItemList, catIndex)

		for (var i = 0; i < ds_list_size(catList); i++)
		{
			var attempt = ds_list_find_value(catList, i)
			if (GetItemName(attempt) == name)
			{
				UpdateItemAmount(attempt, GetItemAmount(attempt)+amount)
				ds_list_set(catList, i, attempt)
				ds_list_set(global.categoryItemList, catIndex, catList)
				added = true
				break
			}
		}

		if (!added)
		{
			ds_list_add(catList, itemDetails)
			ds_list_set(global.categoryItemList, catIndex, catList)
			added = true
		}
	}
}

function RemoveItem(name, amount)
{
    var category = GetItemCategory(name)

    if (category == "")
        return false

    var catIndex = ds_list_find_index(global.categoryNameList, category)

    if (catIndex < 0)
        return false

    var catList = ds_list_find_value(global.categoryItemList, catIndex)

    for (var i = 0; i < ds_list_size(catList); i++)
    {
        var itemInfo = ds_list_find_value(catList, i)

        if (GetItemName(itemInfo) == name)
        {
            var newAmount = GetItemAmount(itemInfo) - amount

            if (newAmount <= 0)
            {
                ds_list_delete(catList, i)
            }
            else
            {
                UpdateItemAmount(itemInfo, newAmount)
                ds_list_set(catList, i, itemInfo)
            }

            ds_list_set(global.categoryItemList, catIndex, catList)
            return true
        }
    }

    return false
}

function HasItem(itemName)
{
	var category = GetItemCategory(itemName)
	var catIndex = ds_list_find_index(global.categoryNameList, category)
	var catList = ds_list_find_value(global.categoryItemList, catIndex)

	for (var i = 0; i < ds_list_size(catList); i++)
	{
		var attempt = ds_list_find_value(catList, i)
		if (GetItemName(attempt) == itemName)
		{
			return true
		}
	}
	return false
}

function ConsumeItem(categoryIndex, itemIndex, amount)
{
	var itemInfo = GetItemInfo(categoryIndex, itemIndex)
// 	if (GetItemName(itemInfo) == "Potion") show_debug_message("[Inventory] Using " + string(amount) + " Potion(s), stock before use: " + string(GetItemAmount(itemInfo)))
	if (GetItemAmount(itemInfo)-amount <= 0) DeleteItem(categoryIndex, itemIndex)
	else
	{
		UpdateItemAmount(itemInfo, GetItemAmount(itemInfo)-amount)
		ds_list_replace(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex, itemInfo)
	}
}

function IsConsumableItem(itemName)
{
	if (IsBattleItem(itemName)) return true
	if (string_count("Area Key", itemName) > 0) return true
	switch (itemName)
	{
		case "Rare Candy":
		case "Potion":
		case "Super Potion":
		case "Hyper Potion":
		case "Max Potion":
		case "Full Restore":
		case "Torch Fuel":
		case "Super Torch Fuel":
		case "Ultra Torch Fuel":
		case "Skyview Potion":
			return true
	}
	return false
}

function IsBattleItem(itemName)
{
	switch (itemName)
	{
		case "Poke Ball":
		case "Great Ball":
		case "Ultra Ball":

		case "X Attack":
		case "X Defense":
		case "X Special Attack":
		case "X Special Defense":
		case "X Speed":

		case "X Attack 2":
		case "X Defense 2":
		case "X Special Attack 2":
		case "X Special Defense 2":
		case "X Speed 2":
			return true
	}
	return false
}

// Apply party-targeted items before the opponent chooses its response.
function ApplyPokemonItem(team, index, itemName)
{
	var pkmn = ds_list_find_value(team, index)
	if (itemName == "Rare Candy")
	{
		var level = GetLevel(pkmn)
		if (level >= 100)
		{
			GenerateTextPopup(20, 20, "This Pokemon is already level 100.")
			return false
		}
		var name = GetName(pkmn)
		var oldMaxHP = GetPokemonFinalHP(name, level)
		var hp = GetHealth(pkmn)
		AddExp(pkmn, max(0, GetExpLevelFloor(level + 1, GetGrowth(pkmn)) - GetExp(pkmn)), true)
		// Preserve damage taken, while keeping fainted Pokemon fainted.
		if (hp > 0) ds_list_set(pkmn, 5, hp + GetPokemonFinalHP(name, GetLevel(pkmn)) - oldMaxHP)
		var message = string_concat(name, " grew to level ", GetLevel(pkmn), "!")
		var move = LearnsMoveAt(name, GetLevel(pkmn))
		if (move != "" and ds_list_find_index(GetMoves(pkmn), move) == -1)
			message = string_concat(message, " Relearn ", move, " from the Summary menu.")
		GenerateTextPopup(20, 20, message)
	}
	else
	{
		var amount = GetHealValue(itemName)
		if (amount == -1) return false
		HealPokemon(team, index, amount, true, itemName == "Full Restore", false)
	}

	// Only update the selected Pokemon's on-field entity, never a teammate.
	var entity = FindBattlePokemonEntity(pkmn)
	if (entity != noone)
	{
		entity.hp = GetHealth(pkmn)
		entity.status = GetStatus(pkmn)
		if (itemName == "Full Restore")
		{
			entity.toxic = false
			entity.toxicCount = 16
			entity.sleepCounter = 0
		}
		if (itemName == "Rare Candy")
		{
			entity.level = GetLevel(pkmn)
			ds_list_destroy(entity.statList)
			entity.statList = GetPokemonFinalStats(GetName(pkmn), entity.level)
			entity.atk = SetFinalStat(GetAtkStat(entity.statList), entity.attackModifier)
			entity.def = SetFinalStat(GetDefStat(entity.statList), entity.defenseModifier)
			entity.spatk = SetFinalStat(GetSpAtkStat(entity.statList), entity.spAtkModifier)
			entity.spdef = SetFinalStat(GetSpDefStat(entity.statList), entity.spDefModifier)
			entity.spd = SetFinalStat(GetSpeedStat(entity.statList), entity.speedModifier)
		}
	}
	return true
}

function GetHealValue(itemName)
{
	switch (itemName)
	{
		case "Potion":
			return 20
		case "Super Potion":
			return 50
		case "Hyper Potion":
			return 200
		case "Max Potion":
		case "Full Restore":
			return 10000
		case "Torch Fuel":
			return 0.25
		case "Super Torch Fuel":
			return 0.5
		case "Ultra Torch Fuel":
			return 1
	}
	return -1
}

function GetStatItemChange(itemName)
{
	var statChangeList = ds_list_create()
	switch (itemName)
	{
		case "X Attack":
			ds_list_add(statChangeList, "Attack", 1)
			break
		case "X Defense":
			ds_list_add(statChangeList, "Defense", 1)
			break
		case "X Special Attack":
			ds_list_add(statChangeList, "Special Attack", 1)
			break
		case "X Special Defense":
			ds_list_add(statChangeList, "Special Defense", 1)
			break
		case "X Speed":
			ds_list_add(statChangeList, "Speed", 1)
			break

		case "X Attack 2":
			ds_list_add(statChangeList, "Attack", 2)
			break
		case "X Defense 2":
			ds_list_add(statChangeList, "Defense", 2)
			break
		case "X Special Attack 2":
			ds_list_add(statChangeList, "Special Attack", 2)
			break
		case "X Special Defense 2":
			ds_list_add(statChangeList, "Special Defense", 2)
			break
		case "X Speed 2":
			ds_list_add(statChangeList, "Speed", 2)
			break
	}

	if (!ds_list_empty(statChangeList)) return statChangeList
	return -1
}
