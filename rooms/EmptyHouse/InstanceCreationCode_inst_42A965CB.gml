// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Umbrian_EmptyHouse_inst_42A965CB";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===


AddPokemonTrainer(trainerTeam, 1, "Umbrian", floor(random_range(8,15)), GetRandomGender(50), UmbrianOverworldSprite)

canWalk = true

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index
