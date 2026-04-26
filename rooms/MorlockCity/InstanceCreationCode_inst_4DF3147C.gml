// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_4DF3147C";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "I can't wait for my shift to be over...",
"Sigh.",
"All I wanna do is hang out & play the new Human Hunter game. Work, work, work... it never ends!!")
ds_list_add(nameList, "Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index)
