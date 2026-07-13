/// @param {string}   name    The name of the Pokémon being added
/// @param {real}     level   The level of the Pokémon being added
/// @param {string}   gender  The name of the Pokémon being added
/// @param {asset}    sprite  The sprite of the Pokémon being added
/// @description              Adds a Pokémon to the player's party with the provided information, with all of it being stored inside a DS list. Added Pokémon are always added with 100% of their health.
function AddPokemon(name, level, gender) {
	var sprite = GetSpriteByNumber(GetNumberByName(name))
	var pokemon = ds_list_create()
	var growthRate = "Very Fast"
	var hp =  GetPokemonFinalHP(name, level)
	var learnset = GetLevelUpMoveset(name, level)
	var learnsetPP = GetLearnsetPP(learnset)
	var expLevelFloor = GetExpLevelFloor(level, growthRate)
	var types = GetPokemonType(name)

	ds_list_add(pokemon, global.catchIndex, name, level, gender, sprite, hp, learnset, learnsetPP, expLevelFloor+20, growthRate, types, "None")
	ds_list_add(global.pokemonList, pokemon)
	global.catchIndex++

	if (ds_list_size(global.playerParty) < 6)
	{
		ds_list_add(global.playerParty, pokemon)
	}

	if (ds_list_find_index(global.pokedex, name) == -1)
	{
		ds_list_add(global.pokedex, name)
	}
}

function AddPokemonSpecific(pokemon) {
	var name = GetName(pokemon)
	ds_list_add(global.pokemonList, pokemon)
	global.catchIndex++

	if (ds_list_size(global.playerParty) < 6)
	{
		ds_list_add(global.playerParty, pokemon)
	}

	if (ds_list_find_index(global.pokedex, name) == -1)
	{
		ds_list_add(global.pokedex, name)
	}
}

function AddPokemonWithHP(name, level, gender, sprite, hp) {
	var pokemon = ds_list_create()
	var growthRate = "Very Fast"
	var learnset = GetLevelUpMoveset(name, level)
	var learnsetPP = GetLearnsetPP(learnset)
	var expLevelFloor = GetExpLevelFloor(level, growthRate)
	var types = GetPokemonType(name)

	ds_list_add(pokemon, global.catchIndex, name, level, gender, sprite, hp, learnset, learnsetPP, expLevelFloor+20, growthRate, types, "None")
	ds_list_add(global.pokemonList, pokemon)
	global.catchIndex++

	if (ds_list_size(global.playerParty) < 6)
	{
		ds_list_add(global.playerParty, pokemon)
	}
	if (ds_list_find_index(global.pokedex, name) != -1) ds_list_add(global.pokedex, name)
}

function AddPokemonTrainer(team, index, name, level, gender, sprite) {
	var pokemon = ds_list_create()
	var growthRate = "Very Fast"
	var hp = ds_list_find_value(GetPokemonFinalStats(name, level), 0)
	var learnset = GetLevelUpMoveset(name, level)
	var learnsetPP = GetLearnsetPP(learnset)
	var expLevelFloor = GetExpLevelFloor(level, growthRate)
	var types = GetPokemonType(name)

	ds_list_add(pokemon, index, name, level, gender, sprite, hp, learnset, learnsetPP, expLevelFloor+20, growthRate, types, "None")

	if (ds_list_size(team) < 6)
	{
		ds_list_add(team, pokemon)
	}
}

function CreatePokemonInfo(name, level, gender, moveset)
{
	if (gender == noone) gender = GetRandomGender(GetGenderChance(name, "Male"))

	var sprite = GetSpriteByNumber(GetNumberByName(name))
	var pokemon = ds_list_create()
	var growthRate = "Very Fast"
	var hp =  GetPokemonFinalHP(name, level)

	var learnset = GetLevelUpMoveset(name, level)
	if (moveset != noone) ds_list_copy(learnset, moveset)
	var learnsetPP = GetLearnsetPP(learnset)
	var expLevelFloor = GetExpLevelFloor(level, growthRate)
	var types = GetPokemonType(name)

	ds_list_add(pokemon, global.catchIndex, name, level, gender, sprite, hp, learnset, learnsetPP, expLevelFloor+20, growthRate, types, "None")

	instance_destroy(moveset)

	return pokemon
}

function GetWildPokemon(encounterType)
{
	var encounters = GetAreaEncounters(encounterType)

	var pkmn = ds_list_create()
	var name = ds_list_find_value(encounters, random_range(0,ds_list_size(encounters)))
	var level = 0
	if room == Mallet_Town {
		level = floor(random_range(1,3))
	}
	else if room == RouteMinusOneBottom {
		level = floor(random_range(2,6))
	}
	else if room == RouteMinusOneTop {
		level = floor(random_range(3,7))
	}
	else {
		level = floor(random_range(7,15))
	}
	var gender = "Male"
	if (floor(random_range(1,3)) > 1) gender = "Female"
	var sprite = GetSpriteByNumber(GetNumberByName(name))

	var growthRate = "Very Fast"
	var hp = ds_list_find_value(GetPokemonFinalStats(name, level), 0)
	var learnset = GetLevelUpMoveset(name, level)
	var learnsetPP = GetLearnsetPP(learnset)
	var expLevelFloor = GetExpLevelFloor(level, growthRate)
	var types = GetPokemonType(name)

	ds_list_add(pkmn, 0, name, level, gender, sprite, hp, learnset, learnsetPP, expLevelFloor+20, growthRate, types, "None")

	return pkmn
}

function GetPokemonType(name)
{
    var types = ds_list_create();
    switch (name)
    {
        // Official / Classic
        case "Pikachu":
            ds_list_add(types, "Electric");
            break;
        case "Voltorb":
            ds_list_add(types, "Electric");
            break;
        case "Caterpie":
            ds_list_add(types, "Bug");
            break;
        case "Magnemite":
            ds_list_add(types, "Electric", "Steel");
            break;
        case "Butterfree":
            ds_list_add(types, "Bug", "Flying");
            break;
        case "Charmander":
            ds_list_add(types, "Fire");
            break;

        // Replaced Charmeleon -> Charmandorian
        case "Charmandorian":
            // Charmander + Andorian
            ds_list_add(types, "Fire", "Ice");
            break;

        // Replaced Charizard -> Charmandalorian
        case "Charmandalorian":
            // Charmander + Mandalorian + Andorian + Charizard
            ds_list_add(types, "Fire", "Ice", "Steel");
            break;

        case "Clefairy":
            ds_list_add(types, "Fairy");
            break;
        case "Squirtle":
            ds_list_add(types, "Water");
            break;

        // Replaced Wartortle -> Ninja Squirtle
        case "Ninja Squirtle":
            // Ninja Turtle + Squirtle
            ds_list_add(types, "Water", "Fighting");
            break;

        // Replaced Blastoise -> Omega Squirtle
        case "Omega Squirtle":
            // Transcendent superhero water-being
            ds_list_add(types, "Water", "Psychic");
            break;

        case "Snorlax":
            ds_list_add(types, "Normal");
            break;
        case "MissingNo":
            ds_list_add(types, "???");
            break;
        case "Articuno":
            ds_list_add(types, "Ice", "Flying");
            break;
        case "Moltres":
            ds_list_add(types, "Fire", "Flying");
            break;
        case "Zapdos":
            ds_list_add(types, "Electric", "Flying");
            break;
        case "Yamask":
            ds_list_add(types, "Ghost");
            break;
        case "Umbreon":
            ds_list_add(types, "Dark", "Ghost");
            break;
        case "Zubat":
            ds_list_add(types, "Poison", "Flying");
            break;
        case "Envy":
            ds_list_add(types, "Water", "Ghost", "Dark");
            break;
        case "Ape-Ball":
            ds_list_add(types, "Fighting");
            break;
        case "Woob-Wüb":
            ds_list_add(types, "Normal");
            break;
        case "Fig":
            ds_list_add(types, "Normal");
            break;
        case "Umbrian":
            ds_list_add(types, "Ghost", "Dark");
            break;
        case "Caelian":
            ds_list_add(types, "Ghost", "Psychic");
            break;
        case "Baby":
            ds_list_add(types, "Steel");
            break;
        case "Box Bot":
            ds_list_add(types, "Steel");
            break;
        case "Tutorial Bot":
            ds_list_add(types, "Steel");
            break;
        case "Silver Scorpion":
            ds_list_add(types, "Bug", "Steel");
            break;
        case "Moosephant":
            ds_list_add(types, "Normal");
            break;
        case "ZooChomper":
            ds_list_add(types, "Normal");
            break;
        case "Green Bubble":
            ds_list_add(types, "???");
            break;
        case "Tribble":
            ds_list_add(types, "Normal");
            break;
        case "Ewok":
            ds_list_add(types, "Grass", "Fighting");
            break;
        case "Yodal":
            ds_list_add(types, "Psychic");
            break;
        case "Porg":
            ds_list_add(types, "Flying");
            break;
        case "Rancor":
            ds_list_add(types, "Dark");
            break;
        case "BB-8":
            ds_list_add(types, "Steel");
            break;
        case "Human":
            ds_list_add(types, "Normal");
            break;
        case "Squirrel":
            ds_list_add(types, "Normal");
            break;
        case "Goomba":
            ds_list_add(types, "Grass");
            break;
        case "Koopa":
            ds_list_add(types, "Grass");
            break;
        case "King Koopa":
            ds_list_add(types, "Fire", "Dragon");
            break;
        case "Boo":
            ds_list_add(types, "Ghost");
            break;
        case "Yo’ster":
            ds_list_add(types, "Dragon");
            break;
        case "Tektite":
            ds_list_add(types, "Bug");
            break;
        case "Demo Dog":
            ds_list_add(types, "Dark");
            break;
        case "Demogorgon":
            ds_list_add(types, "Dark", "Psychic");
            break;
        case "Metroid":
            ds_list_add(types, "Bug");
            break;
        case "Kirby":
            ds_list_add(types, "Fairy");
            break;
        case "Krypton Firefly":
            ds_list_add(types, "Fire", "Flying");
            break;
        case "Zoombini":
            ds_list_add(types, "Fairy");
            break;
        case "Pikmin":
            ds_list_add(types, "Grass");
            break;
        case "Creeper":
            ds_list_add(types, "Grass");
            break;
        case "Enderman":
            ds_list_add(types, "Ghost");
            break;
        case "Pac-Man":
            ds_list_add(types, "Normal");
            break;
        case "Pac-Ghost":
            ds_list_add(types, "Ghost");
            break;
        case "Morlock":
            ds_list_add(types, "Dark");
            break;
        case "Zergling":
            ds_list_add(types, "Bug");
            break;
        case "Xenomorph":
            ds_list_add(types, "Bug", "Dark");
            break;
        case "Andalite":
            ds_list_add(types, "Psychic");
            break;
        case "Licker":
            ds_list_add(types, "Dark");
            break;
        case "Godzooky":
            ds_list_add(types, "Dragon", "Flying");
            break;
        case "Godzilla":
            ds_list_add(types, "Dragon");
            break;
	    case "Glyptoblock":
	        ds_list_add(types, "Rock", "Fire");
	        break;

		default:
			ds_list_add(types, "Normal");
            break;
    }
    return types;
}

/// @param            team    The position of the Pokémon in the party to retreive info about
/// @param {string}   index   The party to search for the Pokémon at the given position in
/// @description              Returns a list with the information of the given Pokémon, using its index in the party as an identifier, in the following order: Index, Name, Level, Gender, Sprite, HP, Move List, Move PP List, EXP, Growth Rate, and Types
function GetPartyMemberInfo(team, index) {
	return ds_list_find_value(team, index)
}

#region Little Functions
function GetName(pkmnInfo) { return ds_list_find_value(pkmnInfo, 1) }
function GetLevel(pkmnInfo) { return ds_list_find_value(pkmnInfo, 2) }
function GetGender(pkmnInfo) { return ds_list_find_value(pkmnInfo, 3) }
function GetSprite(pkmnInfo) { return ds_list_find_value(pkmnInfo, 4) }
function GetHealth(pkmnInfo) { return ds_list_find_value(pkmnInfo, 5) }
function GetMoves(pkmnInfo) { return ds_list_find_value(pkmnInfo, 6) }
function GetMovePPList(pkmnInfo) { return ds_list_find_value(pkmnInfo, 7) }
function SetMovePP(movePPList, moveIndex, amount) { ds_list_set(movePPList, moveIndex, amount) }
function GetExp(pkmnInfo) { return ds_list_find_value(pkmnInfo, 8) }
function GetGrowth(pkmnInfo) { return ds_list_find_value(pkmnInfo, 9) }
function GetTypes(pkmnInfo) { return ds_list_find_value(pkmnInfo, 10)}
function GetStatus(pkmnInfo) { return ds_list_find_value(pkmnInfo, 11)}
function SetStatus(pkmnInfo, status) { ds_list_set(pkmnInfo, 11, status)}
function ClearStatus(pkmnInfo) { ds_list_set(pkmnInfo, 11, "None") }
#endregion

function GetRandomGender(maleChance)
{
	if (floor(random_range(0,100)) <= maleChance) return "Male"
	else return "Female"
}

function GetStatusColor(status)
{
	switch (status)
	{
		case "Paralysis": return c_yellow
		case "Poisoned": return c_purple
		case "Burn": return c_red
		case "Sleep": return c_gray
	}
	return c_white
}

function AddExp(pkmnInfo, expValue)
{
	var pkmnExp = GetExp(pkmnInfo)
	var expPerc = GetExpPercentage(pkmnInfo)

	var level = GetLevel(pkmnInfo)
	var growthRate = GetGrowth(pkmnInfo)

	var levelsGained = 0
	for (var i = 1; i < 100; i++)
	{
		var levelFloorCheck = GetExpLevelFloor(level+i, growthRate)
		if (pkmnExp+expValue >= levelFloorCheck and level < 100)
		{
			levelsGained++
		}
		else break
	}

	if (pkmnExp+expValue >= GetExpLevelFloor(level, growthRate))
	{
		ds_list_set(pkmnInfo, 8, pkmnExp+expValue)
		ds_list_set(pkmnInfo, 2, level+levelsGained)
	}
	else ds_list_set(pkmnInfo, 8, pkmnExp+expValue)
}

/// @param            team    The team to search for the Pokémon you want to retreive info about
/// @param {string}   index   The position of the Pokémon in the party to retreive info about
/// @description              Checks if the given party member can evolve, by checking its species, its level and the species' evolution requirements
function CanEvolve(team, index) {
	var pokemon = GetPartyMemberInfo(team, index)
	var species = ds_list_find_value(pokemon, 1)
	var level = ds_list_find_value(pokemon, 2)

	switch (species)
    {
        //--------------------------------
        // Official Pokémon (where known)
        //--------------------------------
        case "Pikachu":
            break;

        case "Voltorb":
            
            break;

        case "Caterpie":
			if (level >= 10) return "Butterfree"

        case "Magnemite":
            break;

        case "Butterfree":
            break;

        case "Charmander":
			if (level >= 16) return "Charmandorian"

        case "Charmandorian":
            if (level >= 36) return "Charmandalorian"

        case "Charmandalorian":
            break;

        case "Clefairy":
            break;

        case "Squirtle":
            if (level >= 16) return "Ninja Squirtle"

        case "Ninja Squirtle":
            if (level >= 36) return "Omega Squirtle"

        case "Omega Squirtle":
            break;

        case "Snorlax":
            break;

        case "MissingNo":
            break;

        case "Articuno":
            break;

        case "Moltres":
            break;

        case "Zapdos":
            break;

        case "Yamask":
            break;

        case "Umbreon":
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

        case "Woob-Wüb":
            // The unluckiest Pokémon, extremely fragile
            break;

        case "Fig":
            // Docile, self-sacrificing
            break;

        case "Umbrian":
            if (level >= 25) return "Caelian"
            break;

        case "Caelian":
            break;

        case "Baby":
            if (level >= 12) return "Box Bot"
            break;

        case "Box Bot":
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
            if (level >= 16) return "Human"
			if (level >= 20) return "Morlock"
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
            if (level >= 16) return "Morlock"
			if (level >= 25) return "Yodal"
            break;

        case "Squirrel":
           if (level >= 30) return "Rancor"
            break;

        case "Goomba":
            // Easy to defeat, but keeps marching
            break;

        case "Koopa":
            if (level >= 35) return "King Koopa"
            break;

        case "King Koopa":
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
            if (level >= 20) return "Demogorgon"
            break;

        case "Demogorgon":
            break;

        case "Metroid":
            // Parasitic, drains life-energy
            break;

        case "Kirby":
            // Can inhale enemies, decent all-around
            break;

        case "Krypton Firefly":
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

        case "Pac-Ghost":
            // Hunts in packs, intangible
            break;

        case "Morlock":
            // Evolved from humans, hunts them, agile
            break;

        case "Zergling":
            if (level >= 27) return "Xenomorph"
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
		
		case "Glyptoblock":
            // Ancient, heavily armored block creature
            break;

        case "Godzooky":
            if (level >= 60) return "Godzilla"
            break;

        case "Godzilla":
            // Enormous, legendary monster
            break;
			
    }
	return false
}

/// @param {string}   name    The name of the Pokémon to retreive base stats of
/// @description              Returns a list with the base stats of the given Pokémon, in the following order: HP, Attack, Defense, Special Attack, Special Defense, Speed.
function GetPokemonBaseStats(name) {
	var statList = ds_list_create()
	switch (name)
    {
        //--------------------------------
        // Official Pokémon (where known)
        //--------------------------------
        case "Pikachu":
            ds_list_add(statList, 35, 55, 40, 50, 50, 90);
            break;

        case "Voltorb":
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
            ds_list_add(statList, 39, 52, 43, 60, 50, 65);
            break;

        case "Charmandorian":
            ds_list_add(statList, 58, 64, 58, 80, 65, 80);
            break;

        case "Charmandalorian":
            ds_list_add(statList, 78, 84, 78, 109, 85, 100);
            break;

        case "Clefairy":
            ds_list_add(statList, 70, 45, 48, 60, 65, 35);
            break;

        case "Squirtle":
            ds_list_add(statList, 44, 48, 65, 50, 64, 43);
            break;

        case "Ninja Squirtle":
            ds_list_add(statList, 59, 63, 80, 65, 80, 58);
            break;

        case "Omega Squirtle":
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
        case "Umbreon":
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

        case "Woob-Wüb":
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

        case "Baby":
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

        case "King Koopa":
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

        case "Pac-Ghost":
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
			
	    case "Glyptoblock":
            // Extremely sturdy and slow, with solid firepower
            ds_list_add(statList, 65, 70, 100, 65, 80, 35);
            break;

        case "Godzooky":
            // Friendly, can fly (awkwardly), moderate
            ds_list_add(statList, 70, 65, 60, 60, 60, 50);
            break;

        case "Godzilla":
            // Enormous, legendary monster
            ds_list_add(statList, 150, 130, 120, 100, 100, 50);
            break;
			
		default:
			ds_list_add(statList, 50, 50, 50, 50, 50, 50);
    }

	return statList
}

/// @param {string}   name    The name Pokémon to retreive final stats of
/// @param {string}   level   The level Pokémon to retreive final stats of
/// @description              Returns a list with the final stats of the given Pokémon, in the following order: HP, Attack, Defense, Special Attack, Special Defense, Speed.
function GetPokemonFinalStats(name, level)
{
	var baseStats = GetPokemonBaseStats(name)

	var finalStats = ds_list_create()
	for (var i = 0; i < ds_list_size(baseStats); i++)
	{
		if (i == 0)
		{
			var hpStat = floor(2*ds_list_find_value(baseStats, i)*level/100+level+10)
			ds_list_add(finalStats, hpStat)
		}
		else
		{
			var stat = floor(2*ds_list_find_value(baseStats, i)*level/100+5)
			ds_list_add(finalStats, stat)
		}
	}

	return finalStats
}

function GetPokemonFinalHP(name, level) { return ds_list_find_value(GetPokemonFinalStats(name, level), 0) }

function GetHPStat(statList) { return ds_list_find_value(statList, 0) }
function GetAtkStat(statList) { return ds_list_find_value(statList, 1) }
function GetDefStat(statList) { return ds_list_find_value(statList, 2) }
function GetSpAtkStat(statList) { return ds_list_find_value(statList, 3) }
function GetSpDefStat(statList) { return ds_list_find_value(statList, 4) }
function GetSpeedStat(statList) { return ds_list_find_value(statList, 5) }

/// @param           pkmn     The Pokémon to set the stats of
/// @description              Sets all stat values in a Battle Pokémon object, based on their Pokémon info.
function SetPokemonDefaults(pkmn)
{
	sprite_index = GetSprite(pkmn)
	var name = GetName(pkmn)
	var level = GetLevel(pkmn)

	var stats = GetPokemonFinalStats(name, level)
	hp = GetHealth(pkmnInfo)
	atk = ds_list_find_value(stats, 1)
	def = ds_list_find_value(stats, 2)
	spatk = ds_list_find_value(stats, 3)
	spdef = ds_list_find_value(stats, 4)
	spd = ds_list_find_value(stats, 5)
}

/// @param {string} moveName  The name of the move to search information about
/// @description              Returns a list with the info about the given move, in the following order: Name, Type, Category, Base Power, Accurancy, Power Point, Inflict Effect, Inflict Chance, Crit Multiplier, Priority.
function GetMoveDetails(moveName)
{
	var moveInfo = ds_list_create()
	switch (moveName)
    {
        //---------------------------------------
        // Common / Canonical Moves
        //---------------------------------------
        case "Tackle":
            // [Name, Type, Category, Power, Accuracy, PP, Effect, EffectChance, CritChance, Priority]
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 40, 100, 35, "None", 1, 1, 0);
            break;
        case "Growl":
            ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 40, "LowerAttack", 1, 1, 0);
            break;
        case "Quick Attack":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 40, 100, 30, "None", 1, 1, 1);
            break;
        case "Scratch":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 40, 100, 35, "None", 1, 1, 0);
            break;
        case "Ember":
            ds_list_add(moveInfo, moveName, "Fire", "Special", 40, 100, 25, "Burn", 0.1, 1, 0);
            break;
        case "Water Gun":
            ds_list_add(moveInfo, moveName, "Water", "Special", 40, 100, 25, "None", 1, 1, 0);
            break;
        case "Vine Whip":
            ds_list_add(moveInfo, moveName, "Grass", "Physical", 45, 100, 25, "None", 1, 1, 0);
            break;
        case "Thunder Shock":
            ds_list_add(moveInfo, moveName, "Electric", "Special", 40, 100, 30, "Paralysis", 0.1, 1, 0);
            break;
		case "Thunderbolt":
            ds_list_add(moveInfo, moveName, "Electric", "Special", 90, 100, 15, "Paralysis", 0.3, 1, 0);
            break;
		case "Electro Ball":
            ds_list_add(moveInfo, moveName, "Electric", "Special", 0, 100, 30, "SpeedPower", 1, 1, 0);
            break;
        case "Confusion":
            ds_list_add(moveInfo, moveName, "Psychic", "Special", 50, 100, 25, "Confuse", 0.1, 1, 0);
            break;
        case "Gust":
            ds_list_add(moveInfo, moveName, "Flying", "Special", 40, 100, 35, "None", 1, 1, 0);
            break;
        case "Bite":
            ds_list_add(moveInfo, moveName, "Dark", "Physical", 60, 100, 25, "Flinch", 0.3, 1, 0);
            break;
        case "Self-Destruct":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 200, 100, 5, "FaintUser", 1, 1, 0);
            break;
        case "String Shot":
            ds_list_add(moveInfo, moveName, "Bug", "Status", 0, 95, 40, "LowerSpeed", 1, 1, 0);
            break;
        case "Thunder Wave":
            ds_list_add(moveInfo, moveName, "Electric", "Status", 0, 90, 20, "Sleep", 1, 1, 0);
            break;
        case "Ice Beam":
            ds_list_add(moveInfo, moveName, "Ice", "Special", 90, 100, 10, "Freeze", 0.1, 1, 0);
            break;
        case "Drill Peck":
            ds_list_add(moveInfo, moveName, "Flying", "Physical", 80, 100, 20, "None", 1, 1, 0);
            break;
        case "Shadow Punch":
            ds_list_add(moveInfo, moveName, "Ghost", "Physical", 60, 1000, 20, "None", 1, 1, 0);
            break;
        case "Shadow Ball":
            ds_list_add(moveInfo, moveName, "Ghost", "Special", 80, 100, 15, "LowerSpDef", 0.2, 1, 0);
            break;
        case "Leech Life":
            ds_list_add(moveInfo, moveName, "Bug", "Physical", 80, 100, 10, "Drain", 1, 1, 0);
            break;
        case "Hypnosis":
            ds_list_add(moveInfo, moveName, "Psychic", "Status", 0, 60, 20, "Sleep", 1, 1, 0);
            break;
        case "Poison Sting":
            ds_list_add(moveInfo, moveName, "Poison", "Physical", 15, 100, 35, "Poison", 0.3, 1, 0);
            break;
        case "Sing":
            ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 55, 15, "Sleep", 1, 1, 0);
            break;
        case "Crunch":
            ds_list_add(moveInfo, moveName, "Dark", "Physical", 80, 100, 15, "LowerDefense", 0.2, 1, 0);
            break;
        case "Withdraw":
            ds_list_add(moveInfo, moveName, "Water", "Status", 0, 100, 40, "RaiseDefense", 1, 1, 0);
            break;
        case "Headbutt":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 70, 100, 15, "Flinch", 0.3, 1, 0);
            break;

        //---------------------------------------
        // High-power / advanced moves
        //---------------------------------------
        case "Giga Impact":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 150, 90, 5, "Recharge", 1, 1, 0);
            break;
        case "Psychic":
            ds_list_add(moveInfo, moveName, "Psychic", "Special", 90, 100, 10, "LowerSpDef", 0.1, 1, 0);
            break;
        case "Dynamic Punch":
            ds_list_add(moveInfo, moveName, "Fighting", "Physical", 100, 50, 5, "Confuse", 1, 1, 0);
            break;
        case "Bulldoze":
            ds_list_add(moveInfo, moveName, "Ground", "Physical", 60, 100, 20, "LowerSpeed", 1, 1, 0);
            break;
        case "Rock Tomb":
            ds_list_add(moveInfo, moveName, "Rock", "Physical", 60, 95, 15, "LowerSpeed", 1, 1, 0);
            break;
        case "Storm Throw":
            // In main series, always crits; here we approximate
            ds_list_add(moveInfo, moveName, "Fighting", "Physical", 60, 100, 10, "Crit", 1, 1.5, 0);
            break;
        case "Play Rough":
            ds_list_add(moveInfo, moveName, "Fairy", "Physical", 90, 90, 10, "None", 1, 1, 0);
            break;
        case "Iron Defense":
            ds_list_add(moveInfo, moveName, "Steel", "Status", 0, 100, 15, "RaiseDef2", 1, 1, 0);
            break;

        //---------------------------------------
        // Custom / Fanfiction Moves
        //---------------------------------------
        case "Inhale":
            // Kirby's special
            ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 10, "Inhale", 1, 1, 0);
            break;
        case "Aura Sphere":
            ds_list_add(moveInfo, moveName, "Fighting", "Special", 80, 1000, 20, "None", 1, 1, 0);
            break;
        case "Flux":
            // MissingNo’s reality-bending move
            ds_list_add(moveInfo, moveName, "???", "Status", 0, 100, 5, "Flux", 1, 1, 0);
            break;
        case "Explosion":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 250, 100, 5, "FaintUser", 1, 1, 0);
            break;
        case "Grassy Surge":
            // In main games, an Ability, but we'll treat it as a move
            ds_list_add(moveInfo, moveName, "Grass", "Status", 0, 100, 5, "GrassyTerrain", 1, 1, 0);
            break;
        case "Dual Strike":
            // Demogorgon's special "two-head" move
            ds_list_add(moveInfo, moveName, "Dark", "Status", 0, 100, 5, "DualStrike", 1, 1, 0);
            break;
        case "Force Lift":
            // Yodal’s custom telekinetic move
            ds_list_add(moveInfo, moveName, "Psychic", "Status", 0, 100, 10, "Flinch", 1, 1, 0);
            break;
        case "Interface":
            // BB-8’s custom “hack” move
            ds_list_add(moveInfo, moveName, "Electric", "Status", 0, 100, 10, "Interface", 1, 1, 0);
            break;
       // case "Egg Toss": 
       //     // Yo'Ster -- DUPLICATE
       //     ds_list_add(moveInfo, moveName, "Normal", "Physical", 60, 100, 15, "None", 1, 1, 0);
       //     break;
        case "Jump Kick":
            ds_list_add(moveInfo, moveName, "Fighting", "Physical", 100, 95, 10, "RecoilOnMiss", 1, 1, 0);
            break;
        case "Acid Blood":
            // Xenomorph’s signature
            ds_list_add(moveInfo, moveName, "Poison", "Special", 60, 100, 15, "Corrode", 0.3, 1, 0);
            break;
        case "Slash":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 70, 100, 20, "HighCrit", 1, 1.2, 0);
            break;
        case "Lick":
            ds_list_add(moveInfo, moveName, "Ghost", "Physical", 30, 100, 30, "Paralysis", 0.3, 1, 0);
            break;
		case "Convince":
		case "Logic":
			ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 15, "Convince", 1, 1, 0);
            break;
		case "Hex Roulette":
			ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 15, "RandomStatus", 1, 1, 0);
            break;
		case "Doom Downgrade":
			ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 15, "DoomDowngrade", 1, 1, 0);
            break;
		case "Hail Mary Hit":
			ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 15, "HailMaryHit", 1, 1, 0);
            break;
		case "Set Trap":
			ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 15, "SetTrap", 1, 1, 0);
            break;
		case "Wicket's Reversal":
			ds_list_add(moveInfo, moveName, "Normal", "Status", 0, 100, 15, "WicketReversal", 1, 1, 0);
            break;
		case "Pound":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 40, 100, 35, "None", 1, 1, 0);
            break;

        case "Double Kick":
            ds_list_add(moveInfo, moveName, "Fighting", "Physical", 30, 100, 30, "None", 1, 1, 0);
            break;

        case "Mega Punch":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 80, 85, 20, "None", 1, 1, 0);
            break;

        case "Body Slam":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 85, 100, 15, "Paralysis", 0.3, 1, 0);
            break;

        case "Hyper Beam":
            ds_list_add(moveInfo, moveName, "Normal", "Special", 150, 90, 5, "Recharge", 1, 1, 0);
            break;

        case "Wing Attack":
            ds_list_add(moveInfo, moveName, "Flying", "Physical", 60, 100, 35, "None", 1, 1, 0);
            break;

        case "Bug Bite":
            ds_list_add(moveInfo, moveName, "Bug", "Physical", 60, 100, 20, "None", 1, 1, 0);
            break;

        case "Rollout":
            ds_list_add(moveInfo, moveName, "Rock", "Physical", 30, 90, 20, "None", 1, 1, 0);
            break;

        case "Fire Fang":
            ds_list_add(moveInfo, moveName, "Fire", "Physical", 65, 95, 15, "Burn", 0.1, 1, 0);
            break;

        case "Fire Blast":
            ds_list_add(moveInfo, moveName, "Fire", "Special", 110, 85, 5, "Burn", 0.1, 1, 0);
            break;

        case "Hydro Pump":
            ds_list_add(moveInfo, moveName, "Water", "Special", 110, 80, 5, "None", 1, 1, 0);
            break;

        case "Aqua Tail":
            ds_list_add(moveInfo, moveName, "Water", "Physical", 90, 90, 10, "None", 1, 1, 0);
            break;

        case "Dragon Breath":
            ds_list_add(moveInfo, moveName, "Dragon", "Special", 60, 100, 20, "Paralysis", 0.3, 1, 0);
            break;

        case "Shadow Claw":
            ds_list_add(moveInfo, moveName, "Ghost", "Physical", 70, 100, 15, "HighCrit", 1, 1.2, 0);
            break;

        case "Moonblast":
            ds_list_add(moveInfo, moveName, "Fairy", "Special", 95, 100, 15, "LowerAttack", 0.3, 1, 0);
            break;

        case "Egg Throw":
            ds_list_add(moveInfo, moveName, "Normal", "Physical", 60, 100, 15, "None", 1, 1, 0);
            break;
		

        default:
            // If a move is unrecognized, return Struggle
            ds_list_add(moveInfo, "Struggle", "Normal", "Physical", 50, 1000, 30, "StruggleRecoil", 1, 0, 0);
            break;
    }
	return moveInfo
}

#region MoreLittleFunctions
function GetMoveType(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 1) }
function GetMoveCategory(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 2) }
function GetMovePower(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 3) }
function GetMoveAccurancy(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 4) }
function GetMovePP(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 5) }
function GetMoveEffect(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 6) }
function GetMoveEffectChance(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 7) }
function GetMoveCritMultiplier(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 8) }
function GetMovePriority(moveName) { return ds_list_find_value(GetMoveDetails(moveName), 9) }
#endregion

function LearnMove(pkmnInfo, moveName, pos)
{
	var movesList = GetMoves(pkmnInfo)
	var movesPPList = GetMovePPList(pkmnInfo)
	if (ds_list_size(movesList) < 4)
	{
		ds_list_add(movesList, moveName)
		ds_list_add(movesPPList, GetMovePP(moveName))
	}
	else
	{
		ds_list_replace(movesList, pos, moveName)
		ds_list_replace(movesPPList, pos, GetMovePP(moveName))
	}
}

/// @param {string}   name    The name of the Pokémon to search the learnset of
/// @param {string}   level   The level to check if the given Pokémon learns a move at
/// @description              Returns the name of any move the Pokémon might learn at the given level.
function LearnsMoveAt(name, level)
{
	var moveInfo = ds_list_create()
	switch (name)
    {
        //--------------------------------
        // Official Pokémon
        //--------------------------------
        case "Pikachu":
            if (level == 1)  return "Thunder Shock";
            if (level == 4)  return "Quick Attack";
            if (level == 8)  return "Set Trap";
            if (level == 12) return "Electro Ball";
			//if (level == 16) return "Growl";
			//if (level == 17) return "Tackle";
            break;

        case "Voltorb":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Thunder Shock";
            if (level == 8)  return "Self-Destruct";
			if (level == 9)  return "Thunder Wave";
            if (level == 12) return "Explosion";
            break;

        case "Caterpie":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "String Shot";
            if (level == 8)  return "Bug Bite";
			if (level == 10)  return "Leech Life";
            if (level == 12) return "Confusion";
			if (level == 16) return "Gust";
            break;

        case "Magnemite":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Thunder Shock";
            if (level == 8)  return "Thunderbolt";
            if (level == 12) return "Iron Defense";
            break;

        case "Butterfree":
            if (level == 1)  return "Confusion";
            if (level == 4)  return "Gust";
            if (level == 8)  return "Psychic";
            if (level == 12) return "Play Rough";
			if (level == 16) return "Shadow Ball";
            break;

        case "Charmander":
            if (level == 1)  return "Scratch";
            if (level == 4)  return "Ember";
            if (level == 8)  return "Fire Fang";
            if (level == 12) return "Slash";
			if (level == 16) return "Giga Impact";
            break;

        case "Charmandorian":
            if (level == 1)  return "Ember";
            if (level == 4)  return "Dragon Breath";
            if (level == 8)  return "Slash";
            if (level == 12) return "Fire Blast";
            break;

        case "Charmandalorian":
            if (level == 1)  return "Wing Attack";
            if (level == 4)  return "Slash";
            if (level == 8)  return "Fire Blast";
            if (level == 12) return "Giga Impact";
            break;

        case "Clefairy":
            if (level == 1)  return "Pound";
            if (level == 4)  return "Sing";
            if (level == 8)  return "Play Rough";
            if (level == 12) return "Moonblast";
            break;

        case "Squirtle":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Water Gun";
            if (level == 8)  return "Aqua Tail";
            if (level == 12) return "Hydro Pump";
            break;

      // case "Blastoise":
      //     if (level == 1)  return "Water Gun";
      //     if (level == 4)  return "Bite";
      //     if (level == 8)  return "Hydro Pump";
      //     if (level == 12) return "Giga Impact";
      //     break;

        case "Snorlax":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Lick";
            if (level == 8)  return "Body Slam";
			if (level == 12) return "Crunch";
            if (level == 15) return "Giga Impact";
            break;

        //--------------------------------
        // Story-Specific & Custom Pokémon
        //--------------------------------
		case "Pikmin":
			if (level == 1) return "Pound";
			if (level == 5) return "Crunch";
			if (level == 13) return "Storm Throw";
			break
			
        case "Kirby":
            if (level == 1)  return "Inhale";
            if (level == 5)  return "Play Rough";
            if (level == 10) return "Aura Sphere";
            if (level == 15) return "Iron Defense";
            break;

        case "Ape-Ball":
            if (level == 1)  return "Dynamic Punch";
            if (level == 5)  return "Bulldoze";
            if (level == 10) return "Rock Tomb";
            if (level == 13) return "Storm Throw";
			if (level == 16) return "Giga Impact";
            break;

        case "Demogorgon":
            if (level == 1)  return "Hypnosis";
            if (level == 5)  return "Psychic";
            if (level == 10) return "Dual Strike";
            if (level == 15) return "Giga Impact";
            break;

        case "MissingNo":
            if (level == 1)  return "Flux";
			if (level == 5)  return "Hyper Beam";
            break;

        case "Creeper":
            if (level == 1)  return "Self-Destruct";
            if (level == 8)  return "Explosion";
            if (level == 16) return "Giga Impact";
            break;

        case "Ewok":
            if (level == 1)  return "Grassy Surge";
			if (level == 4)  return "Vine Whip";
            if (level == 8)  return "Set Trap";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Wicket's Reversal";
            break;

        case "Xenomorph":
            if (level == 1)  return "Scratch";
            if (level == 5)  return "Acid Blood";
            if (level == 10) return "Bite";
            if (level == 15) return "Shadow Claw";
            break;

        case "Yo’ster":
            if (level == 1)  return "Tackle";
            if (level == 5)  return "Egg Throw";
            if (level == 10) return "Double Kick";
            if (level == 15) return "Mega Punch";
            break;

        case "Pac-Man":
            if (level == 1)  return "Bite";
            if (level == 5)  return "Rollout";
            if (level == 10) return "Crunch";
            if (level == 15) return "Hyper Beam";
            break;

		case "Human":
			if (level == 1) return "Scratch"
			if (level == 4)  return "Growl";
		    if (level == 8)  return "Headbutt";
		    if (level == 12) return "Bite";
			break
			
        case "Fig":
            if (level == 1)  return "Vine Whip";
            if (level == 4)  return "Grassy Surge";
            if (level == 8)  return "Leech Life";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Giga Impact";
            break;
			
		case "Baby":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Headbutt";
            if (level == 12) return "Bite";
            break;
			
		case "Zoombini":
            if (level == 1)  return "Convince";
            if (level == 4)  return "Logic";
            if (level == 8)  return "Confusion";
            if (level == 12) return "Psychic";
            break;
			
		   case "Woob-Wüb":
            if (level == 1)  return "Lick";
            if (level == 4)  return "Hail Mary Hit";
            if (level == 8)  return "Doom Downgrade";
            if (level == 12) return "Hex Roulette";
            break;

        case "Envy":
            if (level == 1)  return "Growl";
            if (level == 4)  return "Water Gun";
            if (level == 8)  return "Crunch";
            if (level == 12) return "Shadow Ball";
            break;

        case "Ninja Squirtle":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Water Gun";
            if (level == 8)  return "Quick Attack";
            if (level == 12) return "Jump Kick";
            if (level == 16) return "Crunch";
            break;

        case "Omega Squirtle":
            if (level == 1)  return "Water Gun";
            if (level == 4)  return "Withdraw";
            if (level == 8)  return "Iron Defense";
            if (level == 12) return "Ice Beam";
            if (level == 16) return "Giga Impact";
            break;

        case "Umbrian":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Bite";
            if (level == 12) return "Crunch";
            if (level == 16) return "Shadow Ball";
            break;

        case "Box Bot":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Thunder Shock";
            if (level == 8)  return "Iron Defense";
            if (level == 12) return "Thunderbolt";
            if (level == 16) return "Giga Impact";
            break;

        case "Tutorial Bot":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Quick Attack";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Giga Impact";
            break;
			
        case "BB-8":
            if (level == 1)  return "Interface";
            if (level == 4)  return "Thunder Shock";
            if (level == 8)  return "Thunderbolt";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Quick Attack";
            break;

        case "Moosephant":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Bulldoze";
            if (level == 8)  return "Headbutt";
            if (level == 12) return "Rock Tomb";
            if (level == 16) return "Giga Impact";
            break;

        case "ZooChomper":
            if (level == 1)  return "Bite";
            if (level == 4)  return "Headbutt";
            if (level == 8)  return "Crunch";
            if (level == 12) return "Shadow Ball";
            if (level == 16) return "Giga Impact";
            break;

        case "Silver Scorpion":
            if (level == 1)  return "Poison Sting";
            if (level == 4)  return "String Shot";
            if (level == 8)  return "Bite";
            if (level == 12) return "Acid Blood";
            if (level == 16) return "Crunch";
            break;

        case "Tribble":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Headbutt";
            if (level == 12) return "Bite";
            if (level == 16) return "Giga Impact";
            break;
			
		case "Zergling":
            if (level == 1)  return "Bite";
            if (level == 4)  return "Leech Life";
            if (level == 8)  return "Dual Strike";
            if (level == 12) return "Crunch";
            if (level == 16) return "Giga Impact";
            break;

        case "Morlock":
            //if (level == 8)  return "Tackle";
            //if (level == 4)  return "Bite";
            if (level == 1)  return "Headbutt";
            //if (level == 12) return "Crunch";
            break;
			
		case "Rancor":
            if (level == 1)  return "Bite";
            if (level == 4)  return "Headbutt";
            if (level == 8)  return "Crunch";
            if (level == 12) return "Bulldoze";
            if (level == 16) return "Giga Impact";
            break;

        case "Porg":
            if (level == 1)  return "Gust";
            if (level == 4)  return "Quick Attack";
            if (level == 8)  return "Drill Peck";
            if (level == 12) return "Bite";
            if (level == 16) return "Giga Impact";
            break;
		case "Caelian":
            if (level == 1)  return "Play Rough";
            if (level == 4)  return "Confusion";
            if (level == 8)  return "Psychic";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Giga Impact";
            break;

        case "Articuno":
            if (level == 1)  return "Gust";
            if (level == 4)  return "Ice Beam";
            if (level == 8)  return "Drill Peck";
            if (level == 12) return "Psychic";
            break;

        case "Zapdos":
            if (level == 1)  return "Thunder Shock";
            if (level == 4)  return "Gust";
            if (level == 8)  return "Thunderbolt";
            if (level == 12) return "Drill Peck";
            break;

        case "Moltres":
            if (level == 1)  return "Ember";
            if (level == 4)  return "Gust";
            if (level == 8)  return "Drill Peck";
            if (level == 12) return "Crunch";
            break;

        case "Godzooky":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Bite";
            if (level == 8)  return "Headbutt";
            if (level == 12) return "Bulldoze";
            break;

        case "Godzilla":
            if (level == 1)  return "Bite";
            if (level == 4)  return "Bulldoze";
            if (level == 8)  return "Crunch";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Giga Impact";
            break;
			
		case "Licker":
            if (level == 1)  return "Lick";
            if (level == 4)  return "Poison Sting";
            if (level == 8)  return "Bite";
            if (level == 12) return "Shadow Ball";
            if (level == 16) return "Crunch";
            break;
			
		case "Andalite":
            if (level == 1)  return "Confusion";
            if (level == 4)  return "Hypnosis";
            if (level == 8)  return "Psychic";
            if (level == 12) return "Force Lift";
            if (level == 16) return "Giga Impact";
            break;
			
		case "Boo":
            if (level == 1)  return "Lick";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Hypnosis";
            if (level == 12) return "Shadow Punch";
            if (level == 16) return "Shadow Ball";
            break;

        case "Demo Dog":
            if (level == 1)  return "Bite";
            if (level == 4)  return "Scratch";
            if (level == 8)  return "Headbutt";
            if (level == 12) return "Crunch";
            if (level == 16) return "Giga Impact";
            break;

        case "Enderman":
            if (level == 1)  return "Scratch";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Hypnosis";
            if (level == 12) return "Shadow Punch";
            if (level == 16) return "Psychic";
            break;

        case "Glyptoblock":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Ember";
            if (level == 8)  return "Rock Tomb";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Fire Blast";
            break;

        case "Goomba":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Growl";
            if (level == 8)  return "Headbutt";
            if (level == 12) return "Bulldoze";
            if (level == 16) return "Giga Impact";
            break;

        case "King Koopa":
            if (level == 1)  return "Bite";
            if (level == 4)  return "Ember";
            if (level == 8)  return "Iron Defense";
            if (level == 12) return "Fire Blast";
            if (level == 16) return "Giga Impact";
            break;

        case "Koopa":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "Withdraw";
            if (level == 8)  return "Rollout";
            if (level == 12) return "Iron Defense";
            if (level == 16) return "Headbutt";
            break;

        case "Krypton Firefly":
            if (level == 1)  return "Gust";
            if (level == 4)  return "Ember";
            if (level == 8)  return "Quick Attack";
            if (level == 12) return "Wing Attack";
            if (level == 16) return "Fire Blast";
            break;

        case "Metroid":
            if (level == 1)  return "Leech Life";
            if (level == 4)  return "Lick";
            if (level == 8)  return "Hypnosis";
            if (level == 12) return "Acid Blood";
            if (level == 16) return "Psychic";
            break;

        case "Pac-Ghost":
            if (level == 1)  return "Lick";
            if (level == 4)  return "Bite";
            if (level == 8)  return "Hypnosis";
            if (level == 12) return "Shadow Punch";
            if (level == 16) return "Shadow Ball";
            break;

        case "Squirrel":
            if (level == 1)  return "Scratch";
            if (level == 4)  return "Quick Attack";
            if (level == 8)  return "Bite";
            if (level == 12) return "Double Kick";
            if (level == 16) return "Body Slam";
            break;

        case "Tektite":
            if (level == 1)  return "Tackle";
            if (level == 4)  return "String Shot";
            if (level == 8)  return "Poison Sting";
            if (level == 12) return "Jump Kick";
            if (level == 16) return "Leech Life";
            break;

        case "Yodal":
            if (level == 1)  return "Confusion";
            if (level == 4)  return "Hypnosis";
            if (level == 8)  return "Force Lift";
            if (level == 12) return "Aura Sphere";
            if (level == 16) return "Psychic";
            break;


		default:
			if (level == 1) return "Scratch"
			break
    }
	return ""
}

/// @param {string}   name    The name of the Pokémon to get the natural moveset of
/// @param {string}   level   The level to use as reference for retreiving the moves
/// @description              Returns a DS list with the last four moves the given Pokémon can learn.
function GetLevelUpMoveset(name, level)
{
	var moveset = ds_list_create()
	var j = 0
	for (var i = level; i > 0; i--)
	{
		var move = LearnsMoveAt(name, i)
		if (move != "" and ds_list_size(moveset) < 4) ds_list_add(moveset, move)
	}
	return moveset
}

/// @param        level       The level to calculate the exp floor
/// @param        growthRate  The growth rate to calculate the exp floor
/// @description              Returns the level's exp floor
function GetExpLevelFloor(level, growthRate)
{
	switch (growthRate)
	{
		case "Very Fast":
			return 10000/100*level
		case "Fast":
			return 11000/100*level
		case "Average":
			return 11500/100*level
		case "Slow":
			return 12000/100*level
		case "Very Slow":
			return 12500/100*level
	}
}

/// @param           pkmn     The Pokémon to get the level's exp percentage of
/// @description              Returns the Pokémon's exp percentage
function GetExpPercentage(pkmn)
{
	var level = GetLevel(pkmn)
	var growthRate = GetGrowth(pkmn)

	var expFloor = GetExpLevelFloor(level, growthRate)
	var expCeiling = GetExpLevelFloor(level+1, growthRate)

	var currentExp = GetExp(pkmn)
	if (level > 1) currentExp -= expFloor
	var expToNext = expCeiling-expFloor

	var perc = currentExp/expToNext*100
	return perc
}

/// @param        learnset    The learnset to retrieve info about
/// @description              Returns a list with the PP info for every move in the learnset list
function GetLearnsetPP(learnset)
{
	var list = ds_list_create()
	for (var i = 0; i < ds_list_size(learnset); i++)
	{
		var attempt = ds_list_find_value(learnset, i)
		ds_list_add(list, GetMovePP(attempt))
	}
	return list
}

/// @param        pkmnInfo    The Pokémon's info list
/// @param        index       The index of the move to consume PP
/// @description              Updates the PP of the chosen move to consume 1 PP
function ConsumePP(pkmnInfo, index)
{
	var movePPList = ds_list_find_value(pkmnInfo, 7)
	var ppValue = ds_list_find_value(movePPList, index)

	if (ppValue-1 >= 0)
	{
		ds_list_set(movePPList, index, ppValue-1)
		ds_list_set(pkmnInfo, 7, movePPList)
	}
}

/// @param       name          The fainted Pokémon's name
/// @description               Gets the defeated Pokémon's base EXP yield value
function GetBaseYield(name)
{
	return 100
}

/// @param       name          The fainted Pokémon's name
/// @param       level         The fainted Pokémon's level
/// @param       pokemonCount  The number of Pokémon involved in the battle
/// @description               Gets the EXP yield value to be given to the involved Pokémon
function GetEXPYield(name, level, pokemonCount, luckyEgg, isTrainer)
{
	var baseYield = GetBaseYield(name)
	var luckyEggValue = 1
	var isTrainerValue = 1

	if (luckyEgg) luckyEggValue = 1.5
	if (isTrainer) isTrainerValue = 1.5

	return floor((baseYield*level/7)*(1/pokemonCount)*luckyEggValue*isTrainerValue)
}

/// @param {Id.DsList} team
/// @param {Real} index
/// @param {Real} amount
/// @param {Bool} isPlayer
/// @param {Bool} healStatus
/// @param {Bool} recoverPP
function HealPokemon(team, index, amount, isPlayer, healStatus, recoverPP)
{
	var pkmnInfo = ds_list_find_value(team, index)
	var name = GetName(pkmnInfo)
	var level = GetLevel(pkmnInfo)

	var maxHealth = GetHPStat(GetPokemonFinalStats(name, level))
	var currentHealth = GetHealth(pkmnInfo)

	if (currentHealth+amount > maxHealth) ds_list_set(pkmnInfo, 5, maxHealth)
	else ds_list_set(pkmnInfo, 5, currentHealth+amount)

	if (healStatus) ClearStatus(pkmnInfo)

	if (recoverPP)
	{
		var movePPList = GetMovePPList(pkmnInfo)
		for (var i = 0; i < ds_list_size(movePPList); i++)
		{
			var moveList = GetMoves(pkmnInfo)
			var moveMaxPP = GetMovePP(ds_list_find_value(moveList, i))
			SetMovePP(movePPList, i, moveMaxPP)
		}
	}

	if (instance_number(BattleObject) > 0)
	{
		var pkmnEntity = noone
		for (var i = 0; i < instance_number(BattlePokemonObject); i++)
		{
			var attempt = instance_find(BattlePokemonObject, i)
			if (isPlayer and attempt.playerTeam) pkmnEntity = attempt
			else if (!isPlayer and !attempt.playerTeam) pkmnEntity = attempt
		}

		if (pkmnEntity != noone) pkmnEntity.hp = GetHealth(pkmnInfo)
	}
}

function GetNameByNumber(num)
{
	switch (num)
	{
		case "001": return "Creeper"
		case "002": return "Krypton Firefly"
		case "004": return "Baby"
		case "005": return "Zoombini"
		case "006": return "Voltorb"
		case "007": return "Caterpie"
		case "008": return "Butterfree"
		//case "009": return "Clefairy"
		case "010": return "Woob-Wüb"
		case "011": return "Pikachu"
		case "012": return "Squirtle"
		case "013": return "Charmander"
		case "014": return "Snorlax"
		case "003": return "Envy"
		case "015": return "Ninja Squirtle"
		case "016": return "Omega Squirtle"
		case "017": return "Charmandorian"
		case "018": return "Charmandalorian"
		case "019": return "Ape-Ball"
		case "020": return "Fig"
		case "021": return "Umbrian"
		//case "022": return "Baby"
		case "023": return "Box Bot"
		case "024": return "Tutorial Bot"
		case "025": return "BB-8"
		case "026": return "Moosephant"
		case "027": return "ZooChomper"
		case "028": return "Silver Scorpion"
		case "029": return "Tribble"
		case "030": return "Ewok"
		case "031": return "Yodal"
		case "032": return "Human"
		case "033": return "Squirrel"
		case "034": return "Goomba"
		case "035": return "Koopa"
		case "036": return "King Koopa"
		case "037": return "Boo"
		case "038": return "Yo’ster"
		case "039": return "Tektite"
		case "040": return "Pac-Man"
		case "041": return "Pac-Ghost"
		case "042": return "Enderman"
		case "043": return "Pikmin"
		case "044": return "Glyptoblock"
		case "045": return "Kirby"
		case "046": return "Metroid"
		case "047": return "Demo Dog"
		case "048": return "Demogorgon"
		case "049": return "Licker"
		case "050": return "Andalite"
		case "051": return "Xenomorph"
		case "052": return "Zergling"
		case "053": return "Morlock"
		case "054": return "Rancor"
		case "055": return "Porg"
		case "056": return "Caelian"
		case "057": return "MissingNo"
		case "058": return "Articuno"
		case "059": return "Zapdos"
		case "060": return "Moltres"
		case "061": return "Godzooky"
		case "062": return "Godzilla"
		
		default: return "Creeper"
	}
}

function GetNumberByName(name)
{
	switch (name)
	{
		case "Creeper": return "001"
		case "Krypton Firefly": return "002"
		case "Envy": return "003"
		case "Pikachu": return "011"
		case "Squirtle": return "012"
		case "Charmander": return "013"
		case "Snorlax": return "014"
				case "Baby": return "004"
		case "Zoombini": return "005"
		case "Voltorb": return "006"
		case "Caterpie": return "007"
		case "Butterfree": return "008"
		case "Woob-Wüb": return "010"
		case "Ninja Squirtle": return "015"
		case "Omega Squirtle": return "016"
		case "Charmandorian": return "017"
		case "Charmandalorian": return "018"
		case "Ape-Ball": return "019"
		case "Fig": return "020"
		case "Umbrian": return "021"
		case "Box Bot": return "023"
		case "Tutorial Bot": return "024"
		case "BB-8": return "025"
		case "Moosephant": return "026"
		case "ZooChomper": return "027"
		case "Silver Scorpion": return "028"
		case "Tribble": return "029"
		case "Ewok": return "030"
		case "Yodal": return "031"
		case "Human": return "032"
		case "Squirrel": return "033"
		case "Goomba": return "034"
		case "Koopa": return "035"
		case "King Koopa": return "036"
		case "Boo": return "037"
		case "Yo’ster": return "038"
		case "Tektite": return "039"
		case "Pac-Man": return "040"
		case "Pac-Ghost": return "041"
		case "Enderman": return "042"
		case "Pikmin": return "043"
		case "Glyptoblock": return "044"
		case "Kirby": return "045"
		case "Metroid": return "046"
		case "Demo Dog": return "047"
		case "Demogorgon": return "048"
		case "Licker": return "049"
		case "Andalite": return "050"
		case "Xenomorph": return "051"
		case "Zergling": return "052"
		case "Morlock": return "053"
		case "Rancor": return "054"
		case "Porg": return "055"
		case "Caelian": return "056"
		case "MissingNo": return "057"
		case "Articuno": return "058"
		case "Zapdos": return "059"
		case "Moltres": return "060"
		case "Godzooky": return "061"
		case "Godzilla": return "062"

		default: return "001"
	}
}

function GetSpriteByNumber(num)
{
	switch (num)
	{
		case "001": return CreeperSprite
		case "002": return KryptonFireflySprite
		case "003": return EnvySprite
		case "004": return BabyBattleSprite
		case "005": return ZoombiniHoveringSprite
		case "006": return VoltorbOverworldSprite
		case "007": return CaterpieIdleSprite
		case "008": return ButterfreeFlyLeftSprite
		//case "009": return "Clefairy"
		case "010": return WoobWubBattleSprite
		case "011": return PikachuIdleSprite
		case "012": return SquirtleIdleSprite
		case "013": return CharmanderBattleSprite
		case "014": return SnorlaxIdleSprite
		case "015": return NinjaSquirtleSprite
		case "016": return OmegaSquirtleSprite
		case "017": return CharmandorianSprite
		case "018": return CharmandalorianSprite
		case "019": return ApeBallSprite
		case "020": return FigOverworldSprite
		case "021": return UmbrianOverworldSprite
		//case "022": return (Baby - Duplicate)
		case "023": return BoxBotIdleSprite
		case "024": return TutorialBotSprite
		case "025": return BB8BattleSprite
		case "026": return MoosephantOverworldSprite
		case "027": return ZoochomperBattleSprite
		case "028": return SIlverScorpionOverworldSprite
		case "029": return TribbleBattleSprite
		case "030": return EwokOverworldSprite
		case "031": return YodalBattleSprite
		case "032": return Human2IdleSprite
		case "033": return SquirrelOverworldSprite
		case "034": return GoombaOverworldSprite
		case "035": return KoopaWalkRightSprite
		case "036": return KingKoopaBattleSprite
		case "037": return BooOverworldSprite
		case "038": return YoSterOverworldSprite
		case "039": return TektiteIdleSprite
		case "040": return PacManWalkRight_Strip3
		case "041": return PacGhostOverworldSprite
		case "042": return EndermanOverworldSprite
		case "043": return PikminIdleSprite
		case "044": return GlyptoblockSprite
		case "045": return KirbySprite
		case "046": return MetroidOverworldSprite
		case "047": return DemoDogSprite
		case "048": return DemogorgonBattleSprite
		case "049": return LickerOverworldSprite
		case "050": return AndaliteOverworldSprite
		case "051": return XenomorphOverworldSprite
		case "052": return ZerglingSprite
		case "053": return MorlockBattleSprite
		case "054": return RancorOverworldSprite
		case "055": return PorgBattleSprite
		case "056": return CaelianBattleSprite
		case "057": return MissingNoIdleSprite
		case "058": return ArticunoSprite
		case "059": return ZapdosOverworldSprite
		case "060": return MoltresOverworldSprite
		case "061": return GodzookyOverworldSprite
		case "062": return GodzillaSprite

		default: return CreeperSprite
	}
}

function GetTitleByNumber(num)
{
	switch (GetNameByNumber(num))
	{
		case "Pikachu": return "The Mouse Pokémon"
		case "Envy": return "The Aquatic Shadow Pokémon"
		case "Creeper": return "The Exploding Moss Pokémon"
		case "Krypton Firefly": return "The Pokémon of Steel"
		case "Baby": return "The Adorable Bot Pokémon"
		case "Zoombini": return "The Puzzling Pokémon"
		case "Voltorb": return "The Ball Pokémon"
		case "Caterpie": return "The Worm Pokémon"
		case "Butterfree": return "The Butterfly Pokémon"
		case "Woob-Wüb": return "The Unluckiest Pokémon"
		case "Squirtle": return "The Tiny Turtle Pokémon"
		case "Charmander": return "The Lizard Pokémon"
		case "Snorlax": return "The Sleeping Pokémon"
		case "Ninja Squirtle": return "The Teenage Muta-quatic Pokémon"
		case "Omega Squirtle": return "The Omniscient Turtle Pokémon"
		case "Charmandorian": return "The Frostfire Lizard Pokémon"
		case "Charmandalorian": return "The Armored Hunter Pokémon"
		case "Ape-Ball": return "The Spiked Ape Pokémon"
		case "Fig": return "The Undeserving Pokémon"
		case "Umbrian": return "The Masked Shadow Pokémon"
		case "Box Bot": return "The Cardboard Bot Pokémon"
		case "Tutorial Bot": return "The Guidebot Pokémon"
		case "BB-8": return "The Roller Droid Pokémon"
		case "Moosephant": return "The Antlered Trunk Pokémon"
		case "ZooChomper": return "The Voracious Chomp Pokémon"
		case "Silver Scorpion": return "The Metal Stinger Pokémon"
		case "Tribble": return "The Fuzzy Swarm Pokémon"
		case "Ewok": return "The Forest Warrior Pokémon"
		case "Yodal": return "The Swamp Sage Pokémon"
		case "Human": return "The Person Pokémon"
		case "Squirrel": return "The Nut Gatherer Pokémon"
		case "Goomba": return "The Grumpy Shroom Pokémon"
		case "Koopa": return "The Troopa Turtle Pokémon"
		case "King Koopa": return "The Spiked Turtle Pokémon"
		case "Boo": return "The Shy Ghost Pokémon"
		case "Yo’ster": return "The Saddleback Dino Pokémon"
		case "Tektite": return "The Leaping Arachnid Pokémon"
		case "Pac-Man": return "The Hungry Maze Pokémon"
		case "Pac-Ghost": return "The Maze Haunting Pokémon"
		case "Enderman": return "The Warp Slender Pokémon"
		case "Pikmin": return "The Tiny Helper Pokémon"
		case "Kirby": return "The Puffball Pokémon"
		case "Metroid": return "The Parasitic Jellyfish Pokémon"
		case "Demo Dog": return "The Demohound Pokémon"
		case "Demogorgon": return "The Upside-Down Horror Pokémon"
		case "Licker": return "The Long Tongue Pokémon"
		case "Andalite": return "The Tail Blade Pokémon"
		case "Xenomorph": return "The Perfect Organism Pokémon"
		case "Zergling": return "The Swarmling Pokémon"
		case "Morlock": return "The Tunnel Predator Pokémon"
		case "Rancor": return "The Pit Beast Pokémon"
		case "Porg": return "The Cliffbird Pokémon"
		case "Caelian": return "The Ascended Pokémon"
		case "MissingNo": return "The Glitch Pokémon"
		case "Articuno": return "The Freeze Pokémon"
		case "Zapdos": return "The Electric Pokémon"
		case "Moltres": return "The Flame Pokémon"
		case "Godzooky": return "The Bumbling Dragon Pokémon"
		case "Godzilla": return "The King of all Pokémon"

	}
	return "The Test Pokemon"
}

function GetDescriptionByNumber(num)
{
	switch (GetNameByNumber(num))
	{
		case "Pikachu": return "This Pokémon has electricity-storing pouches on its cheeks. These appear to become electrically charged during the night while Pikachu sleeps. It occasionally discharges electricity when it is dozy after waking up. When it releases pent-up energy in a burst, the electric power is equal to a lightning bolt."//"This is a test description, the first one that was made."
		case "Squirtle": return "Shoots water at prey while in the water. Withdraws into its shell when in danger."
		case "Creeper": return "This Pokémon is made from blocks of peat moss. It waits till another Pokémon is nearby, builds up air in its sacks, and explodes concussively, discharging its spores and destroying everything nearby."
		case "Krypton Firefly": return "This Pokémon is said to originate from a long-dead planet in deep space. Due to Earth’s lighter gravity, the Firefly has become an incredibly fast flier with durable skin. It also breathes fire. "
		case "Envy": return "This aquatic Pokémon is part of the shadowy Umbrian family. It’s so envious of the living, its hairs have each taken the form of a beautiful woman. These lure men into the water, where they’re dragged down to their deaths. "
		case "Baby": return "This robotic Pokémon has no appendages and so it can’t do much. However, its boxy structure is mostly hollow, allowing it to store items."
		case "Zoombini": return "This Pokémon doesn’t have any hands but is highly intelligent, having great logic skills. It’s also very friendly and trusting of other creatures. Xenophobia is unknown amongst the Zoombinis. "
		case "Voltorb": return "This Pokémon is the result of Poké-balls malfunctioning with a Pokémon inside. The resulting bio-technological hybrid can draw on the Poké-ball’s energy source to provide devastating shocks.  "
		case "Caterpie": return "Its feet have suction cups designed to stick to any surface. It tenaciously climbs trees to forage. If you touch the feeler on top of its head, it will release a horrible stink to protect itself."
		case "Butterfree": return "The Powder on its wings is both poisonous and water-resistant, allowing it to fly in the rain and also harm its enemies when it blows the dust at them. "
		case "Woob-Wüb": return "The unluckiest Pokémon in the Universe. Woob-Wüb is extremely likely to die if left to its own devices. Even the tamest environments are too dangerous for Woob-Wüb. Because of this, Pokémon trainers are attracted to them due to the challenge of keeping them alive."
		case "Charmander": return "The flame that burns at the tip of its tail is an indication of its emotions. The flame wavers when Charmander is happy, and blazes when it is enraged."
		case "Snorlax": return "This Pokémon just eats and sleeps. As its rotund bulk builds, it becomes steadily more slothful. Will eat anything, even if the food happens to be a little moldy. It never gets an upset stomach."
		case "Ninja Squirtle": return "This Squirtle has learned the ways of the Ninja -- and developed a taste for pizza!"
		case "Omega Squirtle": return "This Pokémon has gained so much mastery of the Aquatic Ninja Arts that it's partway ascended beyond this realm - into some eternal watery cosmos! Its mind can see beyond the veil of this world, and sometimes, even into the minds of other Pokémon!!"
		case "Charmandorian": return "This Pokémon has evolved a tolerance for cold, icy climates in addition to his usual firey disposition! It's also developed antennae, which help it detect its surroundings - even in the dark."
		case "Charmandalorian": return "Charmander's final evolution. This pokémon has developed Beskar armor and become an unstoppable Pokémon hunter, in addition to its fire abilities and cold resistance!"
		case "Ape-Ball": return "This Pokémon is extremely fast and deadly. Their fur is comprised of ultra-sharp spikes, sharp enough to kill someone even with a casual touch. They can overtake their prey from across a large room before the prey even starts running. "
		case "Fig": return "This Pokémon exists in a constant state of self-hatred. Figs don’t consider themselves deserving of any good things, including success, freedom, or even life itself. They will gladly sacrifice themselves to a greater being. For this reason they are extremely docile and easy to capture, though they’re not much use in a fight. However, a few trainers claim they’ve unlocked some extraordinary abilities in their Figs. "
		case "Umbrian": return "These shadow Pokémon were once people, now bound to their mask. If the mask is broken, the Umbrian can no longer remain on this plane. "
		case "Box Bot": return "This robotic Pokémon has flexible arms and legs, which make it adept at tasks like delivering the mail. "
		case "Tutorial Bot": return "This robotic Pokémon hovers in midair. It’s also extremely adept at providing ineffective tutorials. However, its hands, made of blocks, can’t grasp anything. "
		case "BB-8": return "This robotic Pokémon is effective at interfacing with computer systems, especially those aboard a vehicle. It greatly enhances that vehicle’s performance in battles. "
		case "Moosephant": return "This Pokémon is perpetually surprised at its own existence. It’s otherwise pretty laid-back and relaxed. "
		case "ZooChomper": return "This Pokémon can absorb anything. When it does, it can take on its characteristics, gaining new abilities. This includes inanimate objects."
		case "Silver Scorpion": return "This Pokémon is small but extremely durable and extremely deadly. One strike from its stinger can kill most Pokémon. It can also withstand pressure equivalent to the ocean bottom. "
		case "Tribble": return "This Pokémon has a soothing effect on most other Pokémon, even on humans. Its coos relax the other Pokémon and make it docile. It’s also an extremely efficient reproducer. "
		case "Ewok": return "It’s skilled with making elaborate traps using foliage. "
		case "Yodal": return "This Pokémon is part of the Human family, having adapted to swampy environments. It can move objects with its mind by interacting with a mysterious force. "
		case "Human": return "This Pokémon is adept at making tools and working together in groups, allowing it to have a civilization. It also created Pokéballs to capture other Pokémon and use them to battle and for other purposes. "
		case "Squirrel": return "This Pokémon is fast and agile. During the winter, it survives on a supply of nuts it’s hidden. "
		case "Goomba": return "This fungus-based Pokémon is easy to defeat by jumping on its head. However they are extremely determined and keep marching no matter what, making them popular soldiers. "
		case "Koopa": return "This turtle-like Pokémon is a loyal soldier. If attacked, it will retreat into its shell. Its shell can slide easily over any surface and builds up enough momentum to knock enemies over. "
		case "King Koopa": return "This Pokémon is extremely powerful, can breathe fire, and believes itself the rightful ruler species of the world, created by Arceus for that purpose. It’s adept at commanding lesser Pokémon and forming an army. King Koopas have also been known to abduct human women for unknown reasons.  "
		case "Boo": return "This Pokémon is extremely shy; when observed, it will stop and cover its face. When not seen, however, in sneaks up and attacks its prey. "
		case "Yo’ster": return "This dinosaur Pokémon eats almost anything and can convert things it eats into eggs nearly immediately, which it throws as a weapon. Humans are fond of riding their yo’sters. "
		case "Tektite": return "This Pokémon attacks by jumping into its prey. They’re not that powerful, but their dexterity makes them difficult to attack and they’re persistent. "
		case "Pac-Man": return "This Pokémon is a voracious eater, able to eat an endless amount of food without gaining weight. It has no natural defense against shadow-type Pokémon, except that when fed energizing food, it can gobble them up for a short time."
		case "Pac-Ghost": return "These Pokémon typically hunt in packs. They surround their prey and feed on them. If destroyed, they can regenerate at the nearest concentration of ghostly energy. "
		case "Enderman": return "These mysterious Pokémon are docile until looked in the eyes. Then they attack viciously. They’re extremely sensitive to water, and when splashed, will run away at super speeds to avoid it. "
		case "Pikmin": return "This plant Pokémon grows as a rooted plant; when uprooted, it becomes extremely loyal to whoever uprooted it, following them and performing tasks for them. "
		case "Kirby": return "This single-celled Pokémon is a distant cousin of the ZooChomper. It can suck up enemies into its mouth and take on some of their characteristics. It can also fly by sucking in air, increasing his volume, and flapping his “nubblies”. "
		case "Metroid": return "This parasitic Pokémon feeds on the life-energy of its prey. "
		case "Glyptoblock": return "There is a pleasant warmth around Glyptoblock. Other Pokémon like lying in its warmth."
		case "Demo Dog": return "About the size of a small dog, this Pokémon’s thick skin and strong muscles make it a serious threat. It can withstand a few gunshots and can climb walls. "
		case "Demogorgon": return "This Pokémon is extremely strong and durable. Its two heads war to control its body, but when their gazes fall upon an enemy they can hypnotize and manipulate it. Demogorgon can smell blood from far off. It can also move objects with its mind and even travel between dimensions. Its main weakness is fire. "
		case "Licker": return "This Pokémon’s long tongue can be used as a deadly weapon, impaling its prey. It’s also adept at climbing walls and can survive multiple gunshots. "
		case "Andalite": return "This Pokémon can acquire the DNA of another Pokémon it touches, and then “morph” into it. If it stays in that shape for too long, it will remain as that Pokémon forever. Its tail is also a deadly weapon and it can see 360 degrees with its stalk eyes. "
		case "Xenomorph": return "This Pokémon is an effective hunter. It can sense its prey’s thoughts to stalk them. Its blood is corrosive acid, able to eat through anything. "
		case "Zergling": return "These Pokémon have a hive mind with other Zerg-types. While individual Zerglings are unintelligent, the hive mind as a whole becomes very intelligent when enough are linked together. Individuals are relatively weak but they’re fast, tending to attack in large numbers unexpectedly. This is known as a “Ling Rush”. "
		case "Morlock": return "This Pokémon evolved from humans, and has learned to feed on other human-types. It’s adept at climbing and operating machinery. It’s used to living in a low-light environment, so bright lights will stun it. "
		case "Rancor": return "This semi-reptilian Pokémon has long arms and an armored hide that make it a fearsome predator, especially in closed quarters. However it’s also very slow.  "
		case "Porg": return "These cliff-dwelling Pokémon dive into the sea to hunt. They’re extremely curious and friendly to human-types. "
		case "Caelian": return "These Pokémon are composed entirely of light, just as Umbrians are composed of shadow. Like Umbrians, they’re bound to the world through their masks, though their masks are actually crystalline prisms to rfract their light as needed. "
		case "MissingNo": return "This Pokémon is the result of an anomalous “glitch” in spacetime. Due to its constant state of quantum flux, humans and Pokémon interacting with it for prolonged periods risk falling into flux themselves. In this way, MissingNo distorts reality around it. "
		case "Articuno": return "A legendary bird Pokémon that can control ice. The flapping of its wings chills the air. As a result, it is said that when this Pokémon flies, snow will fall."
		case "Zapdos": return "A legendary bird Pokémon that is said to appear from clouds while dropping enormous lightning bolts."
		case "Moltres": return "Known as the legendary bird of fire, Moltres has the ability to control fire. If this Pokémon is injured, it is said to dip its body in the molten magma of a volcano to burn and heal itself."
		case "Godzooky": return "This Pokémon can awkwardly fly but is extremely clumsy. It’s friendly and no slouch in a fight, but it sometimes harms itself accidentally."
		case "Godzilla": return "This legendary Pokémon is a gigantic monster, taller than some skyscrapers. Its hide is so durable it can survive most conventional weapons, even from tanks and planes. It also breathes radioactive plasma fire. "
	}
	return "This is a test description, the default one for the forgotten."
}

function GetStatByIndex(i)
{
	switch (i)
	{
		case 0:
			return "HP"
		case 1:
			return "Attack"
		case 2:
			return "Defense"
		case 3:
			return "Special Attack"
		case 4:
			return "Special Defense"
		case 5:
			return "Speed"
	}
}

function GetGameOfOrigin(name)
{
	switch (name)
	{
		case "Pikachu":
		case "Squirtle":
		case "Caterpie":
		case "Butterfree":
		case "Charmander":
		case "Charmandorian":
		case "Snorlax":
		case "MissingNo":
		case "Voltorb":
		case "Articuno":
		case "Moltres":
		case "Zapdos":
			return "Pokémon Red/Blue"
		case "Zoombini":
			return "Logical Journey of the Zoombinis"
		case "Krypton Firefly":
			return "Superman (comic series)"
		case "Creeper":
		case "Enderman":
			return "Minecraft"
		case "Ewok":
		case "Rancor":
			return "Star Wars Episode VI: Return of the Jedi"
		case "Yodal":
			return "Star Wars Episode V: The Empire Strikes Back"
		case "BB-8":
			return "Star Wars Episode VII: The Force Awakens"
		case "Porg":
			return "Star Wars Episode VIII: The Last Jedi"
		case "Koopa":
			return "Mario Bros."
		case "Goomba":
		case "King Koopa":
			return "Super Mario Bros."
		case "Boo": return "Super Mario Bros. 3"
		case "Yo’ster": return "Super Mario World"
		case "Pac-Man":
		case "Pac-Ghost":
			return "Pac-Man"
		case "Pikmin":
			return "Pikmin"
		case "Kirby":
			return "Kirby's Dream Land"
		case "Metroid":
			return "Metroid"
		case "Tribble":
			return "Star Trek – \"The Trouble with Tribbles\""
		case "Demogorgon":
		case "Demo Dog":
			return "Stranger Things"
		case "Licker":
			return "Resident Evil 2"
		case "Andalite":
			return "Animorphs #1: The Invasion"
		case "Xenomorph":
			return "Alien"
		case "Zergling":
			return "StarCraft"
		case "Morlock":
			return "The Time Machine"
		case "Tektite":
			return "The Legend of Zelda"
		case "Envy":
			return "Exile"
		case "Baby":
		case "Ninja Squirtle":
		case "Omega Squirtle":
		case "Charmandalorian":
			return "Pokémon Stop"
		case "Ape-Ball":
		case "Silver Scorpion":
			return "Xaq to the Future"
		case "Fig":
			return "Chrome Training: The New Recruit"
		case "Umbrian":
			return "Genesis"
		case "Box Bot": return "Malphoid the Mailbox-Bot"
		case "Tutorial Bot":
		case "Woob-Wüb":
		case "ZooChomper":
			return "Space-Balls"
		case "Glyptoblock": return "Unfinished Pokémon Fangame / Fakemon Pack"
		case "Moosephant": return "Ghosts! (You !#@&face)"
		case "Human": return "Game Theory - 'Humans are Pokemon'"
		case "Squirrel": return "Squirrels: The PCG"
		case "Caelian": return "Soluna"
		case "Godzooky":
		case "Godzilla":
			return "Godzilla"
		default: return "Test Origin Game"
	}
}

function GetGameDetails(name)
{
	switch (name)
	{
		case "Pikachu":
		case "Squirtle":
		case "Caterpie":
		case "Butterfree":
		case "Charmander":
		case "Charmandorian":
		case "Snorlax":
		case "MissingNo":
		case "Voltorb":
		case "Articuno":
		case "Moltres":
		case "Zapdos":
			return "Video game • 1996 • Nintendo / Game Freak"
		case "Krypton Firefly":
			return "Comic book • 1950s • DC Comics"
		case "Creeper":
		case "Enderman":
			return "Video Game • May, 2009 • Mojang Studios"
		case "Envy":
			return "Paper Computer Game • 2008 • Krierre House"
		case "Zoombini":
			return "Video game • 1996 • Broderbund"
		case "Ewok":
		case "Rancor":
			return "Movie • 1983 • Lucasfilm"
		case "Yodal":
			return "Movie • 1980 • Lucasfilm"
		case "BB-8":
			return "Movie • 2015 • Lucasfilm"
		case "Porg":
			return "Movie • 2017 • Lucasfilm"
		case "Goomba":
		case "King Koopa":
			return "Video game • 1985 • Nintendo"
		case "Koopa": return "Video game • 1983 • Nintendo"
		case "Boo": return "Video Game • 1988 • Nintendo"
		case "Yo’ster": return "Video game • 1990 • Nintendo"
		case "Pac-Man":
		case "Pac-Ghost":
			return "Video game • 1980 • Namco"
		case "Pikmin":
			return "Video game • 2001 • Nintendo"
		case "Kirby":
			return "Video game • 1992 • Nintendo"
		case "Metroid":
			return "Video game • 1986 • Nintendo"
		case "Tribble":
			return "TV Show • 1967 • Paramount Television"
		case "Demogorgon":
		case "Demo Dog":
			return "TV Show • 2016 • Netflix"
		case "Licker":
			return "Video game • 1998 • Capcom"
		case "Andalite":
			return "Book series • 1996 • K.A. Applegate/Scholastic"
		case "Xenomorph":
			return "Movie • 1979 • 20th Century Studios"
		case "Zergling":
			return "Video game • 1998 • Blizzard Entertainment"
		case "Morlock":
			return "Novel • 1895 • H.G. Wells"
		case "Tektite":
			return "Video game • 1986 • Nintendo"
		case "Baby":
		case "Ninja Squirtle":
		case "Omega Squirtle":
		case "Charmandalorian":
			return "Paper Computer Game • 2018 • Xaq"
		case "Ape-Ball":
		case "Silver Scorpion":
			return "Paper Computer Game • 2007(ish) • Keith & Kurt Elfman"
		case "Fig":
			return "Paper Computer Game • 2010 • Xaq"
		case "Umbrian":
			return "Paper Computer Game • 2004(ish) • Krierre House"
		case "Box Bot": return "Paper Computer Game • 2005 • Xaq"
		case "Tutorial Bot":
		case "Woob-Wüb":
		case "ZooChomper":
			return "Paper Computer Game • 2006(ish) • Kurt Elfman"
		case "Moosephant": return "Paper Computer Game • 2017 • Chris"
		case "Glyptoblock": return "Video Game • ??? • Mikitari"
		case "Human": return "YouTube Video • 2014 • MatPat/The Game Theorists"
		case "Squirrel": return "Paper Computer Game • 2018 • Via"
		case "Caelian": return "Tabletop RPG • 2008(ish) • Krierre House"
		case "Godzooky": return "Cartoon Series • 1978 • Hanna-Barbera/Toho"
		case "Godzilla":
			return "Movie • 1954 • Toho"
		default: return "Test Origin Game"
	}
}

function GetGenderChance(species, gender)
{
	switch (species)
	{
		default:
			return 50
	}
}
