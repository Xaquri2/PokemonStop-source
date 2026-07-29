// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Boo_ShadowTower_inst_6C95E354";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Boo", floor(random_range(8,15)), GetRandomGender(50), BooOverworldSprite)

canWalk = true 

idleSprite = BooOverworldSprite
walkUpSprite = BooOverworldSprite
walkDownSprite = BooOverworldSprite
walkRightSprite = BooOverworldSprite 
name = "Boo";
