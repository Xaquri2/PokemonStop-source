if (!inactive and charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charCounter++
	if (charCounter >= 2)
	{
		charCounter = 0
		charNumber++
		if (charNumber >= string_length(ds_list_find_value(textList, currentText)))
		{
			alarm[2] = 100
		}
	}
}

if (instance_number(ImportantElementParent) > 0 and alarm[2] > 0) alarm[2]++
else if ((damageValue > 0 and damaging) and alarm[2] > 0) alarm[2]++

if (expGainValue > 0 and expGaining)
{
	if (alarm[2] > 0) alarm[2]++
	
	alarm[3] = 5
	var level = GetLevel(playerPkmn)
	if (expGainValue == 1 or GetExp(playerPkmn)+1 >= GetExpLevelFloor(101, GetGrowth(playerPkmn))) expGaining = false

	AddExp(playerPkmn, 1, false)
	expGainValue--

	var levelNew = GetLevel(playerPkmn)
	if (levelNew > level and !leveledUp) leveledUp = true
	if (leveledUp and expGainValue <= 0) ds_list_insert(textList, currentText+1, string_concat("Your Pokemon leveled up to Lvl ", levelNew))

	var newMoveName = LearnsMoveAt(GetName(playerPkmn), levelNew)
	if (leveledUp and ds_list_find_index(listLevelUpMoves, newMoveName) == -1)
		{
		    var moveList = GetMoves(playerPkmn);

		    if (newMoveName != "")
		    {
		        var youWinText = "";

		        if (ds_list_find_value(textList, ds_list_size(textList) - 1) == "You win!")
		        {
		            ds_list_delete(textList, ds_list_size(textList) - 1);
		            youWinText = "You win!";
		        }

		        if (ds_list_size(moveList) < 4)
		        {
		            ds_list_add(
		                textList,
		                string_concat("Your Pokemon learned ", newMoveName, "!")
		            );

		            LearnMove(playerPkmn, newMoveName, -1);
		        }
		        else
		        {
		            ds_list_add(listLevelUpMoves, newMoveName);

		            ds_list_add(
		                textList,
		                string_concat("Your Pokemon wants to learn ", newMoveName, "."),
		                "However, it already knows four moves",
		                "Would you like to replace one?"
		            );
		        }

		        if (youWinText != "")
		        {
		            ds_list_add(textList, youWinText);
		        }
		    }

		    leveledUp = false;
		}

	var activePkmnEntity = noone
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if (attempt.playerTeam)
		{
			activePkmnEntity = attempt
			break
		}
	}

	if (activePkmnEntity != noone)
	{
		var activeIndex = activePkmnEntity.index
		activePkmnEntity.pkmnInfo = playerPkmn
		if (activeIndex >= 0 and activeIndex < ds_list_size(activePkmnEntity.team))
		{
			ds_list_set(activePkmnEntity.team, activeIndex, playerPkmn)
			ds_list_set(global.playerParty, activeIndex, playerPkmn)
		}

		for (var i = 0; i < instance_number(BattleEntityObject); i++)
		{
			var attempt = instance_find(BattleEntityObject, i)
			if (attempt.player) attempt.currentPkmn = activeIndex
		}
	}
}

if (damageValue > 0 and damaging)
{
	// Keep the source for this damage tick even if the attack finishes exactly
	// when HP reaches zero and the live whoAttacked value is cleared below.
	var damageSource = whoAttacked
	var target = noone
	for (var i = 0; i < instance_number(BattleEntityObject); i++)
	{
		var attempt = instance_find(BattleEntityObject, i)
		if ((attempt.player and whoAttacked == "Enemy") or (!attempt.player and whoAttacked == "Player"))
		{
			target = attempt
			break
		}
	}
	if (target == noone)
	{
		damaging = false
		whoAttacked = ""
		exit
	}

	alarm[3] = 5

	if (whoAttacked == "Player") DealDamage(1, true)
	else if (whoAttacked == "Enemy") DealDamage(1, false)
	damageValue -= 1
	
	if (damageValue == 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30
	}

	if (damageSource == "Player" and GetHealth(enemyPkmn) <= 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30

		target.currentPkmn++
		//enemyPkmn = nextPkmn
		nextPkmn = -1
	}
	else if (damageSource == "Enemy" and GetHealth(playerPkmn) <= 0)
	{
		damaging = false
		whoAttacked = ""
		alarm[4] = 30

		// Keep currentPkmn on the fainted Pokemon until the replacement is
		// actually spawned. The Pokeball event commits this pending index.
		target.switchIndex = nextPkmnIndex
		//playerPkmn = nextPkmn
		nextPkmn = -1
	}
}

if (GodzillaFainting == true) {
	var ZillaChance = irandom_range(0,1)
	if (ZillaChance > 0) {
		instance_create_layer(random_range(140,320),random_range(0,288),"Explosions",FireParticle)
	}
	
	sprite_set_offset(GodzillaSprite,sprite_get_xoffset(sprite_index),sprite_get_yoffset(sprite_index) + 0.5)
}
