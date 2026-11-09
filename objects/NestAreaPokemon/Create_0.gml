event_inherited()

name = GetNestRoomPokemonType(GameObject.areaKeyInfo)
sprite_index = GetSpriteByNumber(GetNumberByName(name))
// Movement and idle transitions must keep this area's selected species.
idleSprite = sprite_index
walkUpSprite = sprite_index
walkDownSprite = sprite_index
walkRightSprite = sprite_index

ds_list_add(textList, "The wild pokémon attacked!")
ds_list_add(iconList, sprite_index)
ds_list_add(nameList, name)

AddPokemonTrainer(trainerTeam, 1, name, 25, "Male", sprite_index)

currentGrassSpot = noone

grassCounter = 0
grassList = ds_list_create()

walkSpeed = 0.4
