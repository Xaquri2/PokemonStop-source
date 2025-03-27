if (dying)
{
	vspeed = 1
	image_alpha -= 0.05
	if (alarm[2] < 0) alarm[2] = 20
}

atk = GetAtkStat(GetPokemonFinalStats(name, level))*(0.5*attackModifier)
def = GetDefStat(GetPokemonFinalStats(name, level))*(0.5*defenseModifier)
spatk = GetSpAtkStat(GetPokemonFinalStats(name, level))*(0.5*spAtkModifier)
spdef = GetSpDefStat(GetPokemonFinalStats(name, level))*(0.5*spDefModifier)
spd = GetSpeedStat(GetPokemonFinalStats(name, level))*(0.5*speedModifier)