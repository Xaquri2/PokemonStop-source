// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_43309F0F";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Wait, ... are you coming from Nebogipfel's place?",
"What are you doing with that guy?",
"You're not listening to his garbage philosophical rantings, are you??")
ds_list_add(nameList, "Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index)
