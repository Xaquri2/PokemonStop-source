function SaveData()
{
	var player = instance_find(PlayerObject, 0)

	var pokemonCollectionArray = []
	for (var i = 0; i < ds_list_size(global.pokemonList); i++)
	{
		var pkmnArray = []
		var pkmn = GetPartyMemberInfo(global.pokemonList, i)
		for (var j = 0; j < ds_list_size(pkmn); j++)
		{
			if (j == 6 or j == 7 or j == 10)
			{
				var list = ds_list_find_value(pkmn, j)
				var array = []

				for (var k = 0; k < ds_list_size(list); k++)
				{
					array[k] = ds_list_find_value(list, k)
				}

				pkmnArray[j] = array
			}
			else pkmnArray[j] = ds_list_find_value(pkmn, j)
		}
		pokemonCollectionArray[i] = pkmnArray
	}

	var beatenTrainerArray = ConvertListToArray(global.beatenTrainers)
	var npcFlagsMatrix = ConvertMapToMatrix(global.npcFlags)
	var collectedPokelootArray = ConvertListToArray(global.collectedPokeloot)
	var flagsArray = ConvertListToArray(global.flags)
	var activatedBadgesArray = ConvertListToArray(global.activatedBadges)
	var inventoryArray = array_create(5)

	for (var i = 0; i < ds_list_size(global.categoryItemList); i++)
	{
		var categoryList = ds_list_find_value(global.categoryItemList, i)
		var categoryArray = array_create(ds_list_size(categoryList))

		for (var j = 0; j < ds_list_size(categoryList); j++)
		{
			var itemList = ds_list_find_value(categoryList, j)

			var itemArray = array_create(2)
			array_set(itemArray, 0, ds_list_find_value(itemList, 0))
			array_set(itemArray, 1, ds_list_find_value(itemList, 1))

			array_set(categoryArray, j, itemArray)
		}

		array_set(inventoryArray, i, categoryArray)
	}
	
	var partyCatchIndexList = ds_list_create()
	for (var i = 0; i < ds_list_size(global.playerParty); i++)
	{
		var pkmnInfo = ds_list_find_value(global.playerParty, i)
		ds_list_add(partyCatchIndexList, GetCatchIndex(pkmnInfo))
	}
	var partyCatchIndexArray = ConvertListToArray(partyCatchIndexList)
	ds_list_destroy(partyCatchIndexList)
	
	var timestampString = ""
	var currentTime = date_current_datetime()
	var hour = date_get_hour(currentTime)
	var minute = date_get_minute(currentTime)
	var day = date_get_day(currentTime)
	var month = date_get_month(currentTime)
	var year = date_get_year(currentTime)
	timestampString = string_concat(year, "-", month < 10 ? "0" : "", month, "-", day < 10 ? "0" : "", day, " ", hour < 10 ? "0" : "", hour, ":", minute < 10 ? "0" : "", minute)

	var saveState = {
		money: global.money,
		playerX: player.x,
		playerY: player.y,
		roomInfo: room,
		partyIndexes: partyCatchIndexArray,
		pokemonCollection: pokemonCollectionArray,
		inventory: inventoryArray,
		beatenTrainers: beatenTrainerArray,
		npcFlags: npcFlagsMatrix,
		flags: flagsArray,
		activatedBadges: activatedBadgesArray,
		collectedPokeloot: collectedPokelootArray,
		latestSaveState: global.latestSaveState,
		saveSlotTimestamp: timestampString,
		followerType: global.followerType,
		pikminCount: global.pikminCount,
		catchIndex: global.catchIndex,
		lastKeyUsed: global.lastKeyUsed,
		nestReturnRoom: nestReturnRoom,
		morlockTimer: global.morlockTimer
	}

	var fileName = string_concat("savefile", global.saveFile, ".json")
	if (file_exists(fileName))
	{
		var file = file_text_open_read(fileName);
	    var json = file_text_read_string(file);
	    file_text_close(file);

	    var data = json_parse(json);

		switch (global.currentSaveState)
		{
			case 1:
				data.saveState1 = saveState
				break
			case 2:
				data.saveState2 = saveState
				break
			case 3:
				data.saveState3 = saveState
				break
			case 4:
				data.saveState4 = saveState
				break
			case 5:
				data.saveState5 = saveState
				break
		}

		json = json_stringify(data)
		file = file_text_open_write(fileName)
		file_text_write_string(file, json)
		file_text_close(file)
	}
	else
	{
		var save_data = { }
		switch (global.currentSaveState)
		{
			case 1:
				save_data = { saveState1: saveState }
				break
			case 2:
				save_data = { saveState2: saveState }
				break
			case 3:
				save_data = { saveState3: saveState }
				break
			case 4:
				save_data = { saveState4: saveState }
				break
			case 5:
				save_data = { saveState5: saveState }
				break
		}

		var json = json_stringify(save_data)
		var file = file_text_open_write(fileName)
		file_text_write_string(file, json)
		file_text_close(file)
	}
}

function LoadData()
{
	var fileName = string_concat("savefile", global.saveFile, ".json")
	if (file_exists(fileName))
	{
	    var file = file_text_open_read(fileName);
	    var json = file_text_read_string(file);
	    file_text_close(file);

	    var data = json_parse(json);
		var saveState = noone
		
		
		switch (global.currentSaveState)
		{
			case 1:
				if (variable_struct_exists(data, "saveState1"))
					saveState = data.saveState1
				break

			case 2:
				if (variable_struct_exists(data, "saveState2"))
					saveState = data.saveState2
				break

			case 3:
				if (variable_struct_exists(data, "saveState3"))
					saveState = data.saveState3
				break

			case 4:
				if (variable_struct_exists(data, "saveState4"))
					saveState = data.saveState4
				break

			case 5:
				if (variable_struct_exists(data, "saveState5"))
					saveState = data.saveState5
				break
		}

		if (saveState == noone)
		{
// 			show_debug_message("Save state does not exist: " + string(global.currentSaveState))
			return
		}

		ds_list_clear(global.collectedPokeloot)
		ds_list_clear(global.activatedBadges)
		ds_list_clear(global.beatenTrainers)
		ds_list_clear(global.flags)
		ds_map_clear(global.npcFlags)

		for (var i = 0; i < array_length(saveState.beatenTrainers); i++)
		{
			ds_list_add(global.beatenTrainers, saveState.beatenTrainers[i])
		}

		for (var i = 0; i < array_length(saveState.flags); i++)
		{
			ds_list_add(global.flags, saveState.flags[i])
		}
		
		// Older saves have no temporary-effect fields. Reset them rather than
		// inheriting a key or potion countdown from the previously loaded game.
		global.lastKeyUsed = variable_struct_exists(saveState, "lastKeyUsed") ? saveState.lastKeyUsed : ""
		areaKeyInfo = global.lastKeyUsed
		nestReturnRoom = variable_struct_exists(saveState, "nestReturnRoom") ? saveState.nestReturnRoom : global.standardStartRoom
		global.morlockTimer = variable_struct_exists(saveState, "morlockTimer") ? max(0, floor(saveState.morlockTimer)) : 0
		global.playerGhost = HasFlag("PlayerGhost")
        with (PlayerObject) UpdatePlayerAppearance()

        for (var i = 0; i < array_length(saveState.activatedBadges); i++)
		{
			ds_list_add(global.activatedBadges, saveState.activatedBadges[i])
		}

		for (var i = 0; i < array_length(saveState.npcFlags); i++)
		{
			var key = saveState.npcFlags[i][0]
			var value = saveState.npcFlags[i][1]
			SetNPCFlag(key, value)
		}

		for (var i = 0; i < array_length(saveState.collectedPokeloot); i++)
		{
			ds_list_add(global.collectedPokeloot, saveState.collectedPokeloot[i])
		}

		for (var i = 0; i < array_length(saveState.inventory); i++)
		{
			var categoryList = ds_list_create()
			var categoryArray = saveState.inventory[i]

			for (var j = 0; j < array_length(categoryArray); j++)
			{
				var itemArray = categoryArray[j]
				var itemList = ds_list_create()
// 				if (itemArray[0] == "Potion") show_debug_message("[Inventory] Loading Potion stock from save: " + string(itemArray[1]))

				ds_list_add(itemList, itemArray[0], itemArray[1])
				ds_list_add(categoryList, itemList)
			}

			ds_list_set(global.categoryItemList, i, categoryList)
		}
		
		ds_list_clear(global.pokemonList)
		for (var i = 0; i < array_length(saveState.pokemonCollection); i++)
		{
			var pkmnInfo = ds_list_create()
			var pkmnArray = saveState.pokemonCollection[i]

			for (var j = 0; j < array_length(saveState.pokemonCollection[i]); j++)
			{
				if (j == 6 or j == 7 or j == 10)
				{
					var list = ds_list_create()

					var array = pkmnArray[j]
					for (k = 0; k < array_length(array); k++)
					{
						ds_list_add(list, array[k])
					}

					ds_list_add(pkmnInfo, list)
				}
				else ds_list_add(pkmnInfo, pkmnArray[j])
			}

			AddPokemonSpecific(pkmnInfo)
		}
		
		ds_list_clear(global.playerParty)
		for (var i = 0; i < array_length(saveState.partyIndexes); i++)
		{
			for (var j = 0; j < ds_list_size(global.pokemonList); j++)
			{
				var pkmnInfo = ds_list_find_value(global.pokemonList, j)
				var catchIndex = GetCatchIndex(pkmnInfo)
				if (catchIndex == saveState.partyIndexes[i])
				{
					ds_list_add(global.playerParty, pkmnInfo)
					break
				}
			}
		}
		
		loadRoom = saveState.roomInfo
		loadX = saveState.playerX
		loadY = saveState.playerY

		global.money = saveState.money
		global.latestSaveState = saveState.latestSaveState
		
		global.followerType = saveState.followerType
		global.pikminCount = saveState.pikminCount
		global.catchIndex = saveState.catchIndex

		// The original Shadow Tower pickup set "Item", leaving "item" blank.
		// Its old tag proves it was collected without awarding the X Defense.
		if (ds_list_find_index(global.collectedPokeloot, "ShadowTowreXDefense") != -1
		and ds_list_find_index(global.collectedPokeloot, "ShadowTowerXDefense") == -1)
		{
			AddItem("X Defense", 1)
			ds_list_add(global.collectedPokeloot, "ShadowTowerXDefense")
		}
	}
	
	ds_list_clear(global.pcPokemonList)
	if (ds_list_empty(global.pcPokemonList) and !ds_list_empty(global.pokemonList))
	{
		for (var i = 0; i < ds_list_size(global.pokemonList); i++)
		{
			var attempt = ds_list_find_value(global.pokemonList, i)
			if (ds_list_find_index(global.playerParty, attempt) == -1) ds_list_add(global.pcPokemonList, attempt)
		}
	}
}

function SaveStateAction(stateNumber, actionMode)
{
	var text = string_concat("Loaded Save State ", stateNumber)

	global.currentSaveState = int64(stateNumber)
	if (actionMode == "Save")
	{
		var game = instance_find(GameObject, 0)
		if (instance_exists(game)) with (game) SaveData()
		text = string_concat("Saved Save State ", stateNumber)
	}
	else
	{
		var game = instance_find(GameObject, 0)
		if (instance_exists(game)) with (game) LoadData()
		if (room == TitleScreen) audio_stop_sound(TitleTheme)
		game.targetWarp = "None"
		game.warp = true
		game.fade = true

		if (game.loadRoom != noone)
		{
			game.targetRoom = game.loadRoom
		}
		else game.targetRoom = global.standardStartRoom
	}

	GenerateTextPopup(x,bbox_top-10,text)
}

function GetSaveSlotTimestamp(slot)
{
	var fileName = string_concat("savefile", slot, ".json")
	if (file_exists(fileName))
	{
	    var file = file_text_open_read(fileName);
	    var json = file_text_read_string(file);
	    file_text_close(file);

	    var data = json_parse(json);
		var saveState = noone
		switch (slot)
		{
			case 1:
				if (variable_struct_exists(data, "saveState1")) saveState = data.saveState1
				break
			case 2:
				if (variable_struct_exists(data, "saveState2")) saveState = data.saveState2
				break
			case 3:
				if (variable_struct_exists(data, "saveState3")) saveState = data.saveState3
				break
			case 4:
				if (variable_struct_exists(data, "saveState4")) saveState = data.saveState4
				break
			case 5:
				if (variable_struct_exists(data, "saveState5")) saveState = data.saveState5
				break
		}

		if (saveState != noone)
		{
			var timestamp = saveState.saveSlotTimestamp
			// Older saves stored H:M D/M/YYYY. Display those in ISO order too.
			var parts = string_split(timestamp, " ")
			if (array_length(parts) == 2)
			{
				var dateParts = string_split(parts[1], "/")
				var timeParts = string_split(parts[0], ":")
				if (array_length(dateParts) == 3 and array_length(timeParts) == 2)
				{
					return string_concat(dateParts[2], "-",
						string_length(dateParts[1]) == 1 ? "0" : "", dateParts[1], "-",
						string_length(dateParts[0]) == 1 ? "0" : "", dateParts[0], " ",
						string_length(timeParts[0]) == 1 ? "0" : "", timeParts[0], ":",
						string_length(timeParts[1]) == 1 ? "0" : "", timeParts[1])
				}
			}
			return timestamp
		}
		else return undefined
	}
}
