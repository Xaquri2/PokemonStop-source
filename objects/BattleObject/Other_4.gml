if (room == RoomBattle)
{
	var floorEnemy = instance_create_layer(room_width*0.7, 
	room_height*0.3, "BattleFloor", BattleFloorObject)
	
	var floorPlayer = instance_create_layer(room_width*0.3, 
	room_height*0.7, "BattleFloor", BattleFloorObject)
	
	floorEnemy.mode = "Enemy"
	floorPlayer.mode = "Player"
	
	floorEnemy.image_xscale = 3
	floorPlayer.image_xscale = 3
}