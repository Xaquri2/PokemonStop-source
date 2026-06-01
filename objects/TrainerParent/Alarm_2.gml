//if (room == RoomBattleGodzilla) {
//	CurrentLayer = "Cutscene"
//}
//else {
//	CurrentLayer = "Instances"
//}
var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
battleObj.enemyTeam = teamMembers
battleObj.enemySprite = sprite_index
battleObj.enemyName = trainerName
battleObj.isWild = false