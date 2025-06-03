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
	}
	warpName = name
}