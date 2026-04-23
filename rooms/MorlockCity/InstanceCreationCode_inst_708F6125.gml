// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_708F6125";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "*sniff* *sniff* You smell like human",
"...",
"Um. Okay, this is weird, but. I've always, kind of, you know...",
"Wondered what it was like to... well, you know, to uhm.",
"...",
"To d-d-date a human.",
"Don't look at me like that! I know it's wrong to date your food!",
"But, uhm. I mean, I know you're a Morlock and all but.",
"Like if you were some kind of human transformed into a Morlock or whatever,",
"I wouldn't tell anyone. And we could maybe, I dunno, g-g-get some lunch or something.",
"And I would promise not to eat you!",
"(Oh Sphinx, I just made it weird, didn't I?)")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)