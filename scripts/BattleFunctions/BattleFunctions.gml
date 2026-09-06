function FindBattlePokemonEntity(pkmnInfo)
{
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var entity = instance_find(BattlePokemonObject, i)
		if (entity.pkmnInfo == pkmnInfo) return entity
	}

	return noone
}

function GetDamage(pkmn, targetPkmn, moveName)
{
	var pName = GetName(pkmn)
	var pLevel = GetLevel(pkmn)
	var pStats = GetPokemonFinalStats(pName, pLevel)
	var pType = GetTypes(pkmn)

	var eName = GetName(targetPkmn)
	var eLevel = GetLevel(targetPkmn)
	var eStats = GetPokemonFinalStats(eName, eLevel)

	var pEntity = FindBattlePokemonEntity(pkmn)
	var eEntity = FindBattlePokemonEntity(targetPkmn)

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
			if (pEntity != noone) atkStat = pEntity.atk
			else atkStat = GetAtkStat(pStats)

			if (eEntity != noone) defStat = eEntity.def
			else defStat = GetDefStat(eStats)
		}
		else
		{
			if (pEntity != noone) atkStat = pEntity.spatk
			else atkStat = GetSpAtkStat(pStats)

			if (eEntity != noone) defStat = eEntity.spdef
			else defStat = GetSpDefStat(eStats)
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

function GetRecoilDamage(pkmn, moveName)
{
	var name = GetName(pkmn)
	var level = GetLevel(pkmn)
	var dmg = 0

	switch (moveName)
	{
		case "Doom Downgrade":
		case "Hex Roulette":
		case "Hail Mary Hit":
			dmg += GetPokemonFinalHP(name, level)
			break
		case "Self Destruct":
			dmg += GetPokemonFinalHP(name, level)/2
			break
		default:
			dmg += GetPokemonFinalHP(name, level)/4
			break
	}
	
	if (whoAttacked == "Player")
	{
		if (ds_list_find_index(BattleObject.playerFieldEffects, "SetTrap") != -1) dmg += 30
		if (ds_list_find_index(BattleObject.playerFieldEffects, "ReversalTrap") != -1) dmg += playerDamage
	}
	else
	{
		if (ds_list_find_index(BattleObject.enemyFieldEffects, "SetTrap") != -1) dmg += 30
		if (ds_list_find_index(BattleObject.enemyFieldEffects, "ReversalTrap") != -1) dmg += enemyDamage
	}
	
	return dmg
}

function RollCriticalChance(critMod)
{
	var value = floor(random_range(0,101))
	switch (critMod)
	{
		case 0: return value <= 1/24
		case 1: return value <= 1/8
		case 2: return value <= 1/2
		default: return true
	}
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
            break;

        case "Fire":
            if (type == "Fire"
            or type == "Grass"
            or type == "Ice"
            or type == "Bug"
            or type == "Steel"
            or type == "Fairy")
            {
                return true;
            }
            break;

        case "Water":
            if (type == "Fire"
            or type == "Water"
            or type == "Ice"
            or type == "Steel")
            {
                return true;
            }
            break;

        case "Electric":
            if (type == "Electric"
            or type == "Flying"
            or type == "Steel")
            {
                return true;
            }
            break;

        case "Grass":
            if (type == "Water"
            or type == "Electric"
            or type == "Grass"
            or type == "Ground")
            {
                return true;
            }
            break;

        case "Ice":
            if (type == "Ice") return true;
            break;

        case "Fighting":
            if (type == "Bug"
            or type == "Rock"
            or type == "Dark")
            {
                return true;
            }
            break;

        case "Poison":
            if (type == "Grass"
            or type == "Fighting"
            or type == "Poison"
            or type == "Bug"
            or type == "Fairy")
            {
                return true;
            }
            break;

        case "Ground":
            if (type == "Poison"
            or type == "Rock")
            {
                return true;
            }
            break;

        case "Flying":
            if (type == "Grass"
            or type == "Fighting"
            or type == "Bug")
            {
                return true;
            }
            break;

        case "Psychic":
            if (type == "Fighting"
            or type == "Psychic")
            {
                return true;
            }
            break;

        case "Bug":
            if (type == "Grass"
            or type == "Fighting"
            or type == "Ground")
            {
                return true;
            }
            break;

        case "Rock":
            if (type == "Normal"
            or type == "Fire"
            or type == "Poison"
            or type == "Flying")
            {
                return true;
            }
            break;

        case "Ghost":
            if (type == "Poison"
            or type == "Bug")
            {
                return true;
            }
            break;

        case "Dragon":
            if (type == "Fire"
            or type == "Water"
            or type == "Electric"
            or type == "Grass")
            {
                return true;
            }
            break;

        case "Dark":
            if (type == "Ghost"
            or type == "Dark")
            {
                return true;
            }
            break;

        case "Steel":
            if (type == "Normal"
            or type == "Grass"
            or type == "Ice"
            or type == "Flying"
            or type == "Psychic"
            or type == "Bug"
            or type == "Rock"
            or type == "Dragon"
            or type == "Steel"
            or type == "Fairy")
            {
                return true;
            }
            break;

        case "Fairy":
            if (type == "Fighting"
            or type == "Bug"
            or type == "Dark")
            {
                return true;
            }
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
	var entity = noone
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if ((!attempt.playerTeam and isPlayer) or (attempt.playerTeam and !isPlayer))
		{
			entity = attempt
			break
		}
	}
	if (entity == noone)
	{
		return;
	}

	entity.hp -= damage
	entity.hp = clamp(entity.hp, 0, 9999)
	var damagedPkmn = entity.pkmnInfo
	ds_list_set(damagedPkmn, 5, entity.hp)

	if (isPlayer)
	{
		enemyPkmn = damagedPkmn
	}
	else
	{
		playerPkmn = damagedPkmn
	}

	// The on-field Pokemon is authoritative. Never write it to currentPkmn as
	// well as entity.index: those values can temporarily differ during a switch,
	// which used to copy one Pokemon over another party slot.
	if (entity.index >= 0 and entity.index < ds_list_size(entity.team))
	{
		ds_list_set(entity.team, entity.index, damagedPkmn)
	}
	if (entity.playerTeam and entity.index >= 0 and entity.index < ds_list_size(global.playerParty))
	{
		ds_list_set(global.playerParty, entity.index, damagedPkmn)
	}
}

function DealEffect(effectName, accurancy, damage, user, target)
{
	var str = ""
	if (user.playerTeam)
	{
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
						if (target.defenseModifier > -6)
						{
							target.defenseModifier -= 1
							str = "It lowered the foe's Defense stat!"
						}
						else str = "The opponent's Defense stat couldn't go any lower!"
						break
					case "LowerSpAtk":
						if (target.spAtkModifier > -6)
						{
							target.spAtkModifier -= 1
							str = "It lowered the foe's Special Attack stat!"
						}
						else str = "The opponent's Special Attack stat couldn't go any lower!"
						break
					case "LowerSpDef":
						if (target.spDefModifier > -6)
						{
							target.spDefModifier -= 1
							str = "It lowered the foe's Special Defense stat!"
						}
						else str = "The opponent's Special Defense stat couldn't go any lower!"
						break
					case "LowerSpeed":
						if (target.speedModifier > -6)
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
						if (target.defenseModifier > -5)
						{
							target.defenseModifier -= 2
							str = "It greatly lowered the foe's Defense stat!"
						}
						else str = "The opponent's Defense stat couldn't go any lower!"
						break
					case "LowerSpAtk2":
						if (target.spAtkModifier > -5)
						{
							target.spAtkModifier -= 2
							str = "It greatly lowered the foe's Special Attack stat!"
						}
						else str = "The opponent's Special Attack stat couldn't go any lower!"
						break
					case "LowerSpDef2":
						if (target.spDefModifier > -5)
						{
							target.spDefModifier -= 2
							str = "It greatly lowered the foe's Special Defense stat!"
						}
						else str = "The opponent's Special Defense stat couldn't go any lower!"
						break
					case "LowerSpeed2":
						if (target.speedModifier > -5)
						{
							target.speedModifier -= 2
							str = "It greatly lowered the foe's Speed stat!"
						}
						else str = "The opponent's Speed stat couldn't go any lower!"
						break
					case "DoomDowngrade":
						var canLowerStatCount = 5
						if (target.attackModifier > -5) target.attackModifier -= 2
						else canLowerStatCount--
						if (target.defenseModifier > -5) target.defenseModifier -= 2
						else canLowerStatCount--
						if (target.spAtkModifier > -5) target.spAtkModifier -= 2
						else canLowerStatCount--
						if (target.spDefModifier > -5) target.spDefModifier -= 2
						else canLowerStatCount--
						if (target.speedModifier > -5) target.speedModifier -= 2
						else canLowerStatCount--
					
						if (canLowerStatCount == 0) str = "The opponent's stats couldn't go any lower!"
						else str = "Many of the opponent's stats were lowered!"
						break
					#endregion

					#region Raise 1
					case "RaiseAttack":
						if (target.attackModifier < 6)
						{
							user.attackModifier += 1
							str = "It raised your pokemon's Attack stat!"
						}
						else str = "Its Attack stat couldn't go any higher!"
						break
					case "RaiseDefense":
						if (target.defenseModifier < 6)
						{
							user.defenseModifier += 1
							str = "It raised your pokemon's Defense stat!"
						}
						else str = "Its Defense stat couldn't go any higher!"
						break
					case "RaiseSpAtk":
						if (target.spAtkModifier < 6)
						{
							user.spAtkModifier += 1
							str = "It raised your pokemon's Special Attack stat!"
						}
						else str = "Its Special Attack stat couldn't go any higher!"
						break
					case "RaiseSpDef":
						if (target.spDefModifier < 6)
						{
							user.spDefModifier += 1
							str = "It raised your pokemon's Special Defense stat!"
						}
						else str = "Its Special Defense stat couldn't go any higher!"
						break
					case "RaiseSpeed":
						if (target.speedModifier < 6)
						{
							user.speedModifier += 1
							str = "It raised your pokemon's Speed stat!"
						}
						else str = "Its Speed stat couldn't go any higher!"
						break
					#endregion

					#region Raise 2
					case "RaiseAttack2":
						if (target.attackModifier < 5)
						{
							user.attackModifier += 2
							str = "It greatly raised your pokemon's Attack stat!"
						}
						else str = "Its Attack stat couldn't go any higher!"
						break
					case "RaiseDefense2":
						if (target.defenseModifier < 5)
						{
							user.defenseModifier += 2
							str = "It greatly raised your pokemon's Defense stat!"
						}
						else str = "Its Defense stat couldn't go any higher!"
						break
					case "RaiseSpAtk2":
						if (target.spAtkModifier < 5)
						{
							user.spAtkModifier += 2
							str = "It greatly raised your pokemon's Special Attack stat!"
						}
						else str = "Its Special Attack stat couldn't go any higher!"
					case "RaiseSpDef2":
						if (target.spDefModifier < 5)
						{
							user.spDefModifier += 2
							str = "It greatly raised your pokemon's Special Defense stat!"
						}
						else str = "Its Special Defense stat couldn't go any higher!"
						break
					case "RaiseSpeed2":
						if (target.speedModifier < 5)
						{
							user.speedModifier += 2
							str = "It greatly raised your pokemon's Speed stat!"
						}
						else str = "Its Speed stat couldn't go any higher!"
						break
					#endregion

					#region Statuses
					case "Paralysis":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "The opponent is now paralyzed"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					case "Poisoned":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "The opponent is now poisoned"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					case "Burn":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "The opponent is now burned"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					case "Sleep":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "The opponent is now asleep"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					#endregion
				
					#region Traps
					case "SetTrap":
						var b = instance_find(BattleObject, 0)
						ds_list_add(b.enemyFieldEffects, "SetTrap")
						str = "Traps were layed on the field!"
						break
				
					case "WicketReversal":
						b = instance_find(BattleObject, 0)
						ds_list_add(b.enemyFieldEffects, "ReversalTrap")
						str = "Reversing traps were layed on the field!"
						break
					#endregion
				
					case "Recoil":
					case "RecoilOnMiss":
					case "FaintUser":
						str = "Your pokemon took some damage!"
						break

					case "StruggleRecoil":
						str = "Your pokemon struggled and took some damage!"
						break
				}
		}
		else
		{
			if (effectName == "DoomDowngrade") 
			{
				skipTurn = true						
				ds_list_add(battleText.textList, "Your pokémon's move failed and they fainted!")
			}
		}
	
		if (string_count("Recoil", str) == 0 and string_count("Faint", str) == 0)
			{
				if (ds_list_find_index(BattleObject.playerFieldEffects, "SetTrap") != -1) 
				{
					ds_list_add(BattleTextboxObject.textList, "Your pokémon took some damage!")
				}
				else if (ds_list_find_index(BattleObject.playerFieldEffects, "ReversalTrap") != -1) 
				{
					ds_list_add(BattleTextboxObject.textList, "Your pokémon took some damage!")
				}
			}
	}
	else
	{
		if (random_range(0,101) <= accurancy)
		{
			switch (effectName)
				{
					#region Lower 1
					case "LowerAttack":
						if (target.attackModifier > -6)
						{
							target.attackModifier -= 1
							str = "It lowered your pokemon's Attack stat!"
						}
						else str = "Your pokemon's Attack stat couldn't go any lower!"
						break
					case "LowerDefense":
						if (target.defenseModifier > -6)
						{
							target.defenseModifier -= 1
							str = "It lowered your pokemon's Defense stat!"
						}
						else str = "Your pokemon's Defense stat couldn't go any lower!"
						break
					case "LowerSpAtk":
						if (target.spAtkModifier > -6)
						{
							target.spAtkModifier -= 1
							str = "It lowered your pokemon's Special Attack stat!"
						}
						else str = "Your pokemon's Special Attack stat couldn't go any lower!"
						break
					case "LowerSpDef":
						if (target.spDefModifier > -6)
						{
							target.spDefModifier -= 1
							str = "It lowered your pokemon's Special Defense stat!"
						}
						else str = "Your pokemon's Special Defense stat couldn't go any lower!"
						break
					case "LowerSpeed":
						if (target.speedModifier > -6)
						{
							target.speedModifier -= 1
							str = "It lowered your pokemon's Speed stat!"
						}
						else str = "Your pokemon's Speed stat couldn't go any lower!"
						break
					#endregion

					#region Lower 2
					case "LowerAttack2":
						if (target.attackModifier > -5)
						{
							target.attackModifier -= 2
							str = "It greatly lowered your pokemon's Attack stat!"
						}
						else str = "Your pokemon's Attack stat couldn't go any lower!"
						break
					case "LowerDefense2":
						if (target.defenseModifier > -5)
						{
							target.defenseModifier -= 2
							str = "It greatly lowered your pokemon's Defense stat!"
						}
						else str = "Your pokemon's Defense stat couldn't go any lower!"
						break
					case "LowerSpAtk2":
						if (target.spAtkModifier > -5)
						{
							target.spAtkModifier -= 2
							str = "It greatly lowered your pokemon's Special Attack stat!"
						}
						else str = "Your pokemon's Special Attack stat couldn't go any lower!"
						break
					case "LowerSpDef2":
						if (target.spDefModifier > -5)
						{
							target.spDefModifier -= 2
							str = "It greatly lowered your pokemon's Special Defense stat!"
						}
						else str = "Your pokemon's Special Defense stat couldn't go any lower!"
						break
					case "LowerSpeed2":
						if (target.speedModifier > -5)
						{
							target.speedModifier -= 2
							str = "It greatly lowered your pokemon's Speed stat!"
						}
						else str = "Your pokemon's Speed stat couldn't go any lower!"
						break
					case "DoomDowngrade":
						var canLowerStatCount = 5
						if (target.attackModifier > -5) target.attackModifier -= 2
						else canLowerStatCount--
						if (target.defenseModifier > -5) target.defenseModifier -= 2
						else canLowerStatCount--
						if (target.spAtkModifier > -5) target.spAtkModifier -= 2
						else canLowerStatCount--
						if (target.spDefModifier > -5) target.spDefModifier -= 2
						else canLowerStatCount--
						if (target.speedModifier > -5) target.speedModifier -= 2
						else canLowerStatCount--
					
						if (canLowerStatCount == 0) str = "Your pokemon's stats couldn't go any lower!"
						else str = "Many of your pokemon's stats were lowered!"
						break
					#endregion

					#region Raise 1
					case "RaiseAttack":
						if (target.attackModifier < 6)
						{
							user.attackModifier += 1
							str = "It raised the foe's Attack stat!"
						}
						else str = "Its Attack stat couldn't go any higher!"
						break
					case "RaiseDefense":
						if (target.defenseModifier < 6)
						{
							user.defenseModifier += 1
							str = "It raised the foe's Defense stat!"
						}
						else str = "Its Defense stat couldn't go any higher!"
						break
					case "RaiseSpAtk":
						if (target.spAtkModifier < 6)
						{
							user.spAtkModifier += 1
							str = "It raised the foe's Special Attack stat!"
						}
						else str = "Its Special Attack stat couldn't go any higher!"
						break
					case "RaiseSpDef":
						if (target.spDefModifier < 6)
						{
							user.spDefModifier += 1
							str = "It raised the foe's Special Defense stat!"
						}
						else str = "Its Special Defense stat couldn't go any higher!"
						break
					case "RaiseSpeed":
						if (target.speedModifier < 6)
						{
							user.speedModifier += 1
							str = "It raised the foe's Speed stat!"
						}
						else str = "Its Speed stat couldn't go any higher!"
						break
					#endregion

					#region Raise 2
					case "RaiseAttack2":
						if (target.attackModifier < 5)
						{
							user.attackModifier += 2
							str = "It greatly raised the foe's Attack stat!"
						}
						else str = "Its Attack stat couldn't go any higher!"
						break
					case "RaiseDefense2":
						if (target.defenseModifier < 5)
						{
							user.defenseModifier += 2
							str = "It greatly raised the foe's Defense stat!"
						}
						else str = "Its Defense stat couldn't go any higher!"
						break
					case "RaiseSpAtk2":
						if (target.spAtkModifier < 5)
						{
							user.spAtkModifier += 2
							str = "It greatly raised the foe's Special Attack stat!"
						}
						else str = "Its Special Attack stat couldn't go any higher!"
					case "RaiseSpDef2":
						if (target.spDefModifier < 5)
						{
							user.spDefModifier += 2
							str = "It greatly raised the foe's Special Defense stat!"
						}
						else str = "Its Special Defense stat couldn't go any higher!"
						break
					case "RaiseSpeed2":
						if (target.speedModifier < 5)
						{
							user.speedModifier += 2
							str = "It greatly raised the foe's Speed stat!"
						}
						else str = "Its Speed stat couldn't go any higher!"
						break
					#endregion

					#region Statuses
					case "Paralysis":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "Your pokemon is now paralyzed"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					case "Poisoned":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "Your pokemon is now poisoned"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					case "Burn":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "Your pokemon is now burned"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					case "Sleep":
						if (GetHealth(target.pkmnInfo)-damage > 0)
						{
							if (target.status == "None") str = "Your pokemon is now asleep"
							else str = "The opponent already has a status effect!"
						}
						else str = ""
						break
					#endregion
				
					#region Traps
					case "SetTrap":
						var b = instance_find(BattleObject, 0)
						ds_list_add(b.playerFieldEffects, "SetTrap")
						str = "Traps were layed on the field!"
						break
				
					case "WicketReversal":
						b = instance_find(BattleObject, 0)
						ds_list_add(b.playerFieldEffects, "ReversalTrap")
						str = "Reversing traps were layed on the field!"
						break
					#endregion
				
					case "Recoil":
					case "RecoilOnMiss":
					case "FaintUser":
						str = "The opponent took some damage!"
						break

					case "StruggleRecoil":
						str = "The opponent struggled and took some damage!"
						break						
				}
		}
		else
		{
			if (effectName == "DoomDowngrade") 
			{
				skipTurn = true						
				ds_list_add(battleText.textList, "Your pokémon's move failed and they fainted!")
			}
		}
	
		if (string_count("Recoil", str) == 0 and string_count("Faint", str) == 0)
			{
				if (ds_list_find_index(BattleObject.enemyFieldEffects, "SetTrap") != -1) 
				{
					ds_list_add(BattleTextboxObject.textList, "The opponent took some damage!")
				}
				else if (ds_list_find_index(BattleObject.enemyFieldEffects, "ReversalTrap") != -1) 
				{
					ds_list_add(BattleTextboxObject.textList, "The opponent took some damage!")
				}
			}
	}
	
	return str
}

function IsStatusEffect(eff)
{
	switch (eff)
	{
		case "Paralysis":
		case "Burn":
		case "Sleep":
		case "Poisoned":
		case "RandomStatus":
			return true
			
		default: return false
	}
}

function ChooseMove(pkmn, targetPkmn)
{
	var name = GetName(pkmn)
	var level = GetLevel(pkmn)

	var stats = GetPokemonFinalStats(name, level)
	var targetName = GetName(targetPkmn)
	var targetLevel = GetLevel(targetPkmn)
	var targetStats = GetPokemonFinalStats(targetName, targetLevel)

	var type = GetTypes(pkmn)
	var knownMoves = GetMoves(pkmn)
	var movePP = GetMovePPList(pkmn)
	var moves = ds_list_create()

	for (var i = 0; i < ds_list_size(knownMoves); i++)
	{
		if (i < ds_list_size(movePP) and ds_list_find_value(movePP, i) > 0)
		{
			ds_list_add(moves, ds_list_find_value(knownMoves, i))
		}
	}

	if (ds_list_empty(moves))
	{
		ds_list_destroy(moves)
		return "Struggle"
	}

	if (GetSpeedStat(stats) <= GetSpeedStat(targetStats)) //If user speed is lower
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
			ds_list_destroy(speedLoweringMoves)
			ds_list_destroy(moves)
			return chosenMove
		}
		else
		{
			if (floor(random_range(0,3)) == 0) //33% chance to use a random move
			{
				var moveName = ds_list_find_value(moves, irandom(ds_list_size(moves)-1))
				ds_list_destroy(moves)
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
				ds_list_destroy(damageList)
				ds_list_destroy(moves)
				return moveName
			}
		}
	}
	else //Choose strongest move
	{
		if (floor(random_range(0,3)) == 0) //33% chance to use a status move
		{
			var moveName = ds_list_find_value(moves, irandom(ds_list_size(moves)-1))
			ds_list_destroy(moves)
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
			ds_list_destroy(damageList)
			ds_list_destroy(moves)
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

function GetAttackParticle(moveName)
{
	var cat = GetMoveCategory(moveName)
	if (cat != "Status") return HitAttackObject
	else return noone
}

function GetFirstHealthyPokemon()
{
	//for (var i = 0; i < 6; i++)
	for (var i = 0; i < ds_list_size(global.playerParty); i++)
	{
		var attempt = ds_list_find_value(global.playerParty, i)
		if (GetHealth(attempt) > 0)
		{
			return i
		}
	}
	return -1
}

function GetFirstHealthyPokemonExcept(excludedIndex)
{
	var excludedPkmn = noone
	if (excludedIndex >= 0 and excludedIndex < ds_list_size(global.playerParty))
	{
		excludedPkmn = ds_list_find_value(global.playerParty, excludedIndex)
	}

	for (var i = 0; i < ds_list_size(global.playerParty); i++)
	{
		var attempt = ds_list_find_value(global.playerParty, i)
		// Also reject the same DS-list reference in another slot. That makes an
		// already-corrupted duplicated party fail safely instead of sending it out.
		if (i != excludedIndex and attempt != excludedPkmn and GetHealth(attempt) > 0)
		{
			return i
		}
	}
	return -1
}

function GetPokeballChance(type)
{
	switch (type)
	{
		case "Poke Ball":
			return 0.75
		case "Great Ball":
			return 0.8
		case "Ultra Ball":
			return 0.9
	}
	return 0.75
}

function TryCatching(ballName)
{
	var chance = GetPokeballChance(ballName)
	if (random_range(0,100) <= 100*(chance))
	{
		return 3
	}
	return irandom(2)
}

function GetCatchingString(timesBobbed, pkmnName)
{
	switch (timesBobbed)
	{
		case 0:
			return "Oops, try again!"
		case 1:
			return "Aw dangit, it escaped!"
		case 2:
			return "So close! Maybe next time..."
		case 3:
			return string_concat("You've caught a ", pkmnName, "!")
	}
	return ""
}

function TryToRun(playerPkmn, enemyPkmn, attempts)
{
	var chance = floor(random_range(0,256))

	var name = GetName(playerPkmn)
	var level = GetLevel(playerPkmn)
	var stats = GetPokemonFinalStats(name, level)
	var playerSpd = GetSpeedStat(stats)

	name = GetName(enemyPkmn)
	level = GetLevel(enemyPkmn)
	stats = GetPokemonFinalStats(name, level)
	var enemySpd = GetSpeedStat(stats)

	if (playerSpd >= enemySpd) return true
	var runChance = ((playerSpd*32)/(enemySpd/4)+30*attempts) mod 256
	return chance < runChance
}

function GetTrainerTeam(trainerName)
{
	var team = ds_list_create()
	switch(trainerName)
	{
	//Test Room
		case "GodzillaTestTrainer":
			AddPokemonTrainer(team, 0, "Godzilla", 5, "Female", GodzillaSprite)
			break
	//Mallet Town
		case "Mary":
			AddPokemonTrainer(team, 0, GetRivalStarter(), 5, GetRandomGender(50), GetSpriteByNumber(GetNumberByName(GetRivalStarter())))
			break
			
	//Route Minus One BOTTOM
		case "Hat Kid":
			AddPokemonTrainer(team, 0, "Pikachu", 5, "Female", PikachuIdleSprite)
			AddPokemonTrainer(team, 0, "Zubat", 5, "Female", ZubatFlappingSprite)
			break
		case "Kidd Funkadelic, Jr.":
			AddPokemonTrainer(team, 0, "Ape-Ball", 5, "Male", ApeBallSprite)
			break
		case "Pikachu":
			AddPokemonTrainer(team, 0, "Pikmin", 3, "Male", PikminIdleSprite)
			AddPokemonTrainer(team, 1, "Pikachu", 5, "Female", PikachuIdleSprite)
			break
		case "KcoKt":
			AddPokemonTrainer(team, 1, "Squirtle", 3, "Male", SquirtleIdleSprite)
			AddPokemonTrainer(team, 2, "Pikachu", 5, "Female", PikachuIdleSprite)
			AddPokemonTrainer(team, 3, "Tektite", 5, "Female", TektiteIdleSprite)
			break
		case "Mary2":
			AddPokemonTrainer(team, 1, "Tektite", 4, "Male", TektiteIdleSprite)
			AddPokemonTrainer(team, 2, GetRivalStarter(), 6, GetRandomGender(50), GetSpriteByNumber(GetNumberByName(GetRivalStarter())))
			break


	//Route Minus One TOP
		case "Ultiron":
			AddPokemonTrainer(team, 1, "Pikachu", 2, "Female", PikachuIdleSprite)
			AddPokemonTrainer(team, 2, "Caterpie", 4, "Female", CaterpieIdleSprite)
			AddPokemonTrainer(team, 3, "Pikmin", 7, "Female", PikminIdleSprite)
			break
		case "Bestie":
			AddPokemonTrainer(team, 1, "Squirtle", 3, "Female", SquirtleIdleSprite)
			AddPokemonTrainer(team, 2, "Caterpie", 5, "Female", CaterpieIdleSprite)
			break
			
	//Mutant Path
		case "Morlock Trainer":
			AddPokemonTrainer(team, 1, "Human", 7, "Male", Human2IdleSprite)
			AddPokemonTrainer(team, 2, "Demo Dog", 8, "Female", DemoDogSprite)
			break
		case "Team Rocket Hexagonni":
			AddPokemonTrainer(team, 1, "Zubat", 3, "Male", ZubatFlappingSprite)
			AddPokemonTrainer(team, 2, "Morlock", 5, "Male", MorlockBattleSprite)
			AddPokemonTrainer(team, 3, "Demo Dog", 7, "Male", DemoDogSprite)
			break
		case "Skull":
			AddPokemonTrainer(team, 3, "Silver Scorpion", 10, "Male", SIlverScorpionOverworldSprite)
			break
		case "BridgeMorlock":
			AddPokemonTrainer(team, 1, "Zubat", 10, "Female", ZubatFlappingSprite)
			AddPokemonTrainer(team, 2, "Morlock", 10, "Male", MorlockcitaSprite)
			break
			
	//Robot Path
		case "BoxBotH":
			AddPokemonTrainer(team, 1, "Magnemite", 4, "Male", MagnemiteOverworldSprite)
			AddPokemonTrainer(team, 2, "Voltorb", 6, "Male", VoltorbOverworldSprite)
			break
		case "BoxBotI":
			AddPokemonTrainer(team, 1, "Magnemite", 3, "Male", MagnemiteOverworldSprite)
			AddPokemonTrainer(team, 2, "Voltorb", 5, "Male", VoltorbOverworldSprite)
			break
		case "Greg":
			AddPokemonTrainer(team, 1, "BB-8", 4, "Male", BB8BattleSprite)
			AddPokemonTrainer(team, 2, "Caterpie", 6, "Male", CaterpieIdleSprite)
			break
		case "Bottrick Notthuman":
			AddPokemonTrainer(team, 1, "Box Bot", 3, "Male", BoxBotIdleSprite)
			AddPokemonTrainer(team, 2, "BB-8", 8, "Male", BB8BattleSprite)
			break
		case "Cloaked Trainer":
			AddPokemonTrainer(team, 1, "Caterpie", 4, "Male", CaterpieIdleSprite)
			AddPokemonTrainer(team, 2, "Pikachu", 9, "Female", PikachuIdleSprite)
			break
		case "Ephemelia":
			AddPokemonTrainer(team, 1, "Box Bot", 3, "Male", BoxBotIdleSprite)
			AddPokemonTrainer(team, 2, "Squirrel", 10, "Female", SquirrelOverworldSprite)
			break
		case "Box Bot O":
			AddPokemonTrainer(team, 1, "Box Bot", 4, "Male", BoxBotIdleSprite)
			AddPokemonTrainer(team, 2, "BB-8", 5, "Male", BB8BattleSprite)
			AddPokemonTrainer(team, 3, "Box Bot", 8, "Male", BoxBotIdleSprite)
			break
			
			
	//Mountain Peak 
		case "Gym Leader Test":
			AddPokemonTrainer(team, 0, "Pikachu", 5, "Female", PikachuIdleSprite)
			break
		case "Ian":
			AddPokemonTrainer(team, 1, "Clefairy", 12, "Female", ClefairySprite)
			AddPokemonTrainer(team, 2, "Kirby", 16, "Female", KirbySprite)
			break
		case "Elise":
			AddPokemonTrainer(team, 0, "Ewok", 13, "Female", KirbySprite)
			AddPokemonTrainer(team, 1, "Kirby", 15, "Female", KirbySprite)
			break
			
			
	//Dark Tower
		case "Team Rocket Mildred":
			AddPokemonTrainer(team, 1, "Pikachu", 18, "Female", PikachuIdleSprite)
			AddPokemonTrainer(team, 2, "Umbrian", 20, "Male", UmbrianOverworldSprite)
			AddPokemonTrainer(team, 3, "Charmander", 18, "Female", CharmanderBattleSprite)
			AddPokemonTrainer(team, 4, "Morlock", 20, "Female", MorlockcitaSprite)
			AddPokemonTrainer(team, 5, "Demogorgon", 21, "Male", DemogorgonBattleSprite)
			break
		case "Team Rocket Bonnie":
			AddPokemonTrainer(team, 1, "Kirby", 18, "Female", KirbySprite)
			AddPokemonTrainer(team, 2, "Magnemite", 20, "Male", MagnemiteOverworldSprite)
			AddPokemonTrainer(team, 3, "Box Bot", 18, "Female", BoxBotIdleSprite)
			AddPokemonTrainer(team, 4, "Voltorb", 20, "Female", VoltorbOverworldSprite)
			AddPokemonTrainer(team, 5, "Human", 20, "Male", Human2IdleSprite)
			break
		case "Team Rocket Gladys":
			AddPokemonTrainer(team, 1, "Tektite", 18, "Female", TektiteIdleSprite)
			AddPokemonTrainer(team, 2, "Ape-Ball", 20, "Male", ApeBallSprite)
			AddPokemonTrainer(team, 3, "Kirby", 18, "Female", KirbySprite)
			AddPokemonTrainer(team, 4, "Krypton Firefly", 20, "Female", KryptonFireflySprite)
			AddPokemonTrainer(team, 5, "Creeper", 23, "Male", CreeperSprite)
			break
		case "Team Rocket Roxanne":
			AddPokemonTrainer(team, 5, "Pac-Man", 22, "Male", PacManWalkRight_Strip3)
			AddPokemonTrainer(team, 1, "Zubat", 18, "Female", ZubatFlappingSprite)
			AddPokemonTrainer(team, 2, "Porg", 20, "Male", PorgBattleSprite)
			AddPokemonTrainer(team, 3, "Zergling", 18, "Female", ZerglingSprite)
			AddPokemonTrainer(team, 4, "Zoombini", 20, "Female", ZoombiniHoveringSprite)
			break
		case "Team Rocket Spike":
			AddPokemonTrainer(team, 1, "Tribble", 18, "Female", TribbleBattleSprite)
			AddPokemonTrainer(team, 2, "Ewok", 20, "Male", EwokOverworldSprite)
			AddPokemonTrainer(team, 3, "Demo Dog", 18, "Female", DemoDogSprite)
			AddPokemonTrainer(team, 4, "Licker", 20, "Female", LickerOverworldSprite)
			AddPokemonTrainer(team, 5, "ZooChomper", 23, "Male", ZoochomperBattleSprite)
			break
	    case "Team Rocket Marnie":
	        AddPokemonTrainer(team, 1, "Woob-Wüb", 18, "Female", WoobWubBattleSprite)
	        AddPokemonTrainer(team, 2, "Pac-Ghost", 20, "Female", PacGhostOverworldSprite)
	        AddPokemonTrainer(team, 3, "Butterfree", 18, "Male", ButterfreeFlyLeftSprite)
	        AddPokemonTrainer(team, 4, "Umbrian", 20, "Male", UmbrianOverworldSprite)
	        AddPokemonTrainer(team, 5, "Enderman", 22, "Female", EndermanOverworldSprite)
			break
	    case "Team Rocket Jett":
	        AddPokemonTrainer(team, 1, "Pikmin", 18, "Male", PikminIdleSprite)
	        AddPokemonTrainer(team, 2, "Box Bot", 20, "Male", BoxBotIdleSprite)
	        AddPokemonTrainer(team, 3, "Voltorb", 18, "Female", VoltorbOverworldSprite)
	        AddPokemonTrainer(team, 4, "BB-8", 20, "Female", BB8BattleSprite)
	        AddPokemonTrainer(team, 5, "Metroid", 23, "Male", MetroidOverworldSprite)
			break
	    case "Team Rocket Sable":
	        AddPokemonTrainer(team, 1, "Boo", 18, "Female", BooOverworldSprite)
	        AddPokemonTrainer(team, 2, "Silver Scorpion", 20, "Male", SIlverScorpionOverworldSprite)
	        AddPokemonTrainer(team, 3, "Envy", 18, "Female", EnvySprite)
	        AddPokemonTrainer(team, 4, "Xenomorph", 20, "Female", XenomorphOverworldSprite)
	        AddPokemonTrainer(team, 5, "Godzooky", 22, "Male", GodzookyOverworldSprite)
			break
		case "Team Rocket Cruz":
	        AddPokemonTrainer(team, 1, "Goomba", 18, "Male", GoombaOverworldSprite)
	        AddPokemonTrainer(team, 2, "Koopa", 20, "Male", KoopaWalkRightSprite)
	        AddPokemonTrainer(team, 3, "Yo’ster", 18, "Female", YoSterOverworldSprite)
	        AddPokemonTrainer(team, 4, "Tektite", 20, "Female", TektiteIdleSprite)
	        AddPokemonTrainer(team, 5, "King Koopa", 23, "Male", KingKoopaBattleSprite)
			break
	    case "Team Rocket Nyx":
	        AddPokemonTrainer(team, 1, "Boo", 18, "Female", BooOverworldSprite)
	        AddPokemonTrainer(team, 2, "Pac-Ghost", 20, "Female", PacGhostOverworldSprite)
	        AddPokemonTrainer(team, 3, "MissingNo", 18, "Male", MissingNoIdleSprite)
	        AddPokemonTrainer(team, 4, "Umbrian", 20, "Female", UmbrianOverworldSprite)
	        AddPokemonTrainer(team, 5, "Moltres", 22, "Female", MoltresOverworldSprite)
			break
	    case "Team Rocket Harlow":
	        AddPokemonTrainer(team, 1, "Squirrel", 18, "Female", SquirrelBattleSprite)
	        AddPokemonTrainer(team, 2, "Tribble", 20, "Female", TribbleBattleSprite)
	        AddPokemonTrainer(team, 3, "Porg", 18, "Male", PorgBattleSprite)
	        AddPokemonTrainer(team, 4, "Ewok", 20, "Male", EwokOverworldSprite)
	        AddPokemonTrainer(team, 5, "Moosephant", 22, "Female", MoosephantOverworldSprite)
			break
	    case "Team Rocket Gage":
	        AddPokemonTrainer(team, 1, "Box Bot", 18, "Male", BoxBotIdleSprite)
	        AddPokemonTrainer(team, 2, "Tutorial Bot", 20, "Female", TutorialBotSprite)
	        AddPokemonTrainer(team, 3, "BB-8", 18, "Male", BB8BattleSprite)
	        AddPokemonTrainer(team, 4, "Voltorb", 20, "Female", VoltorbOverworldSprite)
	        AddPokemonTrainer(team, 5, "Metroid", 23, "Male", MetroidOverworldSprite)
			break
	    case "Team Rocket Vesper":
	        AddPokemonTrainer(team, 1, "Envy", 18, "Female", EnvySprite)
	        AddPokemonTrainer(team, 2, "Silver Scorpion", 20, "Male", SIlverScorpionOverworldSprite)
	        AddPokemonTrainer(team, 3, "Andalite", 18, "Female", AndaliteOverworldSprite)
	        AddPokemonTrainer(team, 4, "Caelian", 20, "Male", CaelianBattleSprite)
	        AddPokemonTrainer(team, 5, "Xenomorph", 22, "Female", XenomorphOverworldSprite)
			break
	    case "Team Rocket Dante":
	        AddPokemonTrainer(team, 1, "Charmander", 18, "Male", CharmanderBattleSprite)
	        AddPokemonTrainer(team, 2, "Charmandorian", 20, "Male", CharmandorianSprite)
	        AddPokemonTrainer(team, 3, "Charmandalorian", 18, "Female", CharmandalorianSprite)
	        AddPokemonTrainer(team, 4, "Krypton Firefly", 20, "Female", KryptonFireflySprite)
	        AddPokemonTrainer(team, 5, "Godzooky", 23, "Male", GodzookyOverworldSprite)
			break
	    case "Team Rocket Kira":
	        AddPokemonTrainer(team, 1, "Zoombini", 18, "Female", ZoombiniHoveringSprite)
	        AddPokemonTrainer(team, 2, "Pikmin", 20, "Male", PikminIdleSprite)
	        AddPokemonTrainer(team, 3, "Kirby", 18, "Female", KirbySprite)
	        AddPokemonTrainer(team, 4, "Baby", 20, "Female", BabyBattleSprite)
	        AddPokemonTrainer(team, 5, "ZooChomper", 22, "Male", ZoochomperBattleSprite)
			break
		
		//Gym Leaders
		case "Lilium":
			AddPokemonTrainer(team, 1, "Boo", 16, "Male", BooOverworldSprite)
			AddPokemonTrainer(team, 2, "Pac-Ghost", 17, "Male", PacGhostOverworldSprite)
			AddPokemonTrainer(team, 3, "Umbreon", 17, "Male", UmbreonOverworldSprite)
			AddPokemonTrainer(team, 4, "Yamask", 16, "Male", YamaskFrontSprite)
			AddPokemonTrainer(team, 5, "Umbrian", 18, "Male", UmbrianOverworldSprite)
			break
		case "Gorbertron":
			AddPokemonTrainer(team, 1, "Zoombini", 16, "Male", ZoombiniHoveringSprite)
			AddPokemonTrainer(team, 2, "Ewok", 17, "Male", EwokOverworldSprite)
			AddPokemonTrainer(team, 3, "Human", 17, "Male", Human2IdleSprite)
			AddPokemonTrainer(team, 4, "Morlock", 17, "Male", MorlockBattleSprite)
			AddPokemonTrainer(team, 5, "Demogorgon", 18, "Male", DemogorgonBattleSprite)
			break
		case "Collector":
			if (HasFlag("CollectorFirstBattle"))  AddPokemonTrainer(team, 5, "MEGA BOT", 25, "Male", MEGABOTSprite)
			else
			AddPokemonTrainer(team, 1, "Voltorb", 16, "Male", VoltorbOverworldSprite)
			AddPokemonTrainer(team, 2, "Magnemite", 17, "Male", MagnemiteOverworldSprite)
			AddPokemonTrainer(team, 3, "Box Bot", 17, "Male", BoxBotIdleSprite)
			AddPokemonTrainer(team, 4, "BB-8", 17, "Male", BB8BattleSprite)
			AddPokemonTrainer(team, 5, "Tutorial Bot", 20, "Male", TutorialBotSprite)
			break
		case "Zoovac":
			if (!HasFlag("ZoovacFirstBattle"))
			{
				AddPokemonTrainer(team, 1, "Silver Scorpion", 22, "Male", SIlverScorpionOverworldSprite)
				/*AddPokemonTrainer(team, 2, "Zergling", 38, "Male", ZerglingSprite)
				AddPokemonTrainer(team, 3, "Demogorgon", 44, "Male", DemogorgonBattleSprite)
				AddPokemonTrainer(team, 4, "MissingNo", 44, "Male", MissingNoIdleSprite)
				AddPokemonTrainer(team, 5, "Rancor", 55, "Male", RancorOverworldSprite)*/
			}
			else
			{
				AddPokemonTrainer(team, 1, "Godzilla", 65, "Male", GodzillaSprite)
			}
			break
	}
	return team
}

function GetTrainerSprite(trainerName)
{
	switch(trainerName)
	{
		default: return HatKidWalkRightSprite
	}
}

function GetRivalStarter()
{
	switch (GetStarterChoice())
	{
		case "StarterPokemonOne":
			return "Krypton Firefly"
		case "StarterPokemonTwo":
			return "Envy"
		case "StarterPokemonThree":
			return "Creeper"
	}
}

function GetStarterChoice()
{
	for (var i = 0; i < ds_list_size(global.flags); i++)
	{
		var attempt = ds_list_find_value(global.flags, i)
		if (attempt == "StarterPokemonOne" or attempt == "StarterPokemonTwo" or attempt == "StarterPokemonThree")
		{
			return attempt
		}
	}
}

function ParalysisCheck() { return floor(random_range(0,4)) != 0 }

function WakeUpCheck() { return floor(random_range(0,4)) == 0 }

function ConvinceCheck() 
{
	var roll = irandom(100)
	switch (global.convinceCounter)
	{
		case 1:
			if (roll <= 10) return true
			return false
		case 2:
			if (roll <= 25) return true
			return false
		case 3:
			if (roll <= 33) return true
			return false
		case 4:
			if (roll <= 50) return true
			return false
		case 5:
			return true
	}
}

function GetBattleXscale(name)
{
	switch (name)
	{
		case "Silver Scorpion":
		case "Envy":
		case "Pikmin":
		case "Koopa":
			return -1;
			break
		//Use this for naturally flipped pokémon
			
		case "MissingNo": 
			return 0.5;
			break
	}
	return 1
}

function GetBattleYscale(name)
{
	switch (name)
	{
		case "MissingNo": 
			return 0.5;
			break
		//Use this for naturally flipped pokémon
	}
	return 1
}
