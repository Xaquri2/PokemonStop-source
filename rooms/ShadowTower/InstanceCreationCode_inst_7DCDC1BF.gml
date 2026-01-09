// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Umbrian_ShadowTower_inst_7DCDC1BF";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

idleSprite = UmbrianOverworldSprite
walkUpSprite = UmbrianOverworldSprite
walkDownSprite = UmbrianOverworldSprite
walkrightSprite = UmbrianOverworldSprite
walkRightSprite = UmbrianOverworldSprite

AddPokemonTrainer(trainerTeam, 1, "Umbrian", floor(random_range(8,15)), GetRandomGender(50), UmbrianOverworldSprite)
