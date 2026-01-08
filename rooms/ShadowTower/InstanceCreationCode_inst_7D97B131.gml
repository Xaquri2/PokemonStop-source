// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "GreenBubble_ShadowTower_inst_7D97B131";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = false

AddPokemonTrainer(trainerTeam, 1, "Green Bubble", floor(random_range(8,15)), GetRandomGender(50), GreenBubbleBattleSprite)
