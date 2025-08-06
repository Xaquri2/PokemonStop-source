if (room == RoomBattle)
{
	alarm[0] = 100
	
	playerPkmn = ds_list_find_value(playerTeam, GetFirstHealthyPokemon())
	var playerTeamMemberName = GetName(playerPkmn)

	enemyPkmn =  ds_list_find_value(enemyTeam, 0)
	var enemyTeamMemberName = GetName(enemyPkmn)
	
	if (isWild) 
	{
		ds_list_add(textList, string_concat("You found a wild ", enemyName), 
		string_concat("Go! ", playerTeamMemberName))
	}
	else 
	{
		ds_list_add(textList, string_concat(enemyName, " wants to battle"), string_concat(enemyName, " sent out ", enemyTeamMemberName), 
		string_concat("Go! ", playerTeamMemberName))
	}
	
	var floorEnemy = instance_create_layer(room_width*0.7, 
	room_height*0.3, "BattleFloor", BattleFloorObject)
	
	var floorPlayer = instance_create_layer(room_width*0.3, 
	room_height*0.7, "BattleFloor", BattleFloorObject)
	
	floorEnemy.team = enemyTeam
	floorEnemy.trainer = enemySprite
	floorEnemy.player = false
	floorEnemy.isWild = isWild
	
	floorPlayer.team = playerTeam
	floorPlayer.trainer = object_get_sprite(PlayerObject)
	
	floorEnemy.image_xscale = 2
	floorPlayer.image_xscale = 2
}
else
{
	if (ending) 
	{
		if (instance_number(PlayerObject) == 0)
		{
			var player = instance_create_layer(playerX, playerY, "Instances", PlayerObject)
			player.x = playerX
			player.y = playerY
		}
		else
		{
			var player = instance_find(PlayerObject, 0)
			player.x = playerX
			player.y = playerY
		}
		
		for (var i = 0; i < instance_number(TrainerParent); i++)
		{
			var attempt = instance_find(TrainerParent, i)
			if (attempt.name == enemyName)
			{
				attempt.x = trainerX
				attempt.y = trainerY
			}
		}
		
		instance_destroy(id)
	}
}