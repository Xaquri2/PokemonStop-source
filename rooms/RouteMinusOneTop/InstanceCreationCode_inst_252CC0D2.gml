// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Koopa_inst_252CC0D2";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===


AddPokemonTrainer(trainerTeam, 1, "Koopa", floor(random_range(8,15)), GetRandomGender(50), KoopaWalkRightSprite)

canWalk = false

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index