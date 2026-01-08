// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Umbreon_ShadowPath_inst_BCB275C";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = false
AddPokemonTrainer(trainerTeam, 1, "Umbreon", floor(random_range(8,15)), GetRandomGender(50), UmbreonOverworldSprite)
