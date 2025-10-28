function GetWalkingCoords()
{
	var checkX1 = -1
	var checkX2 = -1
	var checkY1 = -1
	var checkY2 = -1
	
	while (checkX1 == -1)
	{
		var attempt = [random_range(x-50,x+50), random_range(y-50, y+50)]
		if (attempt[1] > y) 
		{
			checkY1 = bbox_top
			checkY2 = attempt[1]+sprite_height/2
		}
		else 
		{
			checkY1 = bbox_bottom
			checkY2 = attempt[1]-sprite_height/2
		}
	
		if (attempt[0] > x) 
		{
			checkX1 = bbox_left
			checkX2 = attempt[0]+sprite_width/2
		}
		else 
		{
			checkX1 = bbox_right
			checkX2 = attempt[0]-sprite_width/2
		}
	
		if (instance_exists(collision_rectangle(checkX1, checkY1, 
		checkX2, checkY2, CollisionObject, false, true)))
		{
			checkX1 = -1
		}
		else return [attempt[0], attempt[1]]
	}
}

function GetBattleTheme(name)
{
	switch (name)
	{
		//case "Rival Trainer Name": return RivalTheme
		
		default: return WildBattleTheme
	}
}