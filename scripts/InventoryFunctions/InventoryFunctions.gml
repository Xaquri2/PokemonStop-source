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
	switch (itemName)
	{
		case "Potion":
		case "Super Potion":
		case "Hyper Potion":
		case "Max Potion":
		case "Full Restore":
		
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

function IsBattleItem(itemName)
{
	switch (itemName)
	{
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