// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "ZooChomper_MuntainPeak_inst_25619B8E";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

canWalk = true

AddPokemonTrainer(trainerTeam, 1, "ZooChomper", floor(random_range(8,15)), GetRandomGender(50), ZoochomperBattleSprite)
name = "ZooChomper";
