name = "Koopa"

// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Koopa_inst_252CC0D7";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===


AddPokemonTrainer(trainerTeam, 1, "Koopa", floor(random_range(6,10)), GetRandomGender(50), KoopaWalkRightSprite)

canWalk = false

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index