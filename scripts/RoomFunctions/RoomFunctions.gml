function SetWarpDefaults(name)
{
	switch (name)
	{
		case "TestToMallet":
			targetRoom = Mallet_Town
			targetWarp = "MalletToTest"
			break
		case "MalletToTest":
			targetRoom = TestRoom
			targetWarp = "TestToMallet"
		case "MalletToMinusOne":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MalletToMinusOne"
		case "MinusOneToMallet":
			targetRoom = RouteMinusOneBottom
			targetWarp = "MinusOneToMallet"
	}
	warpName = name
}

function GetRoomName()
{
	switch room
	{
		case Mallet_Town: return "Mallet Town"
		case TestRoom: return "Void"
	}
	return ""
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