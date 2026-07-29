// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Squirtle_RouteMinusOneBottom_inst_591FF6F0";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = false

name = "Squirtle"

AddPokemonTrainer(trainerTeam, 1, "Squirtle", floor(random_range(2,5)), GetRandomGender(50), SquirtleIdleSprite)
