// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_2AC518DA";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Oh, you're a Pokémon trainer?",
"That's so cool! I wanted to be one when I was a kid! I used to watch all the matches, read the adventure comics...",
"But, you know, it's hard for Morlocks... all the good 'Mons are on the surface, and... well, it's too bright up there. ")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)
