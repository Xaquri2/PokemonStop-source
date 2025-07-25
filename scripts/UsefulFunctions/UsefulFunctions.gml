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
	
	var save_data = {
		playerX: player.x,
		playerY: player.y,
		room: room,
		party: partyArray,
		beatenTrainers: beatenTrainerArray
	}

	var json = json_stringify(save_data)
	var file = file_text_open_write("savefile.json")
	file_text_write_string(file, json)
	file_text_close(file)
}

function LoadData()
{
	if (file_exists("savefile.json")) 
	{
	    var file = file_text_open_read("savefile.json");
	    var json = file_text_read_string(file);
	    file_text_close(file);

	    var data = json_parse(json);
		
		for (var i = 0; i < array_length(data.beatenTrainers); i++)
		{
			ds_list_add(global.beatenTrainers, data.beatenTrainers[i])
		}
		
		ds_list_clear(global.pokemonList)
		for (var i = 0; i < array_length(data.party); i++)
		{
			var pkmnInfo = ds_list_create()
			var pkmnArray = data.party[i]
			
			for (j = 0; j < array_length(data.party[i]); j++)
			{
				if (j == 6 or j == 7)
				{
					var list = ds_list_create()
										
					var array = pkmnArray[j]
					for (k = 0; k < array_length(array); k++)
					{
						ds_list_add(list, array[k])
					}
					
					ds_list_add(pkmnInfo, array)
				}
				else ds_list_add(pkmnInfo, pkmnArray[j])
			}
			
			AddPokemonSpecific(pkmnInfo)
		}
		
		loadRoom = data.room
		loadX = data.playerX
		loadY = data.playerY
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