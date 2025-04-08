if (dying)
{
	vspeed = 1
	image_alpha -= 0.05
	if (alarm[2] < 0) alarm[2] = 20
}

if (enableDrawing)
{
	//Need this check cuz Step was running before Alarm 0
	
	//I need to figure out another way to calculate the final stat
	//Maybe a preset determination taking into account the modifier
	
	//e.g attackModifier of 1 multiplies it by 1.25, and 2 multiplies by 1.5
	//e.g attackModifier of -1 multiplies it by 0.75, and -2 multiplies by 0.5
	
	atk = SetFinalStat(GetAtkStat(statList), attackModifier)
	def = SetFinalStat(GetDefStat(statList), attackModifier)
	spatk = SetFinalStat(GetSpAtkStat(statList), attackModifier)
	spdef = SetFinalStat(GetSpDefStat(statList), attackModifier)
	spd = SetFinalStat(GetSpeedStat(statList), attackModifier)
}

//Flashing
if (alarm[3] % 5 == 0) flashMode++
if (flashMode > 1) flashMode = 0