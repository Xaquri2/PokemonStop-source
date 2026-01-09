// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Umbrian_ShadowTower_inst_3AEF71A0";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

idleSprite = UmbrianOverworldSprite
walkUpSprite = UmbrianOverworldSprite
walkLeftSprite = UmbrianOverworldSprite
walkrightSprite = UmbrianOverworldSprite

AddPokemonTrainer(trainerTeam, 1, "Umbrian", floor(random_range(8,15)), GetRandomGender(50), UmbrianOverworldSprite)
