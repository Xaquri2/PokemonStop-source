// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_6503D2E5";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "Gotta catch 'em all!! ...And eat 'em.")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)