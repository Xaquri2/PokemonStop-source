if (room != RoomBattle)
{
	if (fadingIntro and fadeCount < 5)
	{
		if (fadeAlpha < 1 and fadeDir == 1)
		{
			if (fadeCount < 4) fadeAlpha += 0.12
			else
			{
				fadeAlpha += 0.02
				if (fadeAlpha >= 1)
				{
					room_goto(RoomBattle)
				}
			}
			if (fadeAlpha >= 1 and fadeCount < 4)
			{
				fadeDir = 0
			}
		}
		if (fadeAlpha > 0 and fadeDir == 0)
		{
			fadeAlpha -= 0.12
			if (fadeAlpha <= 0)
			{
				fadeCount++
				fadeDir = 1
			}
		}
	}
}
else
{
	if (ending)
	{
		if (fadeAlpha < 1) fadeAlpha += 0.05
		else room_goto(playerRoom)
	}
	if (topRectValue-5 > 0)
	{
		topRectValue -= 5
	}
	else topRectValue = 0
}
