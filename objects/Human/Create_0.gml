event_inherited()

trainerSprite = Human2IdleSprite //The sprite the pokémon or trainer will use in battle

AddPokemonTrainer(trainerTeam, 1, "Human", floor(random_range(8,15)), GetRandomGender(50), Human2IdleSprite)
//In order: Index in the team, Species, Level, Gender, Pokémon Sprite

depth = 400;