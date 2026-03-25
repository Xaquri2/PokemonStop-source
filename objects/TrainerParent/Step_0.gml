event_inherited();

if (!triggered)
{
	startX = bbox_left
	startY = bbox_top
	finalX = bbox_right
	finalY = bbox_bottom
	
	switch (lineSightDir)
	{
		case "Up":
			startY -= lineSight
			break
		case "Down":
			finalY += lineSight
			break
		case "Right":
			finalX += lineSight
			break
		case "Left":
			startX -= lineSight
			break
	}
}

if (sightTrigger)
{
	var player = collision_line(startX,startY,finalX,finalY,PlayerObject,false,true)
	if (!triggered and instance_exists(player) and ds_list_find_index(global.beatenTrainers, name) == -1)
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
				targetX = player.bbox_right
				targetY = y
				break
			case "Left":
				targetX = player.bbox_left
				targetY = y
				break
			case "Up":
				targetX = x
				targetY = player.bbox_top
				break
			case "Down":
				targetX = x
				targetY = player.bbox_bottom
				break
		}

		speed = 0
		hspeed = lengthdir_x(0.5, point_direction(x,y,targetX,targetY))
		vspeed = lengthdir_y(0.5, point_direction(x,y,targetX,targetY))

		if (RoomHasGravity())
		{
			if (vspeed < 3) vspeed += 1.5
		}
	}

	var nextX = lengthdir_x(0.5, point_direction(x,y,targetX,targetY))
	var nextY = lengthdir_y(0.5, point_direction(x,y,targetX,targetY))

	if (distance_to_point(targetX, targetY) < 4 or
	instance_exists(collision_rectangle(bbox_left+nextX,bbox_top+nextY,
	bbox_right+nextX,bbox_bottom+nextY,PlayerObject,false,true)))
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
}