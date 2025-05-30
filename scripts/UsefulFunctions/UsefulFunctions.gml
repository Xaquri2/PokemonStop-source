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