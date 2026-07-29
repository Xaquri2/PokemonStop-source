// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_63E108E8";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "Man, as soon as I get home, I'm collapsing. Maintaining those machines takes it out of ya!")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)
name = "Morlock";
