function SaveData()
{
	var player = instance_find(PlayerObject, 0)

	var partyArray = []
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
		partyArray[i] = pkmnArray
	}

	var beatenTrainerArray = ConvertListToArray(global.beatenTrainers)
	var npcFlagsMatrix = ConvertMapToMatrix(global.npcFlags)
	var collectedPokelootArray = ConvertListToArray(global.collectedPokeloot)
	var flagsArray = ConvertListToArray(global.flags)
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

	var timestampString = ""
	var currentTime = date_current_datetime()
	var hour = date_get_hour(currentTime)
	var minute = date_get_minute(currentTime)
	var day = date_get_day(currentTime)
	var month = date_get_month(currentTime)
	var year = date_get_year(currentTime)
	timestampString = string_concat(hour, ":", minute, " ", day, "/", month, "/", year)

	var saveState = {
		money: global.money,
		playerX: player.x,
		playerY: player.y,
		roomInfo: room,
		party: partyArray,
		inventory: inventoryArray,
		beatenTrainers: beatenTrainerArray,
		npcFlags: npcFlagsMatrix,
		flags: flagsArray,
		collectedPokeloot: collectedPokelootArray,
		latestSaveState: global.latestSaveState,
		saveSlotTimestamp: timestampString
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
		var saveState = data.saveState1 //Always loads first save state slot

		for (var i = 0; i < array_length(saveState.beatenTrainers); i++)
		{
			ds_list_add(global.beatenTrainers, saveState.beatenTrainers[i])
		}

		for (var i = 0; i < array_length(saveState.flags); i++)
		{
			ds_list_add(global.flags, saveState.flags[i])
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

				ds_list_add(itemList, itemArray[0], itemArray[1])
				ds_list_add(categoryList, itemList)
			}

			ds_list_set(global.categoryItemList, i, categoryList)
		}

		ds_list_clear(global.pokemonList)
		ds_list_clear(global.playerParty)
		for (var i = 0; i < array_length(saveState.party); i++)
		{
			var pkmnInfo = ds_list_create()
			var pkmnArray = saveState.party[i]

			for (var j = 0; j < array_length(saveState.party[i]); j++)
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

		loadRoom = saveState.roomInfo
		loadX = saveState.playerX
		loadY = saveState.playerY

		global.money = saveState.money
		global.latestSaveState = saveState.latestSaveState
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
		game.warp = true
		game.fade = true

		if (game.loadRoom != noone)
		{
			game.targetRoom = game.loadRoom
		}
		else game.targetRoom = Mallet_Town
	}

	GenerateTextPopup(x,bbox_top-10,text)
}

function GetSaveSlotTimestamp(slot)
{
	var fileName = string_concat("savefile", global.saveFile, ".json")
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

		if (saveState != noone) return saveState.saveSlotTimestamp
		else return undefined
	}
}
