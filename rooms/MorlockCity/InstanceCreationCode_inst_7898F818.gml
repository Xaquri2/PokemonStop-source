// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_7898F818";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Look, don't tell anyone, but humans FREAK ME THE EFF OUT.",
"Those weird little eyes, staring at you...","And that creepy skin of various non-blue colors!",
"The stuff of nightmares. *shivers*","Ugh, I hate guard duty...")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, MorlockOverworldSprite,MorlockOverworldSprite,MorlockOverworldSprite,MorlockOverworldSprite,MorlockOverworldSprite,)