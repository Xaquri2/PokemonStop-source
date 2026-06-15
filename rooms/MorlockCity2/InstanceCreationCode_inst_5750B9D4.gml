// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_5750B9D4";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "Have you met my friend Nebogipfel yet?? He's cool but every word out of his mouth is BONKERS.")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)