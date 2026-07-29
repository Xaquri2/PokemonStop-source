// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_29A70610";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "One day, if I keep writing, I'll be a world-famous science fiction writer...")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)
name = "Morlock";
