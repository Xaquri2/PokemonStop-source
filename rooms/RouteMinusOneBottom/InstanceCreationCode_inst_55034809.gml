// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Zoombini_RouteMinusOneBottom_inst_55034809";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===


canWalk = false

AddPokemonTrainer(trainerTeam, 1, "Zoombini", floor(random_range(1,5)), GetRandomGender(50), ZoombiniHoveringSprite)
