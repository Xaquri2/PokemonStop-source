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
	if (!dialogueStart) 
	{
		dialogueStart = true
		
		var dialogue = instance_create_depth(x,y,-9999999999999,TextboxObject)
		dialogue.textList = textList
		dialogue.iconList = iconList
		dialogue.nameList = nameList
		
		dialogue.name = name
		dialogue.actionNPC = id
		dialogue.startBattle = true
		if (ds_list_empty(dialogue.textList)) instance_destroy(dialogue)
	}
}