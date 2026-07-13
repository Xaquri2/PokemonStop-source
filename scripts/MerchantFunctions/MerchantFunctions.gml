function IsMerchant(name)
{
	switch (name)
	{
		case "Test Merchant 1": return true
		case "Test Merchant 2": return true
		case "Orc Merchant 1": return true
		case "Morlockcita": return true
		case "Greed": return true
		case "BoxBotMerchant": return true
	}
	return false
}

function GetMerchantItems(name)
{
	var itemList = ds_list_create()
	switch (name)
	{
		case "Test Merchant 1":
			ds_list_add(itemList, "Potion", "Super Potion", "Hyper Potion", "Max Potion", "Full Restore")
			break
		case "Test Merchant 2":
			ds_list_add(itemList, "Poke Ball", "Great Ball", "Ultra Ball")
			break
		case "Orc Merchant 1":
			ds_list_add(itemList, "Poke Ball", "Potion")
			break
		case "Greed":
			ds_list_add(itemList, "Poke Ball", "Potion", "Rare Candy")
			break
		case "Morlockcita":
			ds_list_add(itemList, "Poke Ball", "Potion", "Rare Candy", "Torch Fuel", "Super Torch Fuel", "Ultra Torch Fuel")
			if HasFlag("GotMushroom") {
				ds_list_add(itemList, "Skyview Mushroom")
			}
			break
		case "BoxBotMerchant":
			ds_list_add(itemList, "Poke Ball", "Potion", "Rare Candy", "Great Ball", "Ultra Ball")
			break
	}
	return itemList
}

function GetItemValue(name)
{
	switch (name)
	{
		case "Skyview Mushroom": return 500
			break
		default: return 100 //To be done
	}
}