AddPokemonTrainer(trainerTeam, 1, "Licker", 9, GetRandomGender(50), LickerOverworldSprite)

battleFlag = "TiltedLicker"
if (HasFlag("TiltedLicker")) instance_destroy(id)

canWalk = false

idleSprite = sprite_index
walkRightSprite = sprite_index
walkDownSprite = sprite_index
walkUpSprite = sprite_index
name = "Licker";
