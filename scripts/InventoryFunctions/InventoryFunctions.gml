//Items are stored in lists, with the data being in the following order: Name, Amount.
function GetItemInfo(categoryIndex, itemIndex) { return ds_list_find_value(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex) }
function GetItemName(itemInfo) { return ds_list_find_value(itemInfo, 0) }
function GetItemAmount(itemInfo) { return ds_list_find_value(itemInfo, 1) }
function UpdateItemAmount(itemInfo, amount) { ds_list_set(itemInfo, 1, amount) }
function DeleteItem(categoryIndex, itemIndex) { ds_list_delete(ds_list_find_value(global.categoryItemList, categoryIndex), itemIndex) }

function AddItem(name, amount)
{
	var itemDetails = ds_list_create()
	ds_list_add(itemDetails, name, amount)
	
	switch (name)
	{
		//Items Category
		case "Potion":
		case "Super Potion":
		case "Hyper Potion":
		case "Max Potion":
		case "Full Restore":
			var added = false
			var catIndex = ds_list_find_index(global.categoryNameList, "Items")
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
			break
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