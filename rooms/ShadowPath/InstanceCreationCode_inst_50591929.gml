// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "PacGhost_ShadowPath_inst_50591929";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = false

AddPokemonTrainer(trainerTeam, 1, "Pac-Ghost", floor(random_range(8,15)), GetRandomGender(50), PacGhostOverworldSprite)
