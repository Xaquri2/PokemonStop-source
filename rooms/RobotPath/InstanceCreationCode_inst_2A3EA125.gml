// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Voltorb_RobotPath_inst_2A3EA125";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

idleSprite = VoltorbOverworldSprite
walkUpSprite = VoltorbOverworldSprite
walkDownSprite = VoltorbOverworldSprite
walkRightSprite = VoltorbOverworldSprite

canWalk = false

AddPokemonTrainer(trainerTeam, 1, "Voltorb", floor(random_range(8,15)), GetRandomGender(50), VoltorbOverworldSprite)
