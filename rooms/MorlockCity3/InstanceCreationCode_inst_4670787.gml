// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "CityMorlock_MorlockCity3_inst_4670787";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
name = "Morlock";
