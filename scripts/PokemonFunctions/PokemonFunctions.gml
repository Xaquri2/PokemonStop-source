/// @param {string}   name    The name of the Pokémon being added
/// @param {real}     level   The level of the Pokémon being added
/// @param {string}   gender  The name of the Pokémon being added
/// @param {asset}    sprite  The sprite of the Pokémon being added
/// @description              Adds a Pokémon to the player's party with the provided information, with all of it being stored inside a DS list. Added Pokémon are always added with 100% of their health.
function AddPokemon(name, level, gender, sprite) {
	var pokemon = ds_list_create()
	ds_list_add(pokemon, global.catchIndex, name, level, gender, sprite, 100)
	ds_list_add(global.pokemonList, pokemon)
	global.catchIndex++
	
	if (ds_list_size(global.playerParty) < 6)
	{
		ds_list_add(global.playerParty, pokemon)
	}
}

function AddPokemonTrainer(team, index, name, level, gender, sprite) {
	var pokemon = ds_list_create()
	ds_list_add(pokemon, index, name, level, gender, sprite, 100)
	
	if (ds_list_size(team) < 6)
	{
		ds_list_add(team, pokemon)
	}
}

/// @param {string}   index   The position of the Pokémon in the party to retreive info about
/// @param {string}   team    The party to search for the Pokémon at the given position in
/// @description              Returns a list with the information of the given Pokémon, using its index in the party as an identifier, in the following order: Index, Name, Level, Gender, Sprite.
function GetPartyMemberInfo(index) {
	return ds_list_find_value(global.playerParty, index)
}

/// @param {string}   index   The position of the Pokémon in the party to retreive info about
/// @description              Checks if the given party member can evolve, by checking its species, its level and the species' evolution requirements
function CanEvolve(index) {
	var pokemon = GetPartyMemberInfo(index)
	var species = ds_list_find_value(pokemon, 1)
	var level = ds_list_find_value(pokemon, 2)
	
	switch (species)
    {
        //--------------------------------
        // Official Pokémon (where known)
        //--------------------------------
        case "Pikachu":
            // As in your snippet
            break;
            
        case "Voltorb":
            // Canonical Gen 1 base stats
            break;
            
        case "Caterpie":
			if (level >= 10) return true
            
        case "Magnemite":
            break;
            
        case "Butterfree":
            break;
            
        case "Charmander":
            // As in your snippet
			if (level >= 16) return true
            
        case "Charmeleon":
            if (level >= 36) return true
            
        case "Charizard":
            break;
            
        case "Clefairy":
            break;
            
        case "Squirtle":
            if (level >= 16) return true
            
        case "Wartortle":
            if (level >= 36) return true
            
        case "Blastoise":
            break;
            
        case "Snorlax":
            // As in your snippet
            break;
            
        case "MissingNo":
            // “Glitchy” stats, just for fun
            break;
            
        case "Articuno":
            break;
            
        case "Moltres":
            break;
            
        case "Zapdos":
            break;
            
        case "Yamask":
            break;
            
        // “Shadow Umbreon” – slight twist on normal Umbreon’s stats
        case "Umbreon (Shadow Version)":
            break;
            
        case "Zubat":
            break;
        
        //------------------------------
        // Fan/Crossover Pokémon
        //------------------------------
        case "Envy":
            // Aquatic shadow Pokémon, envious spirit
            break;
            
        case "Ape-Ball":
            // Extremely fast and deadly
            break;
            
        case "Woob-Wub":
            // The unluckiest Pokémon, extremely fragile
            break;
            
        case "Fig":
            // Docile, self-sacrificing
            break;
            
        case "Umbrian":
            // Shadow Pokémon, mask-bound
            break;
            
        case "Caelian":
            // Light counterpart to Umbrian
            break;
            
        case "Baby (Tutorial Bot)":
            // Only a head, very limited physically
            break;
            
        case "Box Bot":
            // Has arms/legs, decent at tasks
            break;
            
        case "Tutorial Bot":
            // Hovers, “ineffective” tutorial prowess
            break;
            
        case "Silver Scorpion":
            // Small, extremely durable and deadly
            break;
            
        case "Moosephant":
            // Big, laid-back
            break;
            
        case "ZooChomper":
            // Can absorb anything, balanced stats
            break;
            
        case "Green Bubble":
            // Mysterious Pokedex entry
            break;
            
        case "Tribble":
            // Very small, soothing
            break;
            
        case "Ewok":
            // Jungle-adapted, trap-setting
            break;
            
        case "Yodal":
            // Small but powerful psychically
            break;
            
        case "Porg":
            // Cliff-dwelling, friendly
            break;
            
        case "Rancor":
            // Large, strong, slow
            break;
            
        case "BB-8":
            // Robotic, fast roller
            break;
            
        case "Human":
            // Average all-around
            break;
            
        case "Squirrel":
            // Fast, agile
            break;
            
        case "Goomba":
            // Easy to defeat, but keeps marching
            break;
            
        case "Koopa":
            // Turtle-like soldier
            break;
            
        case "King Koopa (Bowser’s Species)":
            // Powerful, can breathe fire, leads armies
            break;
            
        case "Boo":
            // Shy ghost
            break;
            
        case "Yo’Ster":
            // Dino that converts eaten items into eggs
            break;
            
        case "Tektite":
            // Jumps to attack, tricky to hit
            break;
            
        case "Demo Dog":
            // Thick skin, strong, climbs walls
            break;
            
        case "Demogorgon":
            // Extremely strong, durable, telekinetic
            break;
            
        case "Metroid":
            // Parasitic, drains life-energy
            break;
            
        case "Kirby":
            // Can inhale enemies, decent all-around
            break;
            
        case "Krypton Firefly":
            // Incredibly fast/durable under Earth conditions
            break;
            
        case "Zoombini":
            // Very intelligent, not physically strong
            break;
            
        case "Pikmin":
            // Tiny plant-like helpers
            break;
            
        case "Creeper":
            // Explodes when close
            break;
            
        case "Enderman":
            // Docile until looked at; then very fast
            break;
            
        case "Pac-Man":
            // Voracious eater, moderate overall
            break;
            
        case "Ghost (Pac-Man)":
            // Hunts in packs, intangible
            break;
            
        case "Morlock":
            // Evolved from humans, hunts them, agile
            break;
            
        case "Zergling":
            // Weak individually but fast and swarm
            break;
            
        case "Xenomorph":
            // Deadly, acid blood
            break;
            
        case "Andalite":
            // Can morph, deadly tail, wide vision
            break;
            
        case "Licker":
            // Long tongue, climbs walls
            break;
            
        case "Godzooky":
            // Friendly, can fly (awkwardly), moderate
            break;
            
        case "Godzilla":
            // Enormous, legendary monster
            break;
    }
	return false
}

/// @param {string}   index   The position of the Pokémon in the party to retreive base stats of
/// @description              Returns a list with the base stats of the given Pokémon, in the following order: HP, Attack, Defense, Special Attack, Special Defense, Speed.
function GetPokemonBaseStats(index) {
	var pokemon = ds_list_find_value(global.playerParty, index)
	var name = ds_list_find_value(pokemon, 1)
	var statList = ds_list_create()
	switch (name)
    {
        //--------------------------------
        // Official Pokémon (where known)
        //--------------------------------
        case "Pikachu":
            // As in your snippet
            ds_list_add(statList, 35, 55, 40, 50, 50, 90);
            break;
            
        case "Voltorb":
            // Canonical Gen 1 base stats
            ds_list_add(statList, 40, 30, 50, 55, 55, 100);
            break;
            
        case "Caterpie":
            ds_list_add(statList, 45, 30, 35, 20, 20, 45);
            break;
            
        case "Magnemite":
            ds_list_add(statList, 25, 35, 70, 95, 55, 45);
            break;
            
        case "Butterfree":
            ds_list_add(statList, 60, 45, 50, 90, 80, 70);
            break;
            
        case "Charmander":
            // As in your snippet
            ds_list_add(statList, 39, 52, 43, 60, 50, 65);
            break;
            
        case "Charmeleon":
            ds_list_add(statList, 58, 64, 58, 80, 65, 80);
            break;
            
        case "Charizard":
            ds_list_add(statList, 78, 84, 78, 109, 85, 100);
            break;
            
        case "Clefairy":
            ds_list_add(statList, 70, 45, 48, 60, 65, 35);
            break;
            
        case "Squirtle":
            // As in your snippet
            ds_list_add(statList, 44, 48, 65, 50, 64, 43);
            break;
            
        case "Wartortle":
            ds_list_add(statList, 59, 63, 80, 65, 80, 58);
            break;
            
        case "Blastoise":
            ds_list_add(statList, 79, 83, 100, 85, 105, 78);
            break;
            
        case "Snorlax":
            // As in your snippet
            ds_list_add(statList, 160, 110, 65, 65, 110, 30);
            break;
            
        case "MissingNo":
            // “Glitchy” stats, just for fun
            ds_list_add(statList, 33, 136, 0, 6, 0, 29);
            break;
            
        case "Articuno":
            ds_list_add(statList, 90, 85, 100, 95, 125, 85);
            break;
            
        case "Moltres":
            ds_list_add(statList, 90, 100, 90, 125, 85, 90);
            break;
            
        case "Zapdos":
            ds_list_add(statList, 90, 90, 85, 125, 90, 100);
            break;
            
        case "Yamask":
            ds_list_add(statList, 38, 30, 85, 55, 65, 30);
            break;
            
        // “Shadow Umbreon” – slight twist on normal Umbreon’s stats
        case "Umbreon (Shadow Version)":
            ds_list_add(statList, 95, 75, 110, 60, 130, 65);
            break;
            
        case "Zubat":
            ds_list_add(statList, 40, 45, 35, 30, 40, 55);
            break;
        
        //------------------------------
        // Fan/Crossover Pokémon
        //------------------------------
        case "Envy":
            // Aquatic shadow Pokémon, envious spirit
            ds_list_add(statList, 55, 50, 45, 60, 70, 55);
            break;
            
        case "Ape-Ball":
            // Extremely fast and deadly
            ds_list_add(statList, 60, 110, 60, 40, 50, 120);
            break;
            
        case "Woob-Wub":
            // The unluckiest Pokémon, extremely fragile
            ds_list_add(statList, 20, 5, 10, 10, 10, 5);
            break;
            
        case "Fig":
            // Docile, self-sacrificing
            ds_list_add(statList, 20, 10, 10, 10, 10, 10);
            break;
            
        case "Umbrian":
            // Shadow Pokémon, mask-bound
            ds_list_add(statList, 60, 85, 65, 70, 90, 65);
            break;
            
        case "Caelian":
            // Light counterpart to Umbrian
            ds_list_add(statList, 60, 70, 65, 85, 90, 80);
            break;
            
        case "Baby (Tutorial Bot)":
            // Only a head, very limited physically
            ds_list_add(statList, 30, 5, 30, 20, 30, 5);
            break;
            
        case "Box Bot":
            // Has arms/legs, decent at tasks
            ds_list_add(statList, 45, 40, 40, 30, 40, 35);
            break;
            
        case "Tutorial Bot":
            // Hovers, “ineffective” tutorial prowess
            ds_list_add(statList, 50, 30, 40, 50, 50, 40);
            break;
            
        case "Silver Scorpion":
            // Small, extremely durable and deadly
            ds_list_add(statList, 40, 95, 120, 30, 50, 70);
            break;
            
        case "Moosephant":
            // Big, laid-back
            ds_list_add(statList, 90, 75, 80, 60, 80, 40);
            break;
            
        case "ZooChomper":
            // Can absorb anything, balanced stats
            ds_list_add(statList, 70, 70, 60, 70, 60, 70);
            break;
            
        case "Green Bubble":
            // Mysterious Pokedex entry
            ds_list_add(statList, 10, 10, 10, 10, 10, 10);
            break;
            
        case "Tribble":
            // Very small, soothing
            ds_list_add(statList, 20, 5, 5, 5, 5, 10);
            break;
            
        case "Ewok":
            // Jungle-adapted, trap-setting
            ds_list_add(statList, 50, 65, 40, 20, 45, 55);
            break;
            
        case "Yodal":
            // Small but powerful psychically
            ds_list_add(statList, 40, 40, 35, 80, 75, 60);
            break;
            
        case "Porg":
            // Cliff-dwelling, friendly
            ds_list_add(statList, 40, 30, 35, 30, 35, 50);
            break;
            
        case "Rancor":
            // Large, strong, slow
            ds_list_add(statList, 100, 110, 90, 30, 60, 35);
            break;
            
        case "BB-8":
            // Robotic, fast roller
            ds_list_add(statList, 45, 55, 50, 40, 50, 100);
            break;
            
        case "Human":
            // Average all-around
            ds_list_add(statList, 50, 50, 50, 50, 50, 50);
            break;
            
        case "Squirrel":
            // Fast, agile
            ds_list_add(statList, 35, 50, 30, 20, 30, 90);
            break;
            
        case "Goomba":
            // Easy to defeat, but keeps marching
            ds_list_add(statList, 30, 30, 30, 10, 20, 20);
            break;
            
        case "Koopa":
            // Turtle-like soldier
            ds_list_add(statList, 40, 40, 60, 30, 40, 20);
            break;
            
        case "King Koopa (Bowser’s Species)":
            // Powerful, can breathe fire, leads armies
            ds_list_add(statList, 100, 100, 95, 85, 80, 50);
            break;
            
        case "Boo":
            // Shy ghost
            ds_list_add(statList, 45, 50, 30, 65, 80, 55);
            break;
            
        case "Yo’Ster":
            // Dino that converts eaten items into eggs
            ds_list_add(statList, 70, 70, 65, 40, 50, 75);
            break;
            
        case "Tektite":
            // Jumps to attack, tricky to hit
            ds_list_add(statList, 30, 50, 25, 25, 25, 60);
            break;
            
        case "Demo Dog":
            // Thick skin, strong, climbs walls
            ds_list_add(statList, 60, 70, 55, 20, 50, 65);
            break;
            
        case "Demogorgon":
            // Extremely strong, durable, telekinetic
            ds_list_add(statList, 100, 100, 90, 60, 70, 60);
            break;
            
        case "Metroid":
            // Parasitic, drains life-energy
            ds_list_add(statList, 45, 60, 40, 90, 50, 70);
            break;
            
        case "Kirby":
            // Can inhale enemies, decent all-around
            ds_list_add(statList, 70, 75, 50, 75, 50, 60);
            break;
            
        case "Krypton Firefly":
            // Incredibly fast/durable under Earth conditions
            ds_list_add(statList, 60, 75, 70, 65, 65, 125);
            break;
            
        case "Zoombini":
            // Very intelligent, not physically strong
            ds_list_add(statList, 45, 20, 40, 75, 50, 55);
            break;
            
        case "Pikmin":
            // Tiny plant-like helpers
            ds_list_add(statList, 20, 15, 15, 10, 20, 20);
            break;
            
        case "Creeper":
            // Explodes when close
            ds_list_add(statList, 35, 55, 35, 5, 30, 50);
            break;
            
        case "Enderman":
            // Docile until looked at; then very fast
            ds_list_add(statList, 70, 80, 60, 40, 50, 100);
            break;
            
        case "Pac-Man":
            // Voracious eater, moderate overall
            ds_list_add(statList, 60, 70, 45, 25, 45, 70);
            break;
            
        case "Ghost (Pac-Man)":
            // Hunts in packs, intangible
            ds_list_add(statList, 35, 40, 25, 65, 70, 60);
            break;
            
        case "Morlock":
            // Evolved from humans, hunts them, agile
            ds_list_add(statList, 60, 65, 45, 20, 40, 70);
            break;
            
        case "Zergling":
            // Weak individually but fast and swarm
            ds_list_add(statList, 35, 65, 30, 20, 25, 90);
            break;
            
        case "Xenomorph":
            // Deadly, acid blood
            ds_list_add(statList, 80, 90, 70, 30, 60, 70);
            break;
            
        case "Andalite":
            // Can morph, deadly tail, wide vision
            ds_list_add(statList, 75, 80, 70, 70, 70, 80);
            break;
            
        case "Licker":
            // Long tongue, climbs walls
            ds_list_add(statList, 65, 85, 60, 25, 40, 70);
            break;
            
        case "Godzooky":
            // Friendly, can fly (awkwardly), moderate
            ds_list_add(statList, 70, 65, 60, 60, 60, 50);
            break;
            
        case "Godzilla":
            // Enormous, legendary monster
            ds_list_add(statList, 150, 130, 120, 100, 100, 50);
            break;
    }

	return statList
}

/// @param {string}   index   The position of the Pokémon in the party to retreive final stats of
/// @description              Returns a list with the final stats of the given Pokémon, in the following order: HP, Attack, Defense, Special Attack, Special Defense, Speed.
function GetPokemonFinalStats(index)
{
	var pokemon = ds_list_find_value(global.playerParty, index)
	var level = ds_list_find_value(pokemon, 2)
	var baseStats = GetPokemonBaseStats(index)
	
	var finalStats = ds_list_create()
	for (var i = 0; i < ds_list_size(baseStats); i++)
	{
		ds_list_add(finalStats, ds_list_find_value(baseStats, i)*(2*(level/100)))
	}
	
	return finalStats
}