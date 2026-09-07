canWalk = true

AddPokemonTrainer(trainerTeam, 1, "Goomba", floor(random_range(1,5)), GetRandomGender(50), GoombaOverworldSprite)

name = "Goomba"

battleFlag = id
if HasFlag(battleFlag) {
	instance_destroy(self)
}

idleSprite = sprite_index
walkRightSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index

