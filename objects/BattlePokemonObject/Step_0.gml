if (dying)
{
	vspeed = 1
	image_alpha -= 0.05
	if (alarm[2] < 0) alarm[2] = 20
}

if (enableDrawing)
{
	//Need this check cuz Step was running before Alarm 0
	atk = GetAtkStat(statList)*(0.5*attackModifier)
	def = GetDefStat(statList)*(0.5*defenseModifier)
	spatk = GetSpAtkStat(statList)*(0.5*spAtkModifier)
	spdef = GetSpDefStat(statList)*(0.5*spDefModifier)
	spd = GetSpeedStat(statList)*(0.5*speedModifier)
}