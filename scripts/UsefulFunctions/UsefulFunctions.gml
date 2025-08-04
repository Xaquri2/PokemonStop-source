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
			if (j == 6 or j == 7)
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
	
	var saveState = {
		playerX: player.x, 
		playerY: player.y, 
		roomInfo: room, 
		party: partyArray,
		beatenTrainers: beatenTrainerArray
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
		
		ds_list_clear(global.pokemonList)
		ds_list_clear(global.playerParty)
		for (var i = 0; i < array_length(saveState.party); i++)
		{
			var pkmnInfo = ds_list_create()
			var pkmnArray = saveState.party[i]
			
			for (j = 0; j < array_length(saveState.party[i]); j++)
			{
				if (j == 6 or j == 7)
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
	}
}

function ConvertListToArray(list)
{
	var arr = []
	for (var i = 0; i < ds_list_size(list); i++)
	{
		var element = ds_list_find_value(list, i)
		arr[i] = element
	}
	return arr
}

function CenterTextPosition()
{
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
}

function ResetTextPosition()
{
	draw_set_halign(fa_left)
	draw_set_valign(fa_top)
}

function GetNumberFormat(num)
{
	var str = string(num)
	var zeroList = ds_list_create()
	for (var i = 10; i < 1000; i *= 10)
	{
		if (num < i)
		{
			ds_list_add(zeroList, "0")
		}
	}
	
	for (var i = 0; i < ds_list_size(zeroList); i++)
	{
		str = string_concat("0", str)
	}
	
	str = string_concat("#", str)
	return str
}

function SaveStateAction(stateNumber)
{
	var text = instance_create_depth(x,bbox_top-10,depth,TextPopupObject)
	text.text = string_concat("Loaded Save State ", stateNumber)

	global.currentSaveState = int64(stateNumber)
	if (keyboard_check(vk_shift)) 
	{
		var game = instance_find(GameObject, 0)
		if (instance_exists(game)) with (game) SaveData()
		text.text = string_concat("Saved Save State ", stateNumber)
	}
	else 
	{	
		var game = instance_find(GameObject, 0)
		if (instance_exists(game)) with (game) LoadData()
		game.warp = true
		game.fade = true

		if (game.loadRoom != noone) game.targetRoom = game.loadRoom
		else game.targetRoom = Mallet_Town
	}
}