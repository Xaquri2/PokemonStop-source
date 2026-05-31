// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_595300A9";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Don't forget to thank the Sphinx every morning for this beautiful underground city we live in!")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)