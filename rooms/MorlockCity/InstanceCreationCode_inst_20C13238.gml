AddPokemonTrainer(trainerTeam, 1, "Zubat", floor(random_range(8,15)), GetRandomGender(50), ZubatFlappingSprite)
battleFlag = "inst_20C13238"
if HasFlag("inst_20C13238") {
	instance_destroy(self)
}
name = "Zubat"