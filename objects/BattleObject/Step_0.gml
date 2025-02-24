if (fadingIntro and fadeCount < 4)
{
	if (fadeAlpha < 1 and fadeDir == 1)
	{
		fadeAlpha += 0.12
		if (fadeAlpha >= 1) 
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