SetPokemonDefaults(ds_list_find_value(team, index))
enableDrawing = true

pkmnInfo = ds_list_find_value(team, index)
name = GetName(pkmnInfo)
level = GetLevel(pkmnInfo)
statList = GetPokemonFinalStats(name, level)