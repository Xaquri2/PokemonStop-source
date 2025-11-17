function SetWarpDefaults(name, spawnDir, show)
{
	switch (name)
	{
		#region Test Room (Void)
		case "TestToMalletHouse1":
			targetRoom = Mallet_Town
			targetWarp = "MalletHouse1ToTest"
			break
		case "TestToMutant":
			targetRoom = MutantPath1
			targetWarp = "MutantToBuilding"
			break
		case "TestToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToMinusOne"
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
		case "MalletToTest":
			targetRoom = TestRoom
			targetWarp = "TestToMalletHouse1"
			break
		case "MalletToWaterfront":
			targetRoom = Waterfront
			targetWarp = "WaterfrontToMallet"
			break
		case "MalletToMalletEast":
			targetRoom = Mallet_East
			targetWarp = "MalletEastToMallet"
			break
		case "MalletToMalletEastTOP":
			targetRoom = Mallet_East
			targetWarp = "MalletEastToMalletTOP"
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
		case "MinusOneToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToMinusOne"
			break
		#endregion
		
		#region Mutant Path
		case "MutantToMinusOne":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToMutant"
			break
		case "MutantToBuilding":
			targetRoom = TestTiltedRoom
			targetWarp = "TiltedToMutant"
			break
		#endregion
		
		#region Shadow Path
		case "ShadowToMinusOne":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToShadow"
			break
		case "ShadowToShadowTower":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToShadow"
			break
			
		#region Shadow Tower	
		case "ShadowTowerToShadowGym":
			targetRoom = ShadowPathGym
			targetWarp = "ShadowGymToShadowTower"
			break
		#endregion
		
		#region Shadow Gym
		case "ShadowGymToShadowTower":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToShadowGym"
			break
		#endregion
			
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
		
		#region TiltedBuilding
		case "TiltedToMutant":
			targetRoom = MutantPath1
			targetWarp = "MutantToBuilding"
			break
		#endregion
		
		#region Waterfront
		case "WaterfrontToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletToWaterfront"
			break
		#endregion
		
		#region Mallet_East
		case "MalletEastToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletToMalletEast"
			break
		case "MalletEastToMalletTOP":
			targetRoom = Mallet_Town
			targetWarp = "MalletToMalletEastTOP"
			break
		case "MalletEastToMuseum":
			targetRoom = MalletMuseum
			targetWarp = "MalletMuseumToEast"
			break
		#endregion
		
		#region MalletMuseum
		case "MalletMuseumToEast":
			targetRoom = Mallet_East
			targetWarp = "MalletEastToMuseum"
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
		case MutantPath1: return MutantPathAmbiance
		case TestRoom: return SacredBeasts
		case GinkgoLab: return PokeGymLofi
		case GashHouse: return SacredBeasts
		case GashUpstairs: return SacredBeasts
		case ShadowPath: return OathToOrder
		case ShadowTower: return OathToOrder
		case ShadowPathGym: return PokeGymLofi
		case Waterfront: return MalletTownMusic
		case Mallet_East: 
		case MalletMuseum:
			return MalletTownMusic
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

function RoomHasGravity()
{
	switch (room)
	{
		case TestTiltedRoom:
			return true
			
		default:
			return false
	}
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