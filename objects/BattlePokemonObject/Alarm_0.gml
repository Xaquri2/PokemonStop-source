pkmnInfo = ds_list_find_value(team, index)
name = GetName(pkmnInfo)
level = GetLevel(pkmnInfo)
statList = GetPokemonFinalStats(name, level)

enableDrawing = true
SetPokemonDefaults(ds_list_find_value(team, index))

if (playerTeam)
{
	var battle = instance_find(BattleObject, 0)
	battle.playerPkmn = pkmnInfo
}