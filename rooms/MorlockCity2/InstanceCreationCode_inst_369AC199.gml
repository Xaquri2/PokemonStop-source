// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_369AC199";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(2,3)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "When I grow up, I'll get into politics & get rid of this corrupt, Sphinx-devoted system!")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)
name = "Morlock";
