pkmnInfo = ds_list_find_value(team, index)
name = GetName(pkmnInfo)
level = GetLevel(pkmnInfo)
status = GetStatus(pkmnInfo)
statList = GetPokemonFinalStats(name, level)

enableDrawing = true
SetPokemonDefaults(ds_list_find_value(team, index))

if (playerTeam)
{
	var battle = instance_find(BattleObject, 0)
	battle.playerPkmn = pkmnInfo
}

image_xscale *= GetBattleXscale(name)
if (playerTeam) image_xscale *= -1

if (sprite_index == GodzillaSprite)
{
	sprite_index = noone
	if (playerTeam) layer_set_visible(layer_get_id("PlayersGodzilla"), true)
	else 
	{
		layer_set_visible(layer_get_id("Godzilla"), true)
	}
}