if (room == RoomBattle)
{
	alarm[0] = 100
	
	playerPkmn = GetFirstHealthyPokemon(playerTeam)
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
	if (ending) instance_destroy(id)
}