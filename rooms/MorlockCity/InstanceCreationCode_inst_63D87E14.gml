// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_63D87E14";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "I'm trying to train my brain every day! My goal is to one day become the next UBER-MORLOCK...!",
"I'm trying to do 200 logic puzzles a day... if my brain gets big enough, then maybe...")
ds_list_add(nameList, "Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index)
