if (instance_exists(actionNPC))
{
	if (IsMerchant(actionNPC.name))
	{
		var merchantMenu = instance_create_layer(x,y,"UserInterface",MerchantMenuObject)
		merchantMenu.itemList = GetMerchantItems(actionNPC.name)
		merchantMenu.player = instance_find(PlayerObject, 0)
	}

	switch (actionNPC.object_index)
	{
		case Snorlax:
			if (ds_list_empty(actionNPC.trainerTeam))
			{
				var player = instance_find(PlayerObject, 0)
				if (player.alarm[1] > -1) player.alarm[1] = -1
			
				actionNPC.alarm[0] = 5
			}
			break
	}
}