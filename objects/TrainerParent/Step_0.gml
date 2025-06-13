event_inherited();

var player = collision_line(startX,startY,finalX,finalY,PlayerObject,false,true)
if (!triggered and instance_exists(player))
{
	triggered = true
	
	player.talking = false
	player.canWalk = false
	player.battle = true
		
	var battleObj = instance_create_layer(x,y,"Instances",BattleObject)
	battleObj.enemyTeam = teamMembers
	battleObj.enemySprite = sprite_index
	battleObj.enemyName = trainerName
	battleObj.isWild = false
}