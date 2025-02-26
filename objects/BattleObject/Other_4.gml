if (room == RoomBattle)
{
	alarm[0] = 100
	
	var teamMember =  ds_list_find_value(enemyTeam, 0)
	var teamMemberName = ds_list_find_value(teamMember, 1)
	
	ds_list_add(textList, string_concat(enemyName, " wants to battle"), 
	string_concat(enemyName, " sent out ", teamMemberName))
	
	var floorEnemy = instance_create_layer(room_width*0.7, 
	room_height*0.3, "BattleFloor", BattleFloorObject)
	
	var floorPlayer = instance_create_layer(room_width*0.3, 
	room_height*0.7, "BattleFloor", BattleFloorObject)
	
	floorEnemy.team = enemyTeam
	floorEnemy.trainer = enemySprite
	
	floorPlayer.team = playerTeam
	floorPlayer.trainer = object_get_sprite(PlayerObject)
	
	floorEnemy.image_xscale = 2
	floorPlayer.image_xscale = 2
}