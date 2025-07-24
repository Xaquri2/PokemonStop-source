function SaveData()
{
	var player = instance_find(PlayerObject, 0)
	
	var beatenTrainerArray = []
	for (var i = 0; i < ds_list_size(global.beatenTrainers); i++)
	{
		var element = ds_list_find_value(global.beatenTrainers, i)
		beatenTrainerArray[i] = element
	}
	
	var save_data = {
		playerX: player.x,
		playerY: player.y,
		room: room,
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
		
		loadRoom = data.room
		loadX = data.playerX
		loadY = data.playerY
	}
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