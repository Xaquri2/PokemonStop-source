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