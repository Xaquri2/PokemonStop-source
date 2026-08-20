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
			targetWarp = "MalletHouse2ToTest"
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
		case "TestToRobotCastle":
			targetRoom = MuntainPeak
			targetWarp = "MountainToRobotMart"
			break
		case "TestToDarkTower":
			targetRoom = FirstFloor
			targetWarp = "TowerExit"
			break
		case "SHORTCUT":
			targetRoom = MorlockCity //FifthFloor //RobotGym  //
			targetWarp = "MorlockEntranceALT" //"TowerFifthFloorElevatorDOWN" //"RobotGymDoor"////
			//targetRoom = MuntainPeak
			//targetWarp = "MountainPeakBottom"
			//targetRoom = ShadowPokecenter
			//targetWarp = "PokeCenterToShadow"
			break
			#endregion

		#region Mallet Town
		case "MalletHouse1ToTest":
			targetRoom = MaryHouse
			targetWarp = "MaryToMallet"
			break
		case "MaryHouseToUpstairs":
			targetRoom = MaryHouseUpstairs
			targetWarp = "MaryHouseUpstairsExit"
			break
		case "MaryHouseUpstairsExit":
			targetRoom = MaryHouse
			targetWarp = "MaryHouseToUpstairs"
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
		case "MinusOneToTower":
			targetRoom = FirstFloor
			targetWarp = "TowerExit"
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
		case "MorlockEntrance":
			targetRoom = TestTiltedRoom
			targetWarp = "TiltedToMorlock2"
			break
		
			//Morlock City		
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

			//Morlock City 2
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
			
		case "NebogipfelExit":
			targetRoom = MorlockCity
			targetWarp = "MorlockToNebogipfel"
			break

		case "MorlockToNebogipfel":
			targetRoom = NebogipfelsStudy
			targetWarp = "NebogipfelExit"
			break
			
		case "MorlockToTest":
			targetRoom = TestRoom
			targetWarp = "TestToMutant"
			break
		
		case "TiltedToMorlockALT":
			targetRoom = MorlockCity
			targetWarp = "MorlockEntranceALT"
			break

		case "MorlockEntranceALT":
			targetRoom = TestTiltedRoom
			targetWarp = "TiltedToMorlockALT"
			break
			#endregion
		
		#region TestTiltedRoom
		case "TiltedToMutant":
			targetRoom = MutantPath1
			targetWarp = "MutantToBuilding"
			break
		case "TiltedToMorlock":
			targetRoom = MorlockCity
			targetWarp = "MorlockEntrance"
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
		case "ShadowToShadowTower2":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToShadow"
			break
		case "ShadowToEmptyHouse":
			targetRoom = EmptyHouse
			targetWarp = "EmptyHouseToShadow"
			break
		case "ShadowTOPToGreed":
			targetRoom = GreedShop
			targetWarp = "GreedShopTOPToShadow"
			break
		case "ShadowBOTTOMToGreed":
			targetRoom = GreedShop
			targetWarp = "GreedShopBOTTOMToShadow"
			break
		case "PokeCenterToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToPokeCenter"
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
		case "ShadowTowerToShadow2":
			targetRoom = ShadowPath
			targetWarp = "ShadowToShadowTower"
			break
		case "ShadowTowerToShadow":
			targetRoom = ShadowPath
			targetWarp = "ShadowToShadowTower"
			break
		case "ShadowTowerToUnderroom1":
			targetRoom = Underroom1
			targetWarp = "ShadowUnderroom1Exit"
			break
		case "ShadowTowerToUnderroom2":
			targetRoom = Underroom2
			targetWarp = "Underroom2exit"
			break

		#endregion

		#region Underrooms
		case "ShadowUnderroom1Exit":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToUnderroom1"
			break
		case "Underroom2exit":
			targetRoom = ShadowTower
			targetWarp = "ShadowTowerToUnderroom2"
			break
		case "Underroom2to1":
			targetRoom = Underroom1
			targetWarp = "Underroom1toUnderroom2"
			break

		case "Underroom1toUnderroom2":
			targetRoom = Underroom2
			targetWarp = "Underroom2to1"
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
		
		#region MaryHouse
		case "MaryToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletHouse1ToTest"
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
		#endregion
		
		#region RobotPath
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
			#endregion
		
		#region DarkTower
		case "TowerExit":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToTower"
			break

	//	case "TowerFirstFloorElevator":
	//		targetRoom = SecondFloor
	//		targetWarp = "TowerSecondFloorElevatorDown"
	//		break
		case "TowerFirstFloorElevator":
			targetRoom = Elevator1
			targetWarp = "Elevator1"
			break

		case "TowerSecondFloorElevatorDOWN":
			targetRoom = FirstFloor
			targetWarp = "TowerFirstFloorElevator"
			break
		case "TowerSecondFloorElevatorUP":
			targetRoom = Elevator2
			targetWarp = "Elevator2"
			//targetRoom = ThirdFloor
			//targetWarp = "TowerThirdFloorElevatorDOWN"
			break

		case "TowerThirdFloorElevatorDOWN":
			targetRoom = SecondFloor
			targetWarp = "TowerSecondFloorElevatorUP"
			break
		case "TowerThirdFloorElevatorUP":
			targetRoom = Elevator3
			targetWarp = "Elevator3"
			//targetRoom = FourthFloor
			//targetWarp = "TowerFourthFloorElevatorDOWN"
			break

		case "TowerFourthFloorElevatorDOWN":
			targetRoom = ThirdFloor
			targetWarp = "TowerThirdFloorElevatorUP"
			break
		case "TowerFourthFloorElevatorUP":
			targetRoom = Elevator4
			targetWarp = "Elevator4"
			//targetRoom = FifthFloor
			//targetWarp = "TowerFifthFloorElevatorDOWN"
			break

		case "TowerFifthFloorElevatorDOWN":
			targetRoom = FourthFloor
			targetWarp = "TowerFourthFloorElevatorUP"
			break

		case "Elevator1":
			targetRoom = SecondFloor
			targetWarp = "TowerSecondFloorElevatorDOWN"
			break
		case "Elevator2":
			targetRoom = ThirdFloor
			targetWarp = "TowerThirdFloorElevatorDOWN"
			break
		case "Elevator3":
			targetRoom = FourthFloor
			targetWarp = "TowerFourthFloorElevatorDOWN"
			break
		case "Elevator4":
			targetRoom = FifthFloor
			targetWarp = "TowerFifthFloorElevatorDOWN"
			break
			#endregion

		#region Misc. 


		case "NestRoomToOrigin":
			targetRoom = GameObject.previousRoom
			targetWarp = "Random"
			break


		#endregion
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
		case MaryHouse: return "Mary's House"
		default: return "???"
	}
}

function GetRoomMusic()
{
	switch room
	{
		case TitleScreen: return TitleTheme
		case GinkoIntroRoom: return PokeGymLofi
		case RouteMinusOneBottom:
		case RouteMinusOneTop:
			return RouteMinusOneTheme
		case EndCreditsRoom: return RouteMinusOneTheme
			
		// Mutant Path 
		case MutantPath1: return MutantPathAmbiance
		case TestTiltedRoom:
			return OuterRingOfAtlantis
		case MorlockCity:
		case MorlockCity2:
		case MorlockCity3:
		case MorlockShop: 
			return MutantPathUndergroundTheme
		case MorlockRestaurant: return BoostersTower
		case MutantPokecenter: return PokeGymLofi
		case MorlockGym: return OuterRingOfAtlantis
		
		case TestRoom: return SacredBeasts
		
		// Mallet Town
		case Mallet_Town:
		case Waterfront:
		case Mallet_East:
		case MalletMuseum:
			return MalletTownMusic
		case RegionCenter:
		case GinkgoLab:
			return PokeGymLofi
		case GashHouse: return SacredBeasts
		case GashUpstairs: return SacredBeasts
		case Mallet_East_ENDCREDITS: return SwordDescends
		
		//Shadow Path
		case ShadowPath: return OathToOrder
		case ShadowPokecenter: return PokeGymLofi
		case ShadowTower: return OathToOrder
		case EmptyHouse: return ShadowPathAmbiance
		case ShadowPathGym: return CreepyLullabyNoVocal
		case Underroom1: 
		case Underroom2:
			return InsideTheDekuTreeOoT
		
		//Robot Path
		case RobotPath: 
			return ZoovacTutorialBotMusic
		case MuntainPeak:	
		case RobotPathShop:
		case RobotGym: 
			return WeaponsFactoryTheme
		case PokeCenterRobotPath:
			return PokeGymLofi
		
		//Dark Tower
		case FirstFloor:
		case SecondFloor:
		case ThirdFloor:
		case FourthFloor:
		case FifthFloor:
		case Elevator1:
		case Elevator2:
		case Elevator3:
		case Elevator4:
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
			ds_list_add(encounters, "Pikmin","Charmander","Pikachu","Squirtle","Creeper")
			break
		case MutantPath1:
			ds_list_add(encounters, "Morlock","Morlock","Demo Dog","Demo Dog","Demogorgon","Ewok","Koopa")
			if HasFlag("SkullBattle") {
				ds_list_add(encounters, "Silver Scorpion","Silver Scorpion","Silver Scorpion","Silver Scorpion","Silver Scorpion",)
			}
			break
		case ShadowPath:
			if (encounterType == "Fog") ds_list_add(encounters, "Umbrian","Umbreon","Boo","Pac-Ghost")
			else if (encounterType == "Grass") ds_list_add(encounters, "Umbrian","Umbreon","Boo","Pac-Ghost")
			break
		case RobotPath:
			ds_list_add(encounters, "Baby","Baby","Baby","Box Bot","Voltorb","Voltorb","Tektite","Tutorial Bot")
			if HasFlag("SkullBattle") {
				ds_list_add(encounters, "Silver Scorpion")
			}
			break
			
		default:
			ds_list_add(encounters, "Pikachu")
	}
	return encounters
}

function GetRoomCutscene(n)
{
	switch (n)
	{
		case ShadowPathGym:
			if (!HasFlag("HasVisitedShadowGym")) return "ShadowGymCutscene.mp4"
			else return ""
		case SecondFloor: return "Elevator1To2.mp4"
		case ThirdFloor: return "Elevator2To3.mp4"
		case FourthFloor: return "Elevator3To4.mp4"
		case FifthFloor: return "Elevator4To5.mp4"
		default:
			return ""
	}
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

function BattleHasBackground()
{
	var battle = instance_find(BattleObject, 0)
	var prevRoomName = string_replace(room_get_name(battle.playerRoom), "ref room ", "")
	var enemy = battle.enemyName;
	switch (prevRoomName)
	{
		case "ShadowPathGym":
		case "RobotGym": return string_concat(prevRoomName, "Background")
		case "MorlockGym": 
			if (enemy == "Gorbertron") return string_concat(prevRoomName, "Background");
			else return "";
		case "FifthFloor": return string_concat(prevRoomName, "Background")
		
		default: return ""
	}
}

function BattleHasBackground2()
{
	var battle = instance_find(BattleObject, 0)
	var prevRoomName = string_replace(room_get_name(battle.playerRoom), "ref room ", "")
	var enemy = battle.enemyName;
	switch (prevRoomName)
	{
		case "FifthFloor": return "ZoovacLandscapeBackground"
		
		default: return ""
	}
}

function BattleHasFX()
{
	var battle = instance_find(BattleObject, 0)
	var prevRoomName = string_replace(room_get_name(battle.playerRoom), "ref room ", "")
	var enemy = battle.enemyName;
	switch (prevRoomName)
	{
		//case "ShadowPathGym":
		case "ShadowPathGym":
		case "RobotGym": return string_concat(prevRoomName, "FX")
		case "MorlockGym": 
		if (enemy == "Gorbertron") return string_concat(prevRoomName, "FX")
		
		default: return ""
	}
}

function GetNestRoomTileType(ogRoom)
{
	switch (ogRoom)
	{
		case GashUpstairs: return GreenCross
		default:
			return GreenTileSprite
	}
}

function GetNestRoomPokemonType(ogRoom)
{
	switch (ogRoom)
	{
		/*case TestRoom:
			var pool = ds_list_create()
			ds_list_add(pool, "Pikachu", "Pikachu", "Pikachu", "Squirtle")
			return ds_list_find_value(pool, irandom(ds_list_size(pool)-1))
		*/
		
		default:
			var pool = ds_list_create()
			ds_list_add(pool, "Pikachu", "Pikachu", "Pikachu", "Squirtle")
			return ds_list_find_value(pool, irandom(ds_list_size(pool)-1))
	}
}

function GetAreaKeyOrigin(keyName)
{
	switch (keyName)
	{
		case "Test Area Key": return TestRoom
		
		default: return Mallet_Town
	}
}