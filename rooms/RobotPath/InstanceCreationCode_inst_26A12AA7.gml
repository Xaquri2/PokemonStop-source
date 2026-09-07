// === BATTLE FLAG (auto) BEGIN ===
battleFlag = id;
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

AddPokemonTrainer(trainerTeam, 1, "Box Bot", floor(random_range(8,11)), GetRandomGender(50), BoxBotIdleSprite)

idleSprite = BoxBotIdleSprite
walkUpSprite = BoxBotWalkUpSprite
walkDownSprite = BoxBotWalkDownSprite
walkRightSprite = BoxBotWalkRightSprite

name = "Box Bot";
