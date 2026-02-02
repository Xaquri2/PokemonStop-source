function SetWarpDefaults(name, spawnDir, show)
{
	switch (name)
	{
		//default:
		//	targetRoom = TestRoom
		//	targetWarp = TestToMalletHouse1
		//	break

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
		case "TestToShadowTower":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToTest"
			break
		case "TestToTest":
			targetRoom = TestRoom2
			targetWarp = "Test2Warp"
			break
		case "TestToMutant2":
			targetRoom = TestTiltedRoom
			targetWarp = "TiltedToMorlock"
			#endregion

		#region Mallet Town
		case "MalletHouse1ToTest":
			targetRoom = MaryHouse
			targetWarp = "MaryToMallet"
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
		case "MinusOneBottomToTop1":
			targetRoom = RouteMinusOneTop
			targetWarp = "MinusOneTopToBottom1"
			break
		case "MinusOneBottomToTop2":
			targetRoom = RouteMinusOneTop
			targetWarp = "MinusOneTopToBottom2"
			break
		#endregion


		#region RouteMinusOneTop
		case "MinusOneTopToBottom1":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneBottomToTop1"
			break
		case "MinusOneTopToBottom2":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneBottomToTop2"
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
		case "ShadowToEmptyHouse":
			targetRoom = EmptyHouse
			targetWarp = "EmptyHouseToShadow"
			break
		case "ShadowTOPToGreed":
			targetRoom = GreedShop
			targetWarp = "GreedTOPToShadow"
			break
		case "ShadowBOTTOMToGreed":
			targetRoom = GreedShop
			targetWarp = "GreedBOTTOMToShadow"
			break
			#endregion

		#region Shadow Tower
		case "ShadowTowerToShadowGym":
			targetRoom = ShadowPathGym
			targetWarp = "ShadowGymToShadowTower"
			break
		case "ShadowTowerToTest":
			targetRoom = TestRoom
			targetWarp = "TestToShadowTower"
			break
		#endregion

		#region Shadow Gym
		case "ShadowGymToShadowTower":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToShadowGym"
			break
		#endregion
		
		#region EmptyHouse
		case "EmptyHouseToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToEmptyHouse"
			break
		#endregion
		
		#region GreedShop
		case "GreedShopTOPToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowTOPToGreed"
			break
		case "GreedShopBOTTOMToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowBOTTOMToGreed"
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
		
		#region MaryHouse
		case "MaryToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletHouse1ToTest"
			break
		#endregion

		#region TiltedBuilding
		case "TiltedToMutant":
			targetRoom = MutantPath1
			targetWarp = "MutantToBuilding"
			break
		case "TiltedToMorlock":
			targetRoom = MorlockCity
			targetWarp = "MorlockEntrance"
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
		case "MalletEastToRegionCenter":
			targetRoom = RegionCenter
			targetWarp = "RegionCenterToMalletEast"
			break
		#endregion

		#region MalletMuseum
		case "MalletMuseumToEast":
			targetRoom = Mallet_East
			targetWarp = "MalletEastToMuseum"
			break
		#endregion

		#region RegionCenter
		case "RegionCenterToMalletEast":
			targetRoom = Mallet_East
			targetWarp = "MalletEastToRegionCenter"
			break
		#endregion

		#region TestRoom2
		case "Test2Warp":
			targetRoom = TestRoom
			targetWarp = "TestToTest"
			break
		case "ShadowToPokeCenter":
			targetRoom = ShadowPokecenter
			targetWarp = "PokeCenterToShadow"
			break

		case "PokeCenterToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToPokeCenter"
			break
		case "SHORTCUT":
			targetRoom = MorlockCity
			targetWarp = "MorlockEntrance"
			//targetRoom = MuntainPeak
			//targetWarp = "MountainPeakBottom"
			//targetRoom = ShadowPokecenter
			//targetWarp = "PokeCenterToShadow"
			break
		case "ShadowTowerToShadow2":
			targetRoom = ShadowPath
			targetWarp = "ShadowToShadowTower"
			break
		case "ShadowTowerToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToShadowTower"
			break
		case "RobotToMinusOne":
			targetRoom = RouteMinusOneTop
			targetWarp = "MinusOneTopToRobot"
			break

		case "MinusOneTopToRobot":
			targetRoom = RobotPath
			targetWarp = "RobotToMinusOne"
			break
		case "RobotTOP":
			targetRoom = MuntainPeak
			targetWarp = "MountainPeakBottom"
			break
		case "MountainPeakBottom":
			targetRoom = RobotPath
			targetWarp = "RobotTOP"
			break
		case "CastleDoor":
			targetRoom = RobotGym
			targetWarp = "RobotGymDoor"
			break

		case "RobotGymDoor":
			targetRoom = MuntainPeak
			targetWarp = "CastleDoor"
			break
		case "MorlockEntrance":
			targetRoom = TestTiltedRoom
			targetWarp = "TiltedToMorlock"
			break
		case "MorlockPokeCenterEntrance":
			targetRoom = MutantPokecenter
			targetWarp = "PokeCenterToMorlock"
			break

		case "PokeCenterToMorlock":
			targetRoom = MorlockCity
			targetWarp = "MorlockPokeCenterEntrance"
			break
		case "MorlockSoutheastEntrance":
			targetRoom = MorlockCity2
			targetWarp = "Morlock2SouthwestEntrance"
			break

		case "Morlock2SouthwestEntrance":
			targetRoom = MorlockCity
			targetWarp = "MorlockSoutheastEntrance"
			break
		case "MorlockCity3Bottom":
			targetRoom = MorlockCity
			targetWarp = "MorlockNorth"
			break

		case "MorlockNorth":
			targetRoom = MorlockCity3
			targetWarp = "MorlockCity3Bottom"
			break
		case "MorlockCity3BottomRight":
			targetRoom = MorlockCity2
			targetWarp = "Morlock2NorthwestEntrance"
			break

		case "Morlock2NorthwestEntrance":
			targetRoom = MorlockCity3
			targetWarp = "MorlockCity3BottomRight"
			break
		case "MorlockShopEntrance":
			targetRoom = MorlockShop
			targetWarp = "MorlockShopToMorlock"
			break

		case "MorlockShopToMorlock":
			targetRoom = MorlockCity
			targetWarp = "MorlockShopEntrance"
			break
		case "MorlockRestaurantEntrance":
			targetRoom = MorlockRestaurant
			targetWarp = "MorlockRestaurantExit"
			break

		case "MorlockRestaurantExit":
			targetRoom = MorlockCity2
			targetWarp = "MorlockRestaurantEntrance"
			break
		case "MorlockToGym":
			targetRoom = MorlockGym
			targetWarp = "MorlockGymExit"
			break

		case "MorlockGymExit":
			targetRoom = MorlockCity3
			targetWarp = "MorlockToGym"
			break
		case "TowerExit":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToTower"
			break

		case "MinusOneToTower":
			targetRoom = FirstFloor
			targetWarp = "TowerExit"
			break
	//	case "TowerFirstFloorElevator":
	//		targetRoom = SecondFloor
	//		targetWarp = "TowerSecondFloorElevatorDown"
	//		break
		case "TowerFirstFloorElevator":
			targetRoom = Elevator1
			targetWarp = "Elevator1"
			break

		case "TowerSecondFloorElevatorDown":
			targetRoom = FirstFloor
			targetWarp = "TowerFirstFloorElevator"
			break
		case "TowerSecondFloorElevatorUP":
			targetRoom = ThirdFloor
			targetWarp = "TowerThirdFloorElevatorDOWN"
			break

		case "TowerThirdFloorElevatorDOWN":
			targetRoom = SecondFloor
			targetWarp = "TowerSecondFloorElevatorUP"
			break
		case "TowerThirdFloorElevatorUP":
			targetRoom = FourthFloor
			targetWarp = "TowerFourthFloorElevatorDOWN"
			break

		case "TowerFourthFloorElevatorDOWN":
			targetRoom = ThirdFloor
			targetWarp = "TowerThirdFloorElevatorUP"
			break
		case "TowerFourthFloorElevatorUP":
			targetRoom = FifthFloor
			targetWarp = "TowerFifthFloorElevatorDOWN"
			break

		case "TowerFifthFloorElevatorDOWN":
			targetRoom = FourthFloor
			targetWarp = "TowerFourthFloorElevatorUP"
			break
		case "NebogipfelExit":
			targetRoom = MorlockCity
			targetWarp = "MorlockToNebogipfel"
			break

		case "MorlockToNebogipfel":
			targetRoom = NebogipfelsStudy
			targetWarp = "NebogipfelExit"
			break
		case "PokeCenterEntrance":
			targetRoom = RobotPokecenter
			targetWarp = "RobotPokeCenterExit"
			break

		case "RobotPokeCenterExit":
			targetRoom = MuntainPeak
			targetWarp = "PokeCenterEntrance"
			break
		case "MountainToRobotMart":
			targetRoom = RobotMart
			targetWarp = "MartExit"
			break

		case "MartExit":
			targetRoom = MuntainPeak
			targetWarp = "MountainToRobotMart"
			break
		case "TestToRobotCastle":
			targetRoom = MuntainPeak
			targetWarp = "MountainToRobotMart"
			break
		case "TestToDarkTower":
			targetRoom = FirstFloor
			targetWarp = "TowerExit"
			break
		case "Elevator1":
			targetRoom = SecondFloor
			targetWarp = "TowerSecondFloorElevatorDOWN"
			break


	}

	warpName = name
	spawnDirection = spawnDir
	visible = show
}

function GetRoomName(roomID)
{
	switch roomID
	{
		case RouteMinusOneBottom:
		case RouteMinusOneTop:
			return "Route -1"
		case Mallet_Town:
		case Mallet_East:
		case Waterfront:
			return "Mallet Town"
		case TestRoom: return "Void"
		case GinkgoLab: return "Prof. Ginkgo's Lab"
		case ShadowPath:
		case ShadowTower:
			return "Shadow Path"
		case ShadowPokecenter: return "Pokémon Center"
		case MutantPath1: return "Mutant Path"
		case MorlockCity: 
		case MorlockCity2:
		case MorlockCity3:
			return "Morlock City"
		case MorlockGym: return "Mutant Path Gym"
		case RobotPath: 
		case MuntainPeak:
			return "Robot Path"
		case FirstFloor:
			return "Dark Tower - 1st Floor"
		case SecondFloor: return "2nd Floor"
		case ThirdFloor: return "3rd Floor"
		case FourthFloor: return "4th Floor"
		case FifthFloor: return "5th Floor"
		default: return "???"
	}
}

function GetRoomMusic()
{
	switch room
	{
		case TitleScreen: return TitleTheme
		case GinkgoIntro: return PokeGymLofi
		case RouteMinusOneBottom:
		case RouteMinusOneTop:
			return RouteMinusOneTheme
		case MutantPath1: return MutantPathAmbiance
		case TestTiltedRoom:
			return OuterRingOfAtlantis
		case MorlockCity:
		case MorlockCity2:
		case MorlockCity3:
			return MutantPathUndergroundTheme
		case TestRoom: return SacredBeasts
		case RegionCenter:
		case GinkgoLab:
			return PokeGymLofi
		case GashHouse: return SacredBeasts
		case GashUpstairs: return SacredBeasts
		case ShadowPath: return OathToOrder
		case ShadowPokecenter: return PokeGymLofi
		case ShadowTower: return OathToOrder
		case EmptyHouse: return ShadowPathAmbiance
		case ShadowPathGym: return PokeGymLofi
		case RobotPath: 
		case MuntainPeak:
			return ZoovacTutorialBotMusic
		case RobotGym: return WeaponsFactoryTheme
		case Mallet_Town:
		case Waterfront:
		case Mallet_East:
		case MalletMuseum:
			return MalletTownMusic
		case FirstFloor:
		case SecondFloor:
		case ThirdFloor:
		case FourthFloor:
		case FifthFloor:
		case Elevator1:
			return HyruleCastleRevision  
		default:
			return SacredBeasts
	}
}

function GetAreaEncounters(encounterType)
{
	var encounters = ds_list_create()
	switch (room)
	{
		case TestRoom:
			ds_list_add(encounters, "Charmander")
			break
		case Mallet_Town:
			ds_list_add(encounters, "Pikmin","Pikmin","Pikachu")
			break
		case RouteMinusOneBottom:
		case RouteMinusOneTop:
			ds_list_add(encounters, "Pikmin","Charmander","Pikachu","Squirtle","Bulbasaur")
			break
		case MutantPath1:
			ds_list_add(encounters, "Morlock","Morlock","Demo Dog","Demo Dog","Demogorgon","Ewok","Koopa")
			break
		case ShadowPath:
			if (encounterType == "Fog") ds_list_add(encounters, "Umbrian","Umbreon","Boo","Pac-Ghost")
			else if (encounterType == "Grass") ds_list_add(encounters, "Umbrian","Umbreon","Boo","Pac-Ghost")
			break
			
		default:
			ds_list_add(encounters, "Pikachu")
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
