var battle = instance_find(BattleObject, 0)

pkmnInfo = ds_list_find_value(team, index)
if (battle.currentPikmin != noone) pkmnInfo = battle.currentPikmin

name = GetName(pkmnInfo)
level = GetLevel(pkmnInfo)
status = GetStatus(pkmnInfo)
statList = GetPokemonFinalStats(name, level)

enableDrawing = true
SetPokemonDefaults(pkmnInfo)

if (playerTeam)
{
	battle.playerPkmn = pkmnInfo
}

image_xscale *= GetBattleXscale(name)
image_yscale *= GetBattleYscale(name)
if (playerTeam) image_xscale *= -1

if (room == RoomBattleGodzilla) {
	if (sprite_index == GodzillaSprite)
	{
		sprite_index = noone
		if (playerTeam) layer_set_visible(layer_get_id("PlayersGodzilla"), true)
		else 
		{
			layer_set_visible(layer_get_id("Godzilla"), true)
		}
	}
}

if (ds_list_find_index(battle.battleParticipants, pkmnInfo) != undefined) ds_list_add(battle.battleParticipants, pkmnInfo)