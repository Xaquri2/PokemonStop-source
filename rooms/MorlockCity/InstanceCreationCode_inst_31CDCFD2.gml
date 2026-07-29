// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_31CDCFD2";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Man, with everything going on in the world... things are scary these days.",
"I try to remember the Sphinx is watching over us... I truly believe she cares for all Morlock kind.")
ds_list_add(nameList, "Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index)