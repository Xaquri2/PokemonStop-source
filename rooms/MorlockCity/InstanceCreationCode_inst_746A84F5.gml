// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_746A84F5";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Would you care to stop by later? We're having a Sphinx Devotional gathering. We'll discuss why it's important to all Morlock kind")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)