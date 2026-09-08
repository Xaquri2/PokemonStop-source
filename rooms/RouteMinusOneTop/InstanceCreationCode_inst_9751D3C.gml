name = "Charmander"
canWalk = false
battleFlag = id
if HasFlag(battleFlag) {
	instance_destroy(self)
}
AddPokemonTrainer(trainerTeam, 1, "Charmander", floor(random_range(4,8)), GetRandomGender(50), CharmanderBattleSprite)
