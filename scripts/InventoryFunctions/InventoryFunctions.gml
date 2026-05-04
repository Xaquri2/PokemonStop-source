//Items are stored in lists, with the data being in the following order: Name, Amount.
function GetItemInfo(categoryIndex, itemIndex) { return ds_list_find_value(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex) }
function GetItemName(itemInfo) { return ds_list_find_value(itemInfo, 0) }
function GetItemAmount(itemInfo) { return ds_list_find_value(itemInfo, 1) }
function UpdateItemAmount(itemInfo, amount) { ds_list_set(itemInfo, 1, amount) }
function DeleteItem(categoryIndex, itemIndex) { ds_list_delete(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex) }

function GetItemCategory(name)
{
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
			return "Key Items"
		#endregion
	}
	return ""
}

function GetItemDescription(name)
{
	switch (name)
	{
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
		case "Skyview Potion": 
			return "A potion made from a Skyview Mushroom by Nebogipfel the Morlock. Turns you into a Morlock."
		#endregion
	}
	return ""
}

function AddItem(name, amount)
{
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
	switch (itemName)
	{
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
