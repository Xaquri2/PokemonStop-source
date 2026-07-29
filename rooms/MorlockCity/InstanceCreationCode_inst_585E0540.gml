// === BATTLE FLAG (auto) BEGIN ===
if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===
AddPokemonTrainer(trainerTeam, 1, "Morlock", floor(random_range(8,15)), GetRandomGender(50), MorlockBattleSprite)
battleFlag = "TiltedMorlock_MorlockCity_inst_585E0540";

name = "Morlock";
enemyName = "Morlock"
enemyName = Morlock;

ds_list_add(textList, "¡Hola! Soy un Morlockcito de otro país. Nosotros también comemos carne humano!")
ds_list_add(nameList, "Morlock")
ds_list_add(iconList, sprite_index)