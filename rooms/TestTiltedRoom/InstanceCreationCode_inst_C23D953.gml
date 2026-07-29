AddPokemonTrainer(trainerTeam, 1, "Licker", floor(random_range(8,15)), GetRandomGender(50), LickerOverworldSprite)

battleFlag = "TiltedLicker"
if (HasFlag("TiltedLicker")) instance_destroy(id)

canWalk = false

idleSprite = sprite_index
walkRightSprite = sprite_index
walkDownSprite = sprite_index
walkUpSprite = sprite_index
name = "Licker";
