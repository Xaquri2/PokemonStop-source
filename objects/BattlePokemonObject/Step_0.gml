if (dying) //Move down and fade away
{
	vspeed = 1
	image_alpha -= 0.05
	if (alarm[2] < 0) alarm[2] = 20
}

if (switching) //Scale down
{
	if (image_xscale > 0)
	{
		image_xscale -= 0.05
		image_yscale -= 0.05
	}
	else
	{
		if (alarm[4] == -1) alarm[4] = 30
	}
}

if (enableDrawing) //Get final stats
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

if (catchEffect and catchEffectAlpha > 0) catchEffectAlpha -= 0.05
