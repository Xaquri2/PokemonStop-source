// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_4DDE9AFE";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Dude! The craziest thing happened today!",
"I was hangin' out here by the entrance and WHAM, a HUMAN runs past me!!",
"It got away before I could do anything...",
"It smelled so delicious, made me hungry. Maybe I should stop by the restaurant later?")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, MorlockOverworldSprite,MorlockOverworldSprite,MorlockOverworldSprite,MorlockOverworldSprite)
