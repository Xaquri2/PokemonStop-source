function GetDamage(pkmn, targetPkmn, moveName)
{
	var pName = GetName(pkmn)
	var pLevel = GetLevel(pkmn)
	var pStats = GetPokemonFinalStats(pName, pLevel)
	var pType = GetTypes(pkmn)
	
	var eName = GetName(targetPkmn)
	var eLevel = GetLevel(targetPkmn)
	var eStats = GetPokemonFinalStats(eName, eLevel)
	
	var moveType = GetMoveType(moveName)
	var movePower = GetMovePower(moveName)
	var moveAcc = GetMoveAccurancy(moveName)
	var moveCat = GetMoveCategory(moveName)
	var moveCrit = GetMoveCritMultiplier(moveName) //Still needs to be used
	
	var atkStat = 0
	var defStat = 0
	
	if (moveCat != "Status")
	{
		if (moveCat == "Physical")
		{
			atkStat = GetAtkStat(pStats)
			defStat = GetDefStat(eStats)
		}
		else
		{
			atkStat = GetSpAtkStat(pStats)
			defStat = GetSpDefStat(eStats)
		}
	
		if (ds_list_find_value(pType, 0) == moveType or ds_list_find_value(pType, 1) == moveType)
		{
			movePower *= 1.5
		}
	
		var moveEffect = GetMoveEffect(moveName)
		movePower += GetEffectPower(pkmn, targetPkmn, GetMoveEffect(moveName))
	
		if (IsMoveSuperEffective(moveName, targetPkmn)) movePower *= 1.5
		if (IsMoveNotVeryEffective(moveName, targetPkmn)) movePower *= 0.5
	
		var damage = floor((((2 * pLevel / 5) + 2) * movePower * atkStat / defStat) / 50 + 2)
		damage = clamp(damage, 0, 1000000)
	
		if (random_range(0,101) > moveAcc) return 0
		return damage
	}
	else return 0
}

function GetEffectPower(pkmn, targetPkmn, effectName)
{
	switch (effectName)
	{
		case "SpeedPower":
			var userName = GetName(pkmn)
			var userLevel = GetLevel(pkmn)
			var userSpeed = GetSpeedStat(GetPokemonFinalStats(userName, userLevel))
			
			var targetName = GetName(targetPkmn)
			var targetLevel = GetLevel(targetPkmn)
			var targetSpeed = GetSpeedStat(GetPokemonFinalStats(targetName, targetLevel))
			var perc = (targetSpeed/userSpeed)*100
			if (perc >= 100) return 40
			else if (perc > 50 and perc <= 100) return 60
			else if (perc > 33.33 and perc <= 50) return 80
			else if (perc > 25 and perc <= 33.33) return 120
			else if (perc > 0 and perc <= 25) return 150
			return 40
	}
	return 0
}

function IsMoveSuperEffective(moveName, targetPkmn)
{
	var moveType = GetMoveType(moveName)
	var enemyTypes = GetTypes(targetPkmn)
	for (var i = 0; i < ds_list_size(enemyTypes); i++)
	{
		if (IsTypeSuperEffective(moveType, ds_list_find_value(enemyTypes, i))) 
		{
			return true
		}
	}
	return false
}

function IsTypeSuperEffective(type, targetType)
{
    switch (targetType)
    {
        case "Normal":
            // Fighting is super effective against Normal
            if (type == "Fighting") return true;
            break;

        case "Fire":
            // Water, Ground, Rock are super effective against Fire
            if (type == "Water" or type == "Ground" or type == "Rock") return true;
            break;

        case "Water":
            // Electric, Grass are super effective against Water
            if (type == "Electric" or type == "Grass") return true;
            break;

        case "Electric":
            // Ground is super effective against Electric
            if (type == "Ground") return true;
            break;

        case "Grass":
            // Fire, Ice, Poison, Flying, Bug are super effective against Grass
            if (type == "Fire" or type == "Ice" or type == "Poison" or type == "Flying" or type == "Bug") return true;
            break;

        case "Ice":
            // Fire, Fighting, Rock, Steel are super effective against Ice
            if (type == "Fire" or type == "Fighting" or type == "Rock" or type == "Steel") return true;
            break;

        case "Fighting":
            // Flying, Psychic, Fairy are super effective against Fighting
            if (type == "Flying" or type == "Psychic" or type == "Fairy") return true;
            break;

        case "Poison":
            // Ground, Psychic are super effective against Poison
            if (type == "Ground" or type == "Psychic") return true;
            break;

        case "Ground":
            // Water, Grass, Ice are super effective against Ground
            if (type == "Water" or type == "Grass" or type == "Ice") return true;
            break;

        case "Flying":
            // Electric, Ice, Rock are super effective against Flying
            if (type == "Electric" or type == "Ice" or type == "Rock") return true;
            break;

        case "Psychic":
            // Bug, Ghost, Dark are super effective against Psychic
            if (type == "Bug" or type == "Ghost" or type == "Dark") return true;
            break;

        case "Bug":
            // Fire, Flying, Rock are super effective against Bug
            if (type == "Fire" or type == "Flying" or type == "Rock") return true;
            break;

        case "Rock":
            // Water, Grass, Fighting, Ground, Steel are super effective against Rock
            if (type == "Water" or type == "Grass" or type == "Fighting" or type == "Ground" or type == "Steel") return true;
            break;

        case "Ghost":
            // Ghost, Dark are super effective against Ghost
            if (type == "Ghost" or type == "Dark") return true;
            break;

        case "Dragon":
            // Ice, Dragon, Fairy are super effective against Dragon
            if (type == "Ice" or type == "Dragon" or type == "Fairy") return true;
            break;

        case "Dark":
            // Fighting, Bug, Fairy are super effective against Dark
            if (type == "Fighting" or type == "Bug" or type == "Fairy") return true;
            break;

        case "Steel":
            // Fire, Fighting, Ground are super effective against Steel
            if (type == "Fire" or type == "Fighting" or type == "Ground") return true;
            break;

        case "Fairy":
            // Poison, Steel are super effective against Fairy
            if (type == "Poison" or type == "Steel") return true;
            break;

        case "???":
            // Typically ??? has no weaknesses, but feel free to customize
            break;
    }
    return false;
}

function IsMoveNotVeryEffective(moveName, targetPkmn)
{
	var moveType = GetMoveType(moveName)
	var enemyTypes = GetTypes(targetPkmn)
	for (var i = 0; i < ds_list_size(enemyTypes); i++)
	{
		if (IsTypeNotVeryEffective(moveType, ds_list_find_value(enemyTypes, i))) return true
	}
	return false
}

function IsTypeNotVeryEffective(type, targetType)
{
    switch (targetType)
    {
        case "Normal":
            // Fighting is super effective against Normal
            if (type == "Fighting") return true;
            break;

        case "Fire":
            // Water, Ground, Rock are super effective against Fire
            if (type == "Water" or type == "Ground" or type == "Rock") return true;
            break;

        case "Water":
            // Electric, Grass are super effective against Water
            if (type == "Electric" or type == "Grass") return true;
            break;

        case "Electric":
            // Ground is super effective against Electric
            if (type == "Ground") return true;
            break;

        case "Grass":
            // Fire, Ice, Poison, Flying, Bug are super effective against Grass
            if (type == "Fire" or type == "Ice" or type == "Poison" or type == "Flying" or type == "Bug") return true;
            break;

        case "Ice":
            // Fire, Fighting, Rock, Steel are super effective against Ice
            if (type == "Fire" or type == "Fighting" or type == "Rock" or type == "Steel") return true;
            break;

        case "Fighting":
            // Flying, Psychic, Fairy are super effective against Fighting
            if (type == "Flying" or type == "Psychic" or type == "Fairy") return true;
            break;

        case "Poison":
            // Ground, Psychic are super effective against Poison
            if (type == "Ground" or type == "Psychic") return true;
            break;

        case "Ground":
            // Water, Grass, Ice are super effective against Ground
            if (type == "Water" or type == "Grass" or type == "Ice") return true;
            break;

        case "Flying":
            // Electric, Ice, Rock are super effective against Flying
            if (type == "Electric" or type == "Ice" or type == "Rock") return true;
            break;

        case "Psychic":
            // Bug, Ghost, Dark are super effective against Psychic
            if (type == "Bug" or type == "Ghost" or type == "Dark") return true;
            break;

        case "Bug":
            // Fire, Flying, Rock are super effective against Bug
            if (type == "Fire" or type == "Flying" or type == "Rock") return true;
            break;

        case "Rock":
            // Water, Grass, Fighting, Ground, Steel are super effective against Rock
            if (type == "Water" or type == "Grass" or type == "Fighting" or type == "Ground" or type == "Steel") return true;
            break;

        case "Ghost":
            // Ghost, Dark are super effective against Ghost
            if (type == "Ghost" or type == "Dark") return true;
            break;

        case "Dragon":
            // Ice, Dragon, Fairy are super effective against Dragon
            if (type == "Ice" or type == "Dragon" or type == "Fairy") return true;
            break;

        case "Dark":
            // Fighting, Bug, Fairy are super effective against Dark
            if (type == "Fighting" or type == "Bug" or type == "Fairy") return true;
            break;

        case "Steel":
            // Fire, Fighting, Ground are super effective against Steel
            if (type == "Fire" or type == "Fighting" or type == "Ground") return true;
            break;

        case "Fairy":
            // Poison, Steel are super effective against Fairy
            if (type == "Poison" or type == "Steel") return true;
            break;

        case "???":
            // Typically ??? has no weaknesses, but feel free to customize
            break;
    }
    return false;
}

function GetMoveAnimationTime(moveName)
{
	switch (moveName)
	{
		case "Quick Attack":
			return 100
		case "Electro Ball":
			return 140
	}
	return 60
}

function DealDamage(damage, isPlayer)
{
	var entity = -1
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if (!attempt.playerTeam and isPlayer or attempt.playerTeam and !isPlayer)
		{
			entity = attempt
			break
		}
	}

	entity.hp -= damage
	entity.hp = clamp(entity.hp, 0, 9999)

	if (isPlayer) 
	{
		ds_list_set(enemyPkmn, 5, entity.hp)
		ds_list_set(entity.team, entity.index, enemyPkmn)
	}
	else 
	{
		ds_list_set(playerPkmn, 5, entity.hp)
		ds_list_set(entity.team, entity.index, playerPkmn)
		ds_list_set(global.playerParty, entity.index, playerPkmn)
	}
	
	for (var i = 0; i < instance_number(BattleEntityObject); i++)
	{
		var attempt = instance_find(BattleEntityObject, i)
		if (attempt.player)
		{
			ds_list_set(attempt.team, attempt.currentPkmn, playerPkmn)
		}
	}
}

function DealEffect(effectName, accurancy, user, target)
{
	var str = ""
	if (random_range(0,101) <= accurancy)
	{
		switch (effectName)
		{
			#region Lower 1
			case "LowerAttack":
				if (target.attackModifier > -6)
				{
					target.attackModifier -= 1
					str = "It lowered the foe's Attack stat!"
				}
				else str = "The opponent's Attack stat couldn't go any lower!"
				break
			case "LowerDefense":
				if (target.attackModifier > -6)
				{
					target.defenseModifier -= 1
					str = "It lowered the foe's Defense stat!"
				}
				else str = "The opponent's Defense stat couldn't go any lower!"
				break
			case "LowerSpAtk":
				if (target.attackModifier > -6)
				{
					target.spAtkModifier -= 1
					str = "It lowered the foe's Special Attack stat!"
				}
				else str = "The opponent's Special Attack stat couldn't go any lower!"
				break
			case "LowerSpDef":
				if (target.attackModifier > -6)
				{
					target.spDefModifier -= 1
					str = "It lowered the foe's Special Defense stat!"
				}
				else str = "The opponent's Special Defense stat couldn't go any lower!"
				break
			case "LowerSpeed":
				if (target.attackModifier > -6)
				{
					target.speedModifier -= 1
					str = "It lowered the foe's Speed stat!"
				}
				else str = "The opponent's Speed stat couldn't go any lower!"
				break
			#endregion
		
			#region Lower 2
			case "LowerAttack2":
				if (target.attackModifier > -5)
				{
					target.attackModifier -= 2
					str = "It greatly lowered the foe's Attack stat!"
				}
				else str = "The opponent's Attack stat couldn't go any lower!"
				break
			case "LowerDefense2":
				if (target.attackModifier > -5)
				{
					target.defenseModifier -= 2
					str = "It greatly lowered the foe's Defense stat!"
				}
				else str = "The opponent's Defense stat couldn't go any lower!"
				break
			case "LowerSpAtk2":
				if (target.attackModifier > -5)
				{
					target.spAtkModifier -= 2
					str = "It greatly lowered the foe's Special Attack stat!"
				}
				else str = "The opponent's Special Attack stat couldn't go any lower!"
				break
			case "LowerSpDef2":
				if (target.attackModifier > -5)
				{
					target.spDefModifier -= 2
					str = "It greatly lowered the foe's Special Defense stat!"
				}
				else str = "The opponent's Special Defense stat couldn't go any lower!"
				break
			case "LowerSpeed2":
				if (target.attackModifier > -5)
				{
					target.speedModifier -= 2
					str = "It greatly lowered the foe's Speed stat!"
				}
				else str = "The opponent's Speed stat couldn't go any lower!"
				break
			#endregion
		
			#region Raise 1
			case "RaiseAttack":
				if (target.attackModifier < 6)
				{
					user.attackModifier += 1
					str = "It raised the user's Attack stat!"
				}
				else str = "Its Attack stat couldn't go any higher!"
				break
			case "RaiseDefense":
				if (target.attackModifier < 6)
				{
					user.defenseModifier += 1
					str = "It raised the user's Defense stat!"
				}
				else str = "Its Defense stat couldn't go any higher!"
				break
			case "RaiseSpAtk":
				if (target.attackModifier < 6)
				{
					user.spAtkModifier += 1
					str = "It raised the user's Special Attack stat!"
				}
				else str = "Its Special Attack stat couldn't go any higher!"
				break
			case "RaiseSpDef":
				if (target.attackModifier < 6)
				{
					user.spDefModifier += 1
					str = "It raised the user's Special Defense stat!"
				}
				else str = "Its Special Defense stat couldn't go any higher!"
				break
			case "RaiseSpeed":
				if (target.attackModifier < 6)
				{
					user.speedModifier += 1
					str = "It raised the user's Speed stat!"
				}
				else str = "Its Speed stat couldn't go any higher!"
				break
			#endregion
		
			#region Raise 2
			case "RaiseAttack2":
				if (target.attackModifier < 5)
				{
					user.attackModifier += 2
					str = "It greatly raised the user's Attack stat!"
				}
				else str = "Its Attack stat couldn't go any higher!"
				break
			case "RaiseDefense2":
				if (target.attackModifier < 5)
				{
					user.defenseModifier += 2
					str = "It greatly raised the user's Defense stat!"
				}
				else str = "Its Defense stat couldn't go any higher!"
				break
			case "RaiseSpAtk2":
				if (target.attackModifier < 5)
				{
					user.spAtkModifier += 2
					str = "It greatly raised the user's Special Attack stat!"
				}
				else str = "Its Special Attack stat couldn't go any higher!"
			case "RaiseSpDef2":
				if (target.attackModifier < 5)
				{
					user.spDefModifier += 2
					str = "It greatly raised the user's Special Defense stat!"
				}
				else str = "Its Special Defense stat couldn't go any higher!"
				break
			case "RaiseSpeed2":
				if (target.attackModifier < 5)
				{
					user.speedModifier += 2
					str = "It greatly raised the user's Speed stat!"
				}
				else str = "Its Speed stat couldn't go any higher!"
				break
			#endregion
			
			case "Recoil":
			case "RecoilOnMiss":
				str = "The user took some damage!"
				break
		}
	}
	return str
}

function ChooseMove(pkmn, targetPkmn)
{
	var name = GetName(pkmn)
	var level = GetLevel(pkmn)
	
	var stats = GetPokemonFinalStats(name, level)
	var enemyStats = GetPokemonFinalStats(name, level)
	
	var type = GetTypes(pkmn)
	var moves = GetMoves(pkmn)
	
	if (GetSpeedStat(stats) <= GetSpeedStat(enemyStats)) //If user speed is lower
	{
		var hasSpeedControl = false
		for (var i = 0; i < ds_list_size(moves); i++)
		{
			var moveName = ds_list_find_value(moves, i)
			var effect = GetMoveEffect(moveName)
			if (effect == "LowerSpeed") 
			{
				hasSpeedControl = true
				break
			}
		}
		
		if (floor(random_range(0,3)) == 0 and hasSpeedControl) //33% chance to use a speed lowering move
		{
			var chosenMove = ""
			var chosenMoveDmg = 0
			var speedLoweringMoves = ds_list_create()
			for (var i = 0; i < ds_list_size(moves); i++)
			{
				var moveName = ds_list_find_value(moves, i)
				var effect = GetMoveEffect(moveName)
				if (effect == "LowerSpeed") ds_list_add(speedLoweringMoves, moveName)
			}
			for (var i = 0; i < ds_list_size(speedLoweringMoves); i++)
			{
				var moveName = ds_list_find_value(speedLoweringMoves, i)
				var dmg = GetDamage(pkmn, targetPkmn, moveName)
				if (chosenMove == "" or dmg > chosenMoveDmg)
				{
					chosenMove = moveName
					chosenMoveDmg = dmg
				}
			}
			return chosenMove
		}
		else
		{
			if (floor(random_range(0,3)) == 0) //33% chance to use a random move
			{
				var moveName = ds_list_find_value(moves, floor(random_range(0,ds_list_size(moves))))
				return moveName
			}
			else
			{
				var biggerDamage = 0
				var damageList = ds_list_create()
				for (var i = 0; i < ds_list_size(moves); i++)
				{
					ds_list_add(damageList, GetDamage(pkmn, targetPkmn, ds_list_find_value(moves, i)))
				}
				for (var i = 0; i < ds_list_size(damageList); i++)
				{
					var attempt = ds_list_find_value(damageList, i)
					if (attempt > biggerDamage) biggerDamage = attempt
				} 
				var moveName = ds_list_find_value(moves, ds_list_find_index(damageList, biggerDamage))
				return moveName
			}
		}
	}
	else //Choose strongest move
	{
		if (floor(random_range(0,3)) == 0) //33% chance to use a status move
		{
			var moveName = ds_list_find_value(moves, floor(random_range(0,ds_list_size(moves))))
			return moveName
		}
		else
		{
			var biggerDamage = 0
			var damageList = ds_list_create()
			for (var i = 0; i < ds_list_size(moves); i++)
			{
				ds_list_add(damageList, GetDamage(pkmn, targetPkmn, ds_list_find_value(moves, i)))
			}
			for (var i = 0; i < ds_list_size(damageList); i++)
			{
				var attempt = ds_list_find_value(damageList, i)
				if (attempt > biggerDamage) biggerDamage = attempt
			} 
			var moveName = ds_list_find_value(moves, ds_list_find_index(damageList, biggerDamage))
			return moveName
		}
	}
}

function SetFinalStat(stat, modifier)
{
	if (modifier == 0) return stat
	else if (modifier == 1) return stat*1.1
	else if (modifier == 2) return stat*1.25
	else if (modifier == 3) return stat*1.4
	else if (modifier == 4) return stat*1.5
	else if (modifier == 5) return stat*1.75
	else if (modifier == 6) return stat*2
	else if (modifier == -1) return stat*0.75
	else if (modifier == -2) return stat*0.66
	else if (modifier == -3) return stat*0.5
	else if (modifier == -4) return stat*0.4
	else if (modifier == -5) return stat*0.3
	else if (modifier == -6) return stat*0.2
}