if (charNumber < string_length(ds_list_find_value(textList, currentText)))
{
	charNumber = string_length(ds_list_find_value(textList, currentText))
	charCounter = 0
}
else
{
	if (currentText+1 >= ds_list_size(textList))
	{
		var player = instance_find(PlayerObject, 0)
		player.alarm[1] = 1
		instance_destroy(id)
	}
	else
	{
		currentText++
		charCounter = 0
		charNumber = 0
	}
}