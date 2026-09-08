mode = "Choosing"
currentOption = 0

playerPkmn = noone
enemyPkmn = noone
for (var i = 0; i < instance_number(BattlePokemonObject); i++)
{
	var attempt = instance_find(BattlePokemonObject, i)
	if (!attempt.playerTeam) enemyPkmn = attempt
	else playerPkmn = attempt
}

mainOptionsList = ds_list_create()
ds_list_add(mainOptionsList, "Fight", "Bag", "Team", "Run")

optionsList = mainOptionsList
