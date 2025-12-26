// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity_inst_7898F818";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
