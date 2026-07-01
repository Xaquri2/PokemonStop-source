event_inherited()

name = GetNestRoomPokemonType(GameObject.areaKeyInfo)
sprite_index = GetSpriteByNumber(GetNumberByName(name))

ds_list_add(textList, "The wild pokémon attacked!")
ds_list_add(iconList, sprite_index)
ds_list_add(nameList, name)

AddPokemonTrainer(trainerTeam, 1, name, 25, "Male", sprite_index)

currentGrassSpot = noone