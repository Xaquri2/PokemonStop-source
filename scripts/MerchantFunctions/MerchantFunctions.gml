function IsMerchant(name)
{
	switch (name)
	{
		case "Test Merchant 1": return true
		case "Test Merchant 2": return true
		case "Orc Merchant 1": return true
	}
	return false
}

function GetMerchantItems(name)
{
	var itemList = ds_list_create()
	switch (name)
	{
		case "Test Merchant 1":
			ds_list_add(itemList, "Potion", "Super Potion", "Hyper Potion", "Max Potion")
			break
		case "Test Merchant 2":
			ds_list_add(itemList, "Poke Ball", "Great Ball", "Ultra Ball")
			break
		case "Orc Merchant 1":
			ds_list_add(itemList, "Poke Ball")
			break
	}
	return itemList
}

function GetItemValue(name)
{
	return 100 //To be done
}