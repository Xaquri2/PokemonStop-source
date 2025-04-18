//Items are stored in lists, with the data being in the following order: Name, Amount.
function GetItemName(itemInfo) { return ds_list_find_value(itemInfo, 0) }
function GetItemAmount(itemInfo) { return ds_list_find_value(itemInfo, 1) }
function UpdateItemAmount(itemInfo, amount) { ds_list_set(itemInfo, 1, amount) }

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