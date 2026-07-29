// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_3F0080FC";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "My kid's into MAGNA-MORLOCK comics. Ugh, they've run out of ideas, they're not even trying anymore.")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)
