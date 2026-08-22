name = "Enderman";

AddPokemonTrainer(trainerTeam, 1, "Enderman", 5,GetRandomGender(50),EndermanOverworldSprite)
battleFlag = "EndermanFlag"
if HasFlag("EndermanFlag") {
	instance_destroy(id)
}

walkDownSprite = EndermanOverworldSprite
walkUpSprite = EndermanOverworldSprite
walkRightSprite = EndermanOverworldSprite
idleSprite = EndermanOverworldSprite