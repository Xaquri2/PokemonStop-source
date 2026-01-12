// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "DemoDog_MutantPath1_inst_446582CA";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===


AddPokemonTrainer(trainerTeam, 1, "Demo Dog", floor(random_range(8,15)), GetRandomGender(50), DemoDogSprite)

canWalk = true

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

