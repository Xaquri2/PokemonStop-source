function SetWarpDefaults(name, spawnDir, show)
{
	switch (name)
	{
		#region Test Room (Void)
		case "TestToMalletHouse1":
			targetRoom = Mallet_Town
			targetWarp = "MalletHouse1ToTest"
			break
		#endregion
		
		#region Mallet Town
		case "MalletHouse1ToTest":
			targetRoom = TestRoom
			targetWarp = "TestToMalletHouse1"
			break
		case "MalletHouse2ToTest":
			targetRoom = GashHouse
			targetWarp = "GashToMallet"
			break
		case "MalletHouse3ToTest":
			targetRoom = GinkgoLab
			targetWarp = "GinkgoToMallet"
			break
		case "MalletToMinusOne":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToMallet"
			break
		#endregion
		
		#region Route Minus One
		case "MinusOneToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletToMinusOne"
			break
		case "MinusOneToMutant":
			targetRoom = MutantPath1
			targetWarp = "MutantToMinusOne"
			break
		#endregion
		
		#region Mutant Path
		case "MutantToMinusOne":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToMutant"
			break
			
		#region GinkgoLab
		case "GinkgoToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletHouse3ToTest"
			break
		#endregion
		
		#region GashHouse
		case "GashToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletHouse2ToTest"
			break
		case "GashToUpstair":
			targetRoom = GashUpstairs
			targetWarp = "UpstairsToGash"
			break
		#endregion
		
			#region GashUpstairs
		case "UpstairsToGash":
			targetRoom = GashHouse
			targetWarp = "GashToUpstair"
			break
		#endregion
		
	}
	
	warpName = name
	spawnDirection = spawnDir
	visible = show
}

function GetRoomName()
{
	switch room
	{
		case RouteMinusOneBottom: return "Route -1"
		case Mallet_Town: return "Mallet Town"
		case TestRoom: return "Void"
	}
	return ""
}

function GetRoomMusic()
{
	switch room
	{
		case TitleScreen: return TitleTheme
		case Mallet_Town: return MalletTownMusic
		case RouteMinusOneBottom: return RouteMinusOneTheme
		case RoomBattle: return WildBattleTheme
		case MutantPath1: return MutantPathAmbiance
		case TestRoom: return SacredBeasts
		case GinkgoLab: return PokeGymLofi
	}
	return noone
}

function GetAreaEncounters()
{
	var encounters = ds_list_create()
	switch (room)
	{
		case TestRoom: 
			ds_list_add(encounters, "Charmander")
			break
		case Mallet_Town:
			ds_list_add(encounters, "Pikachu")
			break
	}
	return encounters
}

function IsIndoors()
{
	switch (room)
	{
		#region Overworld
		case Mallet_Town:
			return false
		#endregion
			
		#region Indoors
		case TestRoom: 
			return true
		#endregion
	}
	return false
}