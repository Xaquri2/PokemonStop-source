event_inherited();

var player = collision_line(startX,startY,finalX,finalY,PlayerObject,false,true)
if (!triggered and instance_exists(player))
{
	triggered = true
	
	player.talking = false
	player.canWalk = false
	player.battle = true

	alarm[1] = 60
}

if (walk and instance_exists(player))
{
	switch (lineSightDir)
	{
		case "Right": 
		case "Left":
			targetX = player.x
			targetY = y
			break
		case "Up": 
		case "Down":
			targetX = x
			targetY = player.y
			break
	}
	
	move_towards_point(targetX, targetY, 0.5)
}

if (distance_to_point(targetX, targetY) < 4)
{
	speed = 0
	if (alarm[2] < 0 and instance_number(BattleObject) == 0) alarm[2] = 60
}