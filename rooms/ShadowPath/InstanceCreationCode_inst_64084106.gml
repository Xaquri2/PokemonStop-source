// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Yamask_ShadowPath_inst_A8F6732";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

idleSprite = YamaskFrontSprite
walkUpSprite = YamaskBackSprite
walkDownSprite = YamaskFrontSprite
walkRightSprite = YamaskFrontSprite

AddPokemonTrainer(trainerTeam, 1, "Yamask", floor(random_range(8,15)), GetRandomGender(50), YamaskFrontSprite)
name = "Yamask";
