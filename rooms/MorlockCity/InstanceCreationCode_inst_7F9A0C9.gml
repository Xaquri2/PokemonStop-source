// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_7F9A0C9";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Those glowing power coils ... so bright ... so mysterious. They weren't built by Morlocks you know... Who built them??")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)

