event_inherited()

trainerSprite = Human2IdleSprite //The sprite the pokémon or trainer will use in battle

AddPokemonTrainer(trainerTeam, 1, "Human", floor(random_range(4,6)), GetRandomGender(50), Human2IdleSprite)
//In order: Index in the team, Species, Level, Gender, Pokémon Sprite

if (room == MorlockCity2) 
{
	battle = true
	ds_list_add(textList, "The human attacks!")
}

depth = 400;