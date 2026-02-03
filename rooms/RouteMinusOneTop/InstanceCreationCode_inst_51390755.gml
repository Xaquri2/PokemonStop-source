AddPokemonTrainer(trainerTeam, 1, "Tektite", floor(random_range(6,12)), GetRandomGender(50), TektiteIdleSprite)

// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Tektite_MinusOneTop_inst_51390755";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

canWalk = false