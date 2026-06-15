// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "TiltedMorlock_MorlockCity2_inst_5D5F6867";
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
enemyName = Morlock;

ds_list_add(textList, "Um. Asking for a friend. Do you think the Sphinx has a problem with a boy-lock trying to become a girl-lock...?",
"I, uh, heard of some people doing that. They're called Translocks. I... uh, ...",)
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)