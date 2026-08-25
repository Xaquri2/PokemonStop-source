if (room == RoomBattleGodzilla) depth = 1000000

if (isWild and visible)
{
	var pk = instance_create_layer(x,y,"EnemyPokemon",BattlePokemonObject)
	pk.index = currentPkmn
	pk.team = team
	pk.playerTeam = false
	visible = false
}
if (player == false) {
	if (BattleObject.enemyName == "Mary") {
	    image_xscale = 1.1;
	    image_yscale = 1.1;
	}
	else if (BattleObject.enemyName == "Mary2") {
	    image_xscale = 1.1;
	    image_yscale = 1.1;
	}
}

if (room == RoomBattleGodzilla) sprite_index = noone

if (flash)
{
	if (flashValue < 1) flashValue += 0.05
	else 
	{
		flash = false
		
		#region Pokémon Spawning
		//var pk = instance_create_layer(168,161,"Instances",BattlePokemonObject)
		//if (switchIndex == -1)
		//{
		//	if (player) currentPkmn = GetFirstHealthyPokemon()
		//	pk.index = currentPkmn
		//}
		//else pk.index = switchIndex
		//
		//pk.team = team
		//if (!player) pk.playerTeam = false
		//#endregion
		var spawnIndex;

		if (switchIndex == -1)
		{
		    if (player)
		    {
		        spawnIndex = GetFirstHealthyPokemon();

		        if (spawnIndex != -1)
		        {
		            currentPkmn = spawnIndex;
		        }
		    }
		    else
		    {
		        spawnIndex = currentPkmn;
		    }
		}
		else
		{
		    spawnIndex = switchIndex;
		}
		if (player and (spawnIndex < 0 or spawnIndex >= ds_list_size(team)
			or GetHealth(ds_list_find_value(team, spawnIndex)) <= 0))
		{
			spawnIndex = GetFirstHealthyPokemon();
		}

		if (spawnIndex != -1 && spawnIndex != noone)
		{
		    var pk = instance_create_layer(168, 161, "Instances", BattlePokemonObject);
		    pk.index = spawnIndex;
		    pk.team = team;

		    if (!player)
			{
				pk.playerTeam = false;
			}
			currentPkmn = spawnIndex;
		}
		switchIndex = -1;
		#endregion
	}
}
else
{
	if (flashValue > 0) flashValue -= 0.05
}
