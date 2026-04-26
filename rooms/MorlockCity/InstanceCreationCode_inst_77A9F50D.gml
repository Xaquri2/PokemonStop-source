// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_77A9F50D";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "One time, I explored in a weird, deep cavern. You can't get there anymore I don't think",
"Anyway, I met this weird creature... it called itself a C.H.U.D.",
"At first I thought we were gonna get along great... we both love Human Stew for example.",
"But then it turns out he had a problem with Morlocks too! He kept saying weird stuff about my blueness",
"And I kinda think he wanted to eat ME!!",
"What a psycho. That's cannibalism, eating people is messed up!",
"Well, besides humans of course.")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)
