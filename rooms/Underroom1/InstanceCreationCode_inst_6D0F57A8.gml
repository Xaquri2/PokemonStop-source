// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Umbrian_Underroom_inst_6D0F57A8";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true
name = "Umbrian"

idleSprite = UmbrianOverworldSprite
walkUpSprite = UmbrianOverworldSprite
walkDownSprite = UmbrianOverworldSprite
walkRightSprite = UmbrianOverworldSprite

AddPokemonTrainer(trainerTeam, 1, "Umbrian", floor(random_range(8,15)), GetRandomGender(50), UmbrianOverworldSprite)
