// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "BB8_RobotPath_inst_CF23A3B";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

AddPokemonTrainer(trainerTeam, 1, "BB-8", floor(random_range(8,15)), GetRandomGender(50), BB8BattleSprite)

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index
