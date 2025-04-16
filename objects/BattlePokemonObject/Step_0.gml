if (dying)
{
	vspeed = 1
	image_alpha -= 0.05
	if (alarm[2] < 0) alarm[2] = 20
}

if (enableDrawing)
{
	//Need this check cuz Step was running before Alarm 0
	atk = SetFinalStat(GetAtkStat(statList), attackModifier)
	def = SetFinalStat(GetDefStat(statList), attackModifier)
	spatk = SetFinalStat(GetSpAtkStat(statList), attackModifier)
	spdef = SetFinalStat(GetSpDefStat(statList), attackModifier)
	spd = SetFinalStat(GetSpeedStat(statList), attackModifier)
}

//Flashing
if (alarm[3] % 4 == 0) flashMode++
if (flashMode > 1) flashMode = 0