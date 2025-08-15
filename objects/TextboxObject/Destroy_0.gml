if (IsMerchant(actionNPC.name))
{
	var merchantMenu = instance_create_layer(x,y,"UserInterface",MerchantMenuObject)
	merchantMenu.itemList = GetMerchantItems(actionNPC.name)
	merchantMenu.player = instance_find(PlayerObject, 0)
}