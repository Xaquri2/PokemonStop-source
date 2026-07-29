// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Apeball_RouteMinusOneTop_inst_68D486B8";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = false
name = "Ape-Ball"

AddPokemonTrainer(trainerTeam, 1, "Ape-Ball", floor(random_range(8,15)), GetRandomGender(50), ApeBallSprite)
