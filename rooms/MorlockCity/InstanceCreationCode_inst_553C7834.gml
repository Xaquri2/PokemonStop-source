// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_553C7834";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Ever wonder what these, like, electric coil things do?",
"Like, think about it, right? That light moves up the coil... that's not just decoration. It's gotta be doing something, right...?",
"I know we're supposed to maintain the machines our ancestors left us... but why, if we don't know what they do?")
ds_list_add(nameList, "Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index)