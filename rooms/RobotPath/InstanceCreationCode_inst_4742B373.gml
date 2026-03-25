// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Baby_RobotPath_inst_4742B373";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

AddPokemonTrainer(trainerTeam, 1, "Baby", floor(random_range(8,15)), GetRandomGender(50), BabyBattleSprite)

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

