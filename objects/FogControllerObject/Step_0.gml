if (spawnRangeDirection > 0)
{
	if (spawnRangeIncrement < 2) spawnRangeIncrement += 0.05
	
	spawnOffset += spawnRangeIncrement
	if (spawnOffset > 100) spawnRangeDirection *= -1
}
else
{
	if (spawnRangeIncrement > -2) spawnRangeIncrement -= 0.05
	
	spawnOffset += spawnRangeIncrement
	if (spawnOffset <= 0) spawnRangeDirection *= -1
}