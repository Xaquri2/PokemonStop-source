function GetMorlockShopkeeperGreeting()
{
	if ((HasFlag("Potion") and !HasFlag("PotionCure")) or global.morlockTimer > 0)
		return "Hey cutie!! What can I getcha??"
	return "Hssss!!"
}

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
			ds_list_add(itemList, "Hyper Potion", "Max Potion", "Full Restore",
				"X Attack 2", "X Defense 2", "X Special Attack 2", "X Special Defense 2", "X Speed 2")
			break
		case "Morlockcita":
			ds_list_add(itemList, "Poke Ball", "Potion", "Rare Candy", "Torch Fuel", "Super Torch Fuel", "Ultra Torch Fuel")
			ds_list_add(itemList, "X Attack", "X Defense")
			if HasFlag("GotMushroom") {
				ds_list_add(itemList, "Skyview Mushroom")
			}
			break
		case "BoxBotMerchant":
			ds_list_add(itemList, "Poke Ball", "Potion", "Rare Candy", "Great Ball", "Ultra Ball")
			ds_list_add(itemList, "Super Potion", "Hyper Potion",
				"X Special Attack", "X Special Defense", "X Speed")
			break
	}
	return itemList
}

function GetItemValue(name)
{
	switch (name)
	{
		case "Potion":
		case "Poke Ball":
		case "Torch Fuel":
			return 100
		case "Super Potion":
		case "Great Ball":
		case "Ultra Torch Fuel":
			return 300
		case "Hyper Potion":
			return 700
		case "Max Potion":
			return 1200
		case "Full Restore":
		case "Rare Candy":
			return 1500
		case "Ultra Ball":
			return 600
		case "Super Torch Fuel":
			return 180
		case "X Attack":
		case "X Defense":
		case "X Special Attack":
		case "X Special Defense":
		case "X Speed":
			return 200
		case "X Attack 2":
		case "X Defense 2":
		case "X Special Attack 2":
		case "X Special Defense 2":
		case "X Speed 2":
		case "Skyview Mushroom":
			return 500
		case "Poke Flute":
		case "Skyview Potion":
			return 1000
		case "Test Area Key":
		case "Field Area Key":
			return 2000
		case "Moltres Area Key":
		case "Zapdos Area Key":
		case "Rancor Area Key":
			return 5000
		default: return 100
	}
}
