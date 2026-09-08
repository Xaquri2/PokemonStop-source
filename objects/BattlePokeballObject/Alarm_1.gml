var pkmnLayer = "Pokemon"
if (!entity.player) pkmnLayer = "EnemyPokemon"

var spawnIndex = entity.switchIndex
if (entity.player)
{
	if (spawnIndex < 0 or spawnIndex >= ds_list_size(entity.team)
		or GetHealth(ds_list_find_value(entity.team, spawnIndex)) <= 0)
	{
		spawnIndex = GetFirstHealthyPokemon()
	}
}
else if (spawnIndex == -1)
{
	spawnIndex = entity.currentPkmn
}

if (spawnIndex >= 0 and spawnIndex < ds_list_size(entity.team))
{
	// A skipped faint event can leave the previous on-field object behind.
	// Remove only stale Pokemon from the side this ball is about to replace so
	// its sprite and status panel cannot overlap the newly spawned Pokemon.
	for (var i = instance_number(BattlePokemonObject)-1; i >= 0; i--)
	{
		var existingPkmn = instance_find(BattlePokemonObject, i)
		if (existingPkmn.playerTeam == entity.player)
		{
			instance_destroy(existingPkmn)
		}
	}

	var pk = instance_create_layer(x,y,pkmnLayer,BattlePokemonObject)
	pk.index = spawnIndex
	pk.team = entity.team
	if (!entity.player) pk.playerTeam = false
	entity.currentPkmn = spawnIndex
}

// switchIndex is only a pending manual-switch request, not persistent state.
entity.switchIndex = -1

instance_destroy(id)
