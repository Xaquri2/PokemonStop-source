// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_5F4E46C7";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;


ds_list_add(textList, "Ya know, that human coming through here... how'd it get down here?",
"They say humans hate the dark. It couldn't have just wandered in",
"Honestly? I think that's kinda cool, it had the guts to burst in here!",
"Hmm... speaking of human guts, that sounds tasty... if they catch the human, I hope I get to have a piece!",
"The human meat at the restaurant is so stale")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)
