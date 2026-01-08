// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Tektite_MuntainPeak_inst_984B3EF";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

canWalk = false

AddPokemonTrainer(trainerTeam, 1, "Tektite", floor(random_range(8,15)), GetRandomGender(50), TektiteIdleSprite)
