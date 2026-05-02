// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_142012D1";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "I can't stop reading MAGNA-MORLOCK comics... so freaking cool!",
"Do you think they'll make a movie of it soon? I mean with so many other superhero movies like Gligarman... maybe it could happen, right?")
ds_list_add(nameList, "Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index)