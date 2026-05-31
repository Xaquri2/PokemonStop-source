// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_40807A5E";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "I heard the humans believe in something called 'Outer Space'... you think it exists??",
"If so, I wonder if could be... other beings out there??",
"I mean, I get so tired of eating only human meat; sometimes I want variety, ya know?")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)