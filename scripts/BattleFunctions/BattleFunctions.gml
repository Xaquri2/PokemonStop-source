function GetDamage(playerPkmn, enemyPkmn, moveName)
{
	var pName = GetName(playerPkmn)
	var pLevel = GetLevel(playerPkmn)
	var pStats = GetPokemonFinalStats(pName, pLevel)
	var pType = GetTypes(playerPkmn)
	
	var eName = GetName(enemyPkmn)
	var eLevel = GetLevel(enemyPkmn)
	var eStats = GetPokemonFinalStats(eName, eLevel)
	
	var moveType = GetMoveType(moveName)
	var movePower = GetMovePower(moveName)
	var moveAcc = GetMoveAccurancy(moveName)
	var moveCat = GetMoveCategory(moveName)
	var moveCrit = GetMoveCritMultiplier(moveName) //Still needs to be used
	
	var atkStat = 0
	var defStat = 0
	
	if (moveCat == "Physical")
	{
		atkStat = GetAtkStat(pStats)
		defStat = GetDefStat(pStats)
	}
	else
	{
		atkStat = GetSpAtkStat(pStats)
		defStat = GetSpDefStat(pStats)
	}
	
	if (ds_list_find_value(pType, 0) == moveType or ds_list_find_value(pType, 1) == moveType)
	{
		movePower *= 1.5
	}
	
	var moveEffect = GetMoveEffect(moveName)
	movePower += GetEffectPower(playerPkmn, enemyPkmn, GetMoveEffect(moveName))
	
	if (IsMoveSuperEffective(moveName, enemyPkmn)) movePower *= 1.5
	if (IsMoveNotVeryEffective(moveName, enemyPkmn)) movePower *= 0.5
	
	var damage = floor((((2 * pLevel / 5) + 2) * movePower * atkStat / defStat) / 50 + 2)
	damage = clamp(damage, 0, 1000000)
	
	if (random_range(0,101) > moveAcc) return 0
	return damage
}

function GetEffectPower(playerPkmn, enemyPkmn, effectName)
{
	switch (effectName)
	{
		case "SpeedPower":
			var userName = GetName(playerPkmn)
			var userLevel = GetLevel(playerPkmn)
			var userSpeed = GetSpeedStat(GetPokemonFinalStats(userName, userLevel))
			
			var targetName = GetName(enemyPkmn)
			var targetLevel = GetLevel(enemyPkmn)
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

function IsMoveSuperEffective(moveName, enemyPkmn)
{
	var moveType = GetMoveType(moveName)
	var enemyTypes = GetTypes(enemyPkmn)
	for (var i = 0; i < ds_list_size(enemyTypes); i++)
	{
		if (IsTypeSuperEffective(moveType, ds_list_find_value(enemyTypes, i))) return true
	}
	return false
}

function IsTypeSuperEffective(type, targetType)
{
	switch (targetType)
	{
		case "Normal":
			if (type == "Fighting") return true
			break
		case "Fire":
			if (type == "Rock" or type == "Ground" or type == "Water") return true
			break
		case "Electric":
			if (type == "Ground") return true
			break
	}
	return false
}

function IsMoveNotVeryEffective(moveName, enemyPkmn)
{
	var moveType = GetMoveType(moveName)
	var enemyTypes = GetTypes(enemyPkmn)
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
		case "Fire":
			if (type == targetType or type == "Grass" or type == "Bug" or 
			type == "Ice" or type == "Steel" or type == "Fairy") return true
			break
		case "Electric":
			if (type == targetType or type == "Flying" or type == "Steel") return true
			break
	}
	return false
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

function DealDamage(damage)
{
	var enemyEntity = -1
	for (var i = 0; i < instance_number(BattlePokemonObject); i++)
	{
		var attempt = instance_find(BattlePokemonObject, i)
		if (!attempt.playerTeam) 
		{
			enemyEntity = attempt
			break
		}
	}

	enemyEntity.hp -= damage
	enemyEntity.hp = clamp(enemyEntity.hp, 0, 9999)
	
	ds_list_set(enemyPkmn, 5, enemyEntity.hp)
	ds_list_set(enemyEntity.team, enemyEntity.index, enemyPkmn)
}

function ChooseMove(pkmn, targetPkmn)
{
	var name = GetName(pkmn)
	var level = GetLevel(pkmn)
	
	var stats = GetPokemonFinalStats(name, level)
	var enemyStats = GetPokemonFinalStats(name, level)
	
	var type = GetTypes(pkmn)
	var moves = GetMoves(pkmn)
	
	if (GetSpeedStat(stats) <= GetSpeedStat(enemyStats))
	{
		if (floor(random_range(0,2)) > 0) 
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
	return ds_list_find_value(moves, 0)
}