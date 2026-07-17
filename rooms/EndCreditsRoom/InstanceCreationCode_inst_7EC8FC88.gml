// === BATTLE FLAG (auto) BEGIN ===
battleFlag = "Caterpie_RouteMinusOneBottom_inst_1580ED07";
//if (HasFlag(battleFlag)) instance_destroy();
// === BATTLE FLAG (auto) END ===

canWalk = true

idleSprite = sprite_index
walkRightSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index

AddPokemonTrainer(trainerTeam, 1, "Caterpie", floor(random_range(1,3)), GetRandomGender(50), CaterpieIdleSprite)
