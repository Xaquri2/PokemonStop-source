// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_32AF66B9";

name = Morlock;
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "I am imprisoned here for my crimes against Morlock kind.",
"And so, as my jailers had intended, I am spending my time reflecting on my crimes.",
"It's true: I defiled an image of the Sphinx. I cannot deny this.",
"I had grown weary of its disdainful face, always looking down on us judgementally.",
"I had grown even wearier of my fellow Morlocks showering that face with worship and adoration.",
"Nor can I deny my inappropriate relationship with Gym Leader Gorbertron's wife! Perhaps the real reason I was imprisoned.",
"And yet... as I sit here, receiving the scorn and mockery of every passing Morlock,",
"I find myself unrepentant. The more I reflect, the more justified my actions seem!",
"Perhaps it is not I, but the system, that must change!",
"Perhaps if I am ever made free, I shall become an advocate for prison reform.",
"I believe this form of cruel punishment to be ineffective at rehabilitation!")
ds_list_add(nameList, "Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock","Morlock")
ds_list_add(iconList, sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index,sprite_index)