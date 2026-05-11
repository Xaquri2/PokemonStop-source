// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Metroid_MuntainPeak_inst_17307312";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

canWalk = true

AddPokemonTrainer(trainerTeam, 1, "Metroid", floor(random_range(8,15)), GetRandomGender(50), MetroidOverworldSprite)
