// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_33CEC23E";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "Our technology could be so much more advanced if anyone just took the time to figure out how the machines work")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)
name = "Morlock";
