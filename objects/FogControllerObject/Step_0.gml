if (spawnRangeDirection > 0)
{
	if (spawnRangeIncrement < 2) spawnRangeIncrement += 0.05
	
	spawnRange += spawnRangeIncrement
	if (spawnRange > 300) spawnRangeDirection *= -1
}
else
{
	if (spawnRangeIncrement > -2) spawnRangeIncrement -= 0.05
	
	spawnRange += spawnRangeIncrement
	if (spawnRange < 200) spawnRangeDirection *= -1
}