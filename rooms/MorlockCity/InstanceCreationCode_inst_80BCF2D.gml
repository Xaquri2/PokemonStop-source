// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_80BCF2D";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "Don't tell the others but... sometimes I think Nebogipfel makes a lot of sense.",
"I know, I know! He's crazy! Total weirdo. I love laughing at him as much as the next guy.",
"But when you get to listening to him... like when you actually think about what he's saying...",
"I mean, don't get me wrong, I don't agree with everything he says. But, I can't deny he makes some good points",
"You know?")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)

